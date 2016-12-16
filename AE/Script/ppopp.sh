#!/bin/bash
echo "Please check HTOP in case other programs are running"
if [ -f ../.run_0 ]; then
	for filename in `ls ../.run*`
	do
    		iterations=$(echo $filename | cut -d '_' -f 2) 
	done
	echo "There is another running instance now, which is running in iteration: $iterations!"
	echo "Please wait for a moment"
else
trap "rm ../.run_*" EXIT
if [ $# -eq 2 ]; then
	figure=$1 
	iter=$2
elif [ $# -eq 0 ]; then 
	figure=0
	iter=3
elif [ $# -eq 1 ]; then 
	figure=$1
	iter=3
fi
iter=`echo "scale=1;$iter"|bc`
./clean.sh $figure
for((i = 0; i < iter; i++)) 
do
	touch ../.run_$i
	echo "iteration $i:"
	./ppopp_test.sh $figure $i
done
if [ $figure -eq 0 ]; then
	python ./form.py 0 0 $iter
elif [ $figure -eq 1 ]; then 
	python ./form.py 1 0.2 $iter 
	python ./form.py 1 0.6 $iter 
	python ./form.py 1 0.9 $iter 
	python ./form.py 1 0.99 $iter 
elif [ $figure -eq 2 ]; then 
	python ./form.py 2 0 $iter
	python ./form.py 2 0.2 $iter
	python ./form.py 2 0.5 $iter
	python ./form.py 2 0.7 $iter
elif [ $figure -eq 3 ]; then 
	python ./form.py 3 Poisson_data $iter 
	python ./form.py 3 Normal_data $iter 
	python ./form.py 3 Self-Similar_data $iter 
elif [ $figure -eq 4 ]; then
	python ./form.py 4 0 $iter
	python ./form.py 4 1 $iter
fi
fi
