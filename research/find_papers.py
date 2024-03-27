import requests
import sys
import os
import json
import threading
from concurrent.futures import ThreadPoolExecutor,wait,ALL_COMPLETED,FIRST_COMPLETED, as_completed

dblp_src="https://dblp.org/db/conf/"
conference_list="dac date isca micro aspdac iccad hpca asplos".split(' ')

def echoHelp():
    print("Usage:\n"\
        "\t1. Search all conferences in specific year\n"\
        "\t<year_args> <key_args>\n"\
        "\t2. Search specific conference in specific year. Support single year and <start-end> format\n"\
        "\t<year-args> <conf-args> <key_args>\n"\
        "\n\t<year_args>: <start>-<end> or <single-year> or <start_year:month-end_year:month> or <year1,year2,...yearN>\n"\
        "\t<conf_args>: <conference-name> or <conference-directory>-<conference-key>\n"\
        "\t<key_args> : key1,key2,...,keyN\n"\
        "\nExample:\n"\
        "\tbash find_papers 2023-2024-1 asplos quantum"
    )

def parserKey(argvStr):
    strList = None
    if '-' in argvStr:
        strList = argvStr.split('-')
    elif ',' in argvStr:
        strList = argvStr.split(',')
    else:
        strList=[argvStr]
    #/print("argvList",strList)
    return strList

def parserTime(timeStr):
    if '-' in timeStr and ',' in timeStr:
        echoHelp()
        exit()
    timeList = parserKey(timeStr)

    yearAndMonth = [] 
    for year in timeList:
        yearMonths=year.split(':')
        monthStart = 1
        monthEnd = 12
        for item in yearMonths:
            if not item.isdigit():
                echoHelp()
                exit()
        year = int(yearMonths[0])
        if len(yearMonths)==2:
            monthStart = monthEnd = int(yearMonths[1])
        elif len(yearMonths)==3:
            monthStart = int(yearMonths[1])
            monthEnd = int(yearMonths[2])
            if(monthStart>monthEnd):
                monthStart = monthStart+monthEnd
                monthEnd = monthStart-monthEnd
                monthStart = monthStart-monthEnd

        if len(yearMonths)>3 or monthStart<1 or monthEnd<1:
            echoHelp();
            exit();
        yearAndMonth.append([year,monthStart,monthEnd])
    #print("parserTime",yearAndMonth)
    return yearAndMonth

def testKey(srcStr,keyList):
    srcStr_lower = srcStr.lower()
    for key in keyList:
        if(srcStr_lower.find(key.lower()))==-1:
            return False
    return True

def parserJson(jsonStr,keyList):
    data = json.loads(jsonStr)
    #print(data)
    #print(len(data['result']["hits"]["hit"]))
    try:
        #print(data['result']["hits"]["@total"])
        if int(data['result']["hits"]["@total"]) > 0:
            for item in data['result']["hits"]["hit"]:
                title = item["info"]["title"];
                #doi = item["info"]["doi"]
                doi = item["info"]["ee"]
                if testKey(title,keyList):
                    print(title,doi)
    except Exception as e:
        print("解析数据时发生异常",e)

def getFile(url,cacheFile):
    if os.path.exists(cacheFile):
        with open(cacheFile, 'r') as file:
            content = file.read();
        file.close()
        return content
    else:
        response = requests.get(url)
        if response.status_code == 200:
            # 将响应内容保存到文件
            with open(cacheFile, 'wb') as f:
                f.write(response.content)
            print('响应已保存到 '+cacheFile+' 文件中')
            return response.content
        else:
            print('请求失败：', response.status_code, url)
    return None



def search(yearList,confList,keyList):
    #print(len(confList))
    cacheDir = '.cache'
    os.makedirs(cacheDir,exist_ok=True)
    urlList = []
    fileNameList = []
    for yearMonths in yearList:
        #for m in range(yearMonths[1],yearMonths[2]+1):
            for conf in confList:
                #url = "%s%s/%s%d-%d.html" % (dblp_src,conf,conf,yearMonths[0],m)
                url = "%s%s/%s%d.html" % (dblp_src,conf,conf,yearMonths[0])
                url = "https://dblp.org/search/publ/api?q=toc:db/conf/%s/%s%d.bht:&h=1000&format=json" % (conf,conf,yearMonths[0])
                fileName = "%s/%s_%d.json" % (cacheDir,conf,yearMonths[0])
                #print(conf,url,fileName)
                urlList.append(url)
                fileNameList.append(fileName)
                #content = getFile(url,fileName)
                #if content is not None:
                #    parserJson(content,keyList)
                #/local link="${dblp_src}${conf_dir}/${conf_key}${y}${suffix}.html"
    all_task = []
    #dblp有访问限制,线程超过2个就会被限制访问 1分钟
    with ThreadPoolExecutor(max_workers=2) as pool:
        for i in range(len(urlList)):
            #print(urlList[i]+" "+fileNameList[i])
            all_task.append(pool.submit(getFile, urlList[i], fileNameList[i]))
        for future in as_completed(all_task):
            if future is not None:
                parserJson(future.result(),keyList)
                #print("~~~~~~~~~~~~~~~~~~~~~~~~")
                #print(future.result(),"{future.result()} 返回")
                #print("~~~~~~~~~~~~~~~~~~~~~~~~")
        wait(all_task, return_when=FIRST_COMPLETED)
        #print("----complete-----")   
    #print("searchMonth",yearList,confList,keyList)

def main():
    #print(sys.argv[0])
    #print(sys.argv[1:])
    if len(sys.argv)<=2 or len(sys.argv)>4:
        echoHelp()
        exit()
    
    if len(sys.argv) ==3:
        search(parserTime(sys.argv[1]),conference_list,parserKey(sys.argv[2]))
    elif len(sys.argv) ==4:
        search(parserTime(sys.argv[1]),parserKey(sys.argv[2]),parserKey(sys.argv[3]))

if __name__ == "__main__":
    main()
