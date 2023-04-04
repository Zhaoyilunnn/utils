!/bin/bash

input=$1

pdfcrop "${input}" "figs-temp.pdf"
i=1
for fig_name in \
    v1_macos_rqc_trend \
    v1_macos_rqc_overheaad \
    v1_shuguang_rqc_trend \
    v1_shuguang_rqc_overhead
do
	sh pdf_crop.sh $i figs $fig_name;
	i=`expr $i + 1`
done
rm figs-temp.pdf


