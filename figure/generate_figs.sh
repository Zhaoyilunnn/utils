
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
    kl_cairo_circ_2 \
    pst_cairo_circ_2 \
    kl_brooklyn_circ_2 \
    pst_brooklyn_circ_2 \
    runtime_speedup_cairo \
    runtime_speedup_brooklyn \
    fid_comp_vanilla \
    compilation_vs_duration \
    num_parts_cmp_qubit_cu \
    ibm_osaka_res \
    tolerance_device_variation
do
	bash pdf_crop.sh $i figs $fig_name;
	i=`expr $i + 1`
done
rm figs-temp.pdf
