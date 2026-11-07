# Print PDF Names

只为普通网页 `Ctrl+P → 另存为 PDF` 提供规范默认名称的 Chrome / Edge 扩展。打印前临时修改网页标题，打印预览关闭（包括取消）后恢复；不扫描文件、不修改已保存文件、不接管下载。

## 安装

1. 打开 `chrome://extensions`（Chrome）或 `edge://extensions`（Edge）。
2. 开启「开发者模式」，点击「加载已解压的扩展程序」。
3. 选择 `D:\utils\dev\tools\print-pdf-names-extension`。
4. **刷新已经打开的网页**，使页面脚本生效。
5. 按 `Ctrl+P`，目标选择浏览器内置的「另存为 PDF」，点击保存，检查默认名称。

更新扩展后，需要在扩展管理页点击重新加载，并刷新目标网页。开发者模式加载后不要移动此目录。

## 行为

例如网页标题 `My_Page: Title`，默认建议名称为 `2026-11-07-My-Page-Title.pdf`。

- 日期使用发起打印时的本地日期；已有有效日期前缀时保留，多重日期合并为第一个。
- 保留 Unicode 字母、数字和主体中的点；其他符号整理为连字符。
- 去掉标题末尾已有的 `.pdf`，避免重复扩展名；空标题使用 `page`。
- 标题过长时截短主体，给 `.pdf` 留出空间。
- 在 Ctrl+P 按键阶段提前设置标题，beforeprint 作为兜底；不阻止快捷键、不额外调用 window.print。
- afterprint 时恢复原标题；若网页主动更新了标题，则保留网页更新。

这是**建议名称**：浏览器决定何时读取标题，用户可以在保存对话框中改名。扩展无法强制保存路径、自动点击保存或确认文件已保存。

## 适用范围

脚本只匹配 HTTP/HTTPS 普通网页顶层文档。它会在这些网页运行，浏览器安装时会显示相应站点访问提示。没有 downloads 权限、网络请求、数据收集或后台服务。

浏览器内置页面、扩展商店受限页面、内置 PDF 阅读器、file:// 本地页面不覆盖。打印 iframe 或网站自建打印窗口时可能无法使用顶层页面标题。仅面向内置「另存为 PDF」，不保证 Microsoft Print to PDF 等系统打印驱动行为。

浏览器可能提前缓存标题，网站也可能自行修改标题；需要在实际浏览器验证。若网站拦截 Ctrl+P 且没有发生打印，临时标题可能持续到下一次打印结束或页面刷新。

它不区分打印目标，因此发起普通纸张打印时也会暂时修改标题。开启打印页眉页脚时，规范标题也可能出现在打印页眉中。

项目仅保留此打印命名扩展；原下载命名扩展和 PowerShell watcher 已移除。

## 测试

```bash
node content.test.cjs
```

10 项测试覆盖快捷键、打印事件、恢复、标题更新、日期规范化及长标题。测试模拟页面事件，不等同于真实浏览器打印对话框测试。

手动验收：普通网页 Ctrl+P 保存 PDF、取消打印、连续打印两次、带已有日期的标题，并确认退出预览后页面标题恢复。

参考：[beforeprint](https://developer.mozilla.org/en-US/docs/Web/API/Window/beforeprint_event)、[afterprint](https://developer.mozilla.org/en-US/docs/Web/API/Window/afterprint_event)。
