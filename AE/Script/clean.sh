#!/bin/bash
cd ../Data/data
if [ $1 -eq 0 ];then
	rm -f *_theta_data*
elif [ $1 -eq 1 ];then
	rm -f thread_data*
elif [ $1 -eq 2 ];then
	rm -f ratio_data*
elif [ $1 -eq 3 ];then
	rm -f Poisson_data* Normal_data* Self-Similar_data*
elif [ $1 -eq 4 ];then
	rm -f warehouse_data* threads_data*
fi
cd ../../Script 

