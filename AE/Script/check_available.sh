#!/bin/bash
echo "Please check HTOP in case other programs are running"
if [ -f ../.run_0 ]; then
	for filename in `ls ../.run_*`
	do
    		iterations=$(echo $filename | cut -d '_' -f 2) 
	done
	echo "There is another running instance now, which is running in iteration: $iterations!"
	echo "Please wait for a moment"
else
	echo "There is no other instance running, you could run the script after checking the HTOP"
fi

