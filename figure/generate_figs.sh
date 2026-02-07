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
  fid_bklyn \
  fid_cai \
  crf_bklyn \
  crf_cai \
  fid_vanilla \
  fid_predict \
  fid_scale \
  util_scale \
  compile_time_motiv \
  compile_time_vs_qubits \
  fid_real_machine \
  fid_dev_var \
  dev_var_dist \
  fid_cu_size_impact \
  crosstalk \
  crosstalk_real_machine; do
  bash pdf_crop.sh $i figs $fig_name
  i=$(expr $i + 1)
done
rm figs-temp.pdf
