#!/bin/bash
base_path=/home/wangx/AE
data_path=../../../Data/data
data_path_euno=../../../../Data/data
script_path=../../Script
if [ $# -eq 0 ]; then
    echo "<./run_ycsb_evaluation.sh <evaluation type>"
    echo "evaluation type: 
	  (0) Throughput under different contention rates 
	  (1) Performance with different thread numbers 
	  (2) Performance under different get/put ratios in Zipfian Distribution
          (3) Performance with different input distributions
	  (4) TPC-C benchmark with standard mix"
else

#Throughput under different contention rates
if [ $1 -eq 0 ]; then 
cd ../Data/data
if [ -f "euno_theta_data" ];then
    echo "theta test is done"
else
touch euno_theta_data_$2
echo "theta test is starting"
for((j = 1; j <= 10; j++))
    do
	echo "No.$j round in euno_tree:"
 	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;$j/10"|bc`
	s=$(./run_ycsb_zipf.sh 16 1 0.5 4 20 $k )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $20}')
	runtime=$(echo $s | awk '{print $30}')
	throughput=$(echo $s | awk '{print $35}')
	cd $data_path_euno
	echo "$threads" >> euno_theta_data_$2
	echo "$Theta" >> euno_theta_data_$2
	echo "$runtime" >> euno_theta_data_$2
	echo "$throughput" >> euno_theta_data_$2
    done
fi

if [ -f "b+_theta_data" ]; then
    echo "theta test is done"
else
echo "theta test is starting"
touch b+_theta_data_$2
for((j = 1; j <= 10; j++))
    do
	echo "No.$j round in b+tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;$j/10"|bc`
	s=$(./run_ycsb_zipf.sh 16 0 0.5 4 20 $k )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $18}')
	runtime=$(echo $s | awk '{print $28}')
	throughput=$(echo $s | awk '{print $33}')
	cd $data_path_euno
	echo "$threads" >> b+_theta_data_$2
	echo "$Theta" >> b+_theta_data_$2
	echo "$runtime" >> b+_theta_data_$2
	echo "$throughput" >> b+_theta_data_$2
    done
fi
cd $script_path
fi



#Performance with different thread numbers
if [ $1 -eq 1 ]; then
cd ../Data/data
if [ -f "thread_data_$2" ]; then
    echo "thread test is done"
else
touch thread_data_$2
echo "thread test is starting"
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in euno_tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4 "|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 1 0.5 4 20 0.2 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $20}')
	runtime=$(echo $s | awk '{print $30}')
	throughput=$(echo $s | awk '{print $35}')
	cd $data_path_euno	
	echo "$threads" >> thread_data_$2
	echo "$Theta" >> thread_data_$2
	echo "$runtime" >> thread_data_$2
	echo "$throughput" >> thread_data_$2
    done
echo " " >> thread_data_$2
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in euno_tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4 "|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 1 0.5 4 30 0.6 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $20}')
	runtime=$(echo $s | awk '{print $30}')
	throughput=$(echo $s | awk '{print $35}')
	cd $data_path_euno	
	echo "$threads" >> thread_data_$2
	echo "$Theta" >> thread_data_$2
	echo "$runtime" >> thread_data_$2
	echo "$throughput" >> thread_data_$2
    done
echo " " >> thread_data_$2	
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in euno_tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4 "|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 1 0.5 4 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $20}')
	runtime=$(echo $s | awk '{print $30}')
	throughput=$(echo $s | awk '{print $35}')
	cd $data_path_euno
	echo "$threads" >> thread_data_$2
	echo "$Theta" >> thread_data_$2
	echo "$runtime" >> thread_data_$2
	echo "$throughput" >> thread_data_$2
    done
echo " " >> thread_data_$2	
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in euno_tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4 "|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 1 0.5 4 30 0.99 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $20}')
	runtime=$(echo $s | awk '{print $30}')
	throughput=$(echo $s | awk '{print $35}')
	cd $data_path_euno
	echo "$threads" >> thread_data_$2
	echo "$Theta" >> thread_data_$2
	echo "$runtime" >> thread_data_$2
	echo "$throughput" >> thread_data_$2
    done
echo " " >> thread_data_$2
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in b+tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4"|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 0 0.5 4 20 0.2 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $18}')
	runtime=$(echo $s | awk '{print $28}')
	throughput=$(echo $s | awk '{print $33}')
	cd $data_path_euno
	echo "$threads" >> thread_data_$2
	echo "$Theta" >> thread_data_$2
	echo "$runtime" >> thread_data_$2
	echo "$throughput" >> thread_data_$2
    done

echo " " >> thread_data_$2
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in b+tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4"|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 0 0.5 4 30 0.6 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $18}')
	runtime=$(echo $s | awk '{print $28}')
	throughput=$(echo $s | awk '{print $33}')
	cd $data_path_euno
	echo "$threads" >> thread_data_$2
	echo "$Theta" >> thread_data_$2
	echo "$runtime" >> thread_data_$2
	echo "$throughput" >> thread_data_$2
    done
echo " " >> thread_data_$2_$2
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in b+tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4"|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 0 0.5 4 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $18}')
	runtime=$(echo $s | awk '{print $28}')
	throughput=$(echo $s | awk '{print $33}')
	cd $data_path_euno
	echo "$threads" >> thread_data_$2
	echo "$Theta" >> thread_data_$2
	echo "$runtime" >> thread_data_$2
	echo "$throughput" >> thread_data_$2
    done

echo " " >> thread_data_$2_$2
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in b+tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4"|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 0 0.5 4 30 0.99 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $18}')
	runtime=$(echo $s | awk '{print $28}')
	throughput=$(echo $s | awk '{print $33}')
	cd $data_path_euno
	echo "$threads" >> thread_data_$2
	echo "$Theta" >> thread_data_$2
	echo "$runtime" >> thread_data_$2
	echo "$throughput" >> thread_data_$2
    done
fi
cd $script_path
fi



#get/put ratio
if [ $1 -eq 2 ]; then
cd ../Data/data
if [ -f "ratio_data_$2" ]; then
echo "ratio test is done"
else
touch ratio_data_$2
echo "ratio test is starting"
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in euno_tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4 "|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 1 0.0 4 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $20}')
	runtime=$(echo $s | awk '{print $30}')
	throughput=$(echo $s | awk '{print $35}')
	cd $data_path_euno
	echo "$threads" >> ratio_data_$2
	echo "$Theta" >> ratio_data_$2
	echo "$runtime" >> ratio_data_$2
	echo "$throughput" >> ratio_data_$2
     done
echo " " >> ratio_data_$2
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in euno_tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4 "|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 1 0.2 4 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $20}')
	runtime=$(echo $s | awk '{print $30}')
	throughput=$(echo $s | awk '{print $35}')
	cd $data_path_euno
	echo "$threads" >> ratio_data_$2
	echo "$Theta" >> ratio_data_$2
	echo "$runtime" >> ratio_data_$2
	echo "$throughput" >> ratio_data_$2
    done
echo " " >> ratio_data_$2
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in euno_tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4 "|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 1 0.5 4 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $20}')
	runtime=$(echo $s | awk '{print $30}')
	throughput=$(echo $s | awk '{print $35}')
	cd $data_path_euno
	echo "$threads" >> ratio_data_$2
	echo "$Theta" >> ratio_data_$2
	echo "$runtime" >> ratio_data_$2
	echo "$throughput" >> ratio_data_$2
    done
echo " " >> ratio_data_$2
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in euno_tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4 "|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 1 0.7 4 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $20}')
	runtime=$(echo $s | awk '{print $30}')
	throughput=$(echo $s | awk '{print $35}')
	cd $data_path_euno
	echo "$threads" >> ratio_data_$2
	echo "$Theta" >> ratio_data_$2
	echo "$runtime" >> ratio_data_$2
	echo "$throughput" >> ratio_data_$2
    done
echo " " >> ratio_data_$2
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in b+tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4"|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 0 0.0 4 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $18}')
	runtime=$(echo $s | awk '{print $28}')
	throughput=$(echo $s | awk '{print $33}')
	cd $data_path_euno
	echo "$threads" >> ratio_data_$2
	echo "$Theta" >> ratio_data_$2
	echo "$runtime" >> ratio_data_$2
	echo "$throughput" >> ratio_data_$2
    done

echo " " >> ratio_data_$2
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in b+tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4"|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 0 0.2 4 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $18}')
	runtime=$(echo $s | awk '{print $28}')
	throughput=$(echo $s | awk '{print $33}')
	cd $data_path_euno
	echo "$threads" >> ratio_data_$2
	echo "$Theta" >> ratio_data_$2
	echo "$runtime" >> ratio_data_$2
	echo "$throughput" >> ratio_data_$2
    done
echo " " >> ratio_data_$2
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in b+tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4"|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 0 0.5 4 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $18}')
	runtime=$(echo $s | awk '{print $28}')
	throughput=$(echo $s | awk '{print $33}')
	cd $data_path_euno
	echo "$threads" >> ratio_data_$2
	echo "$Theta" >> ratio_data_$2
	echo "$runtime" >> ratio_data_$2
	echo "$throughput" >> ratio_data_$2
    done

echo " " >> ratio_data_$2
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in b+tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4"|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 0 0.7 4 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $18}')
	runtime=$(echo $s | awk '{print $28}')
	throughput=$(echo $s | awk '{print $33}')
	cd $data_path_euno
	echo "$threads" >> ratio_data_$2
	echo "$Theta" >> ratio_data_$2
	echo "$runtime" >> ratio_data_$2
	echo "$throughput" >> ratio_data_$2
    done
fi
cd $script_path
fi

# Poisson Distribution
if [ $1 -eq 3 ]; then
cd ../Data/data
if [ -f "Poisson_data_$2" ]; then
echo "Poisson test is done"
else
touch Poisson_data_$2
echo "Poisson test is starting"
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in euno_tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4 "|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 1 0.5 6 30 0.9)
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $20}')
	runtime=$(echo $s | awk '{print $30}')
	throughput=$(echo $s | awk '{print $35}')
	cd $data_path_euno
	echo "$threads" >> Poisson_data_$2
	echo "$Theta" >> Poisson_data_$2
	echo "$runtime" >> Poisson_data_$2
	echo "$throughput" >> Poisson_data_$2
     done
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in b+tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4"|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 0 0.5 6 30 0.9)
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $18}')
	runtime=$(echo $s | awk '{print $28}')
	throughput=$(echo $s | awk '{print $33}')
	cd $data_path_euno
	echo "$threads" >> Poisson_data_$2
	echo "$Theta" >> Poisson_data_$2
	echo "$runtime" >> Poisson_data_$2
	echo "$throughput" >> Poisson_data_$2
    done
fi

#Normal Distribution

if [ -f "Normal_data_$2" ]; then
echo "Normal test is done"
else
touch Normal_data_$2
echo "Normal test is starting"
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in euno_tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4 "|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 1 0.5 2 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=0.9
	runtime=$(echo $s | awk '{print $27}')
	throughput=$(echo $s | awk '{print $32}')
	cd $data_path_euno
	echo "$threads" >> Normal_data_$2
	echo "$Theta" >> Normal_data_$2
	echo "$runtime" >> Normal_data_$2
	echo "$throughput" >> Normal_data_$2
     done
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in b+tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4"|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 0 0.5 2 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=0.9
	runtime=$(echo $s | awk '{print $25}')
	throughput=$(echo $s | awk '{print $30}')
	cd $data_path_euno
	echo "$threads" >> Normal_data_$2
	echo "$Theta" >> Normal_data_$2
	echo "$runtime" >> Normal_data_$2
	echo "$throughput" >> Normal_data_$2
    done
fi

# Self-Similar Distribution
if [ -f "Self-Similar_data_$2" ]; then
echo "Self-Similar test is done"
else
touch Self-Similar_data_$2
echo "Self-Similar test is starting"
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in euno_tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4 "|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 1 0.5 5 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $20}')
	runtime=$(echo $s | awk '{print $30}')
	throughput=$(echo $s | awk '{print $35}')
	cd $data_path_euno
	echo "$threads" >> Self-Similar_data_$2
	echo "$Theta" >> Self-Similar_data_$2
	echo "$runtime" >> Self-Similar_data_$2
	echo "$throughput" >> Self-Similar_data_$2
     done
for((j = 1; j <= 7; j++))
    do
	echo "No.$j round in b+tree:"
	cd ../../Code/euno_ycsb/script/ycsb
	k=`echo "scale=1;($j-2)*4"|bc`
	if [ $j -lt 3 ]; then
		k=`echo "scale=1;$j "|bc`
	fi
	s=$(./run_ycsb_zipf.sh $k 0 0.5 5 30 0.9 )
	threads=$(echo $s | awk '{print $6}' | cut -d ',' -f 1)
	Theta=$(echo $s | awk '{print $18}')
	runtime=$(echo $s | awk '{print $28}')
	throughput=$(echo $s | awk '{print $33}')
	cd $data_path_euno
	echo "$threads" >> Self-Similar_data_$2
	echo "$Theta" >> Self-Similar_data_$2
	echo "$runtime" >> Self-Similar_data_$2
	echo "$throughput" >> Self-Similar_data_$2
    done
fi
cd $script_path
fi
fi





















