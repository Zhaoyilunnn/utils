!/bin/bash

input=$1

pdfcrop "${input}" "figs-temp.pdf"
i=1
    #00 \
    #01 \
    #02 \
    #03 \
    #04 \
    #macos_quafu_res \
    #macos_qiskit_res \
    #shuguang_quafu_res \
    #shuguang_qiskit_res
for fig_name in \
    00 \
    01 \
    02 \
    03 \
    04 \
    macos_quafu_res \
    macos_qiskit_res \
    shuguang_quafu_res \
    shuguang_qiskit_res \
    macos_res \
    shuguang_res \
    comp_sims
do
	sh pdf_crop.sh $i figs $fig_name;
	i=`expr $i + 1`
done
rm figs-temp.pdf


