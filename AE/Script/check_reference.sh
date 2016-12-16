#!/bin/bash
path=../Data/references
if [ $# -eq 0 ]; then
	echo "./check_reference.sh <argument>"
	echo "<0> figure 8"
	echo "<1> figure 10"
	echo "<2> figure 11"
	echo "<3> figure 12"
	echo "<4> figure 15"
else
	if [ $1 -eq 0 ]; then
		cat $path/figure8.txt
	elif [ $1 -eq 1 ]; then
		cat $path/figure10_0.2.txt
		cat $path/figure10_0.6.txt
		cat $path/figure10_0.9.txt
		cat $path/figure10_0.99.txt	
	elif [ $1 -eq 2 ]; then
		cat $path/figure11_0.txt
		cat $path/figure11_0.2.txt
		cat $path/figure11_0.5.txt
		cat $path/figure11_0.7.txt
	elif [ $1 -eq 3 ]; then
		cat $path/figure12_Normal.txt
		cat $path/figure12_Poisson.txt
		cat $path/figure12_Self-Similar.txt
	else
		cat $path/figure15_a.txt
		cat $path/figure15_b.txt
	fi
fi
