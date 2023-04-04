!/bin/bash

input=$1

pdfcrop "${input}" "figs-temp.pdf"
i=1
for fig_name in \
    #{figure-name-list}
do
	sh pdf_crop.sh $i figs $fig_name;
	i=`expr $i + 1`
done
rm figs_temp.pdf


