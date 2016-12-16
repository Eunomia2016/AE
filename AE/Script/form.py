import numpy as np
import sys
base = "../Data/data/"
save="../Data/forms/"
def different_contention_rates(argument, iters):
    file_object = open(save+'figure8.txt', 'w')
    eunoX = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    eunoY = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    bX = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    bY = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    for index in range(0, iters) :
        data_euno = open(base+ "euno_theta_data_"+str(index))
        data_b = open(base+"b+_theta_data_"+str(index))
        theta_euno = []
        throughput_euno = []
        theta_b = []
        throughput_b = []
        i = 0
        for line in data_euno:
            if i % 4 == 1:
        	theta_euno.append(float(line.strip("\n")))
            elif i % 4 == 3:
        	throughput_euno.append((float(line.strip("\n")) / 1000000))
            i=i+1
        i = 0
        for line in data_b:
            if i % 4 == 1:
        	theta_b.append(float(line.strip("\n")))
            elif i % 4 == 3:
    	    	throughput_b.append((float(line.strip("\n")) / 1000000))
            i=i+1
	for x in range(0, len(theta_euno)):
	    eunoX[x] = eunoX[x] + theta_euno[x]
	    eunoY[x] = eunoY[x] + throughput_euno[x]
	    bX[x] = bX[x] + theta_b[x]
	    bY[x] = bY[x] + throughput_b[x]

    file_object.write("Figure 8: Throughput(Million ops/sec) under different contention rates.\n")
    print("Figure 8: Throughput(Million ops/sec) under different contention rates.")
    file_object.write("theta\tEunomia\tHTM-B+Tree\t\n")
    print("theta\tEunomia\tHTM-B+Tree\t\t")
    for i in range(0, len(eunoX)):
    	string = str('%.1f'%(eunoX[i]/iters)) + "\t" + str('%.2f'%(eunoY[i]/iters)) + "\t" + str('%.2f'%(bY[i]/iters)) + "\t\t"
	print(str('%.1f'%(eunoX[i]/iters)) + "\t" + str('%.2f'%(eunoY[i]/iters)) + "\t" + str('%.2f'%(bY[i]/iters)) + "\t\t")
    	file_object.write(string)
    file_object.close()

def different_thread_numbers(theta, iters):
    file_object = open(save+'figure10_'+str(theta)+'.txt', 'w')
    eunoX = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    eunoY = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    bX = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    bY = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    for index in range(0, iters) :

      	data = np.loadtxt(base+"thread_data_"+str(index), dtype=float)
        thread_euno = []
        throughput_euno = []
        thread_b = []
        throughput_b = []
        strid = 112
        switcher = {
                "0.2":0,
                "0.6":28,
                "0.9":56,
                "0.99":84,
        }
        init = switcher.get(theta, 0)
        i = 0
        for i in range(0, len(data), 1):
    	    if i == init:
    	        for j in range(0, 7):
    		    thread_euno.append(data[i + j * 4])
    		    throughput_euno.append((data[i + j * 4 + 3] / 1000000))
    	    if i == init + strid:
    	        for j in range(0, 7):
    		    thread_b.append(data[i + j * 4])
    		    throughput_b.append((data[i + j * 4 + 3] / 1000000))

  	for x in range(0, 7):
	    eunoX[x] = eunoX[x] + thread_euno[x]
	    eunoY[x] = eunoY[x] + throughput_euno[x]
	    bX[x] = bX[x] + thread_b[x]
	    bY[x] = bY[x] + throughput_b[x]


    file_object.write("Figure 10: Performance (Throughput:Million ops/sec) scalability under different contention levels.(theta=" + str(theta) +")\n")
    print("Figure 10: Performance (Throughput:Million ops/sec) scalability under different contention levels.(theta=" + str(theta) +")")

    file_object.write("thread\tEunomia\tHTM-B+Tree\t")
    print("thread\tEunomia\tHTM-B+Tree\t")
    for i in range(0, 7):
    	string = str('%.1f'%(eunoX[i]/iters)) + "\t" + str('%.2f'%(eunoY[i]/iters)) + "\t" + str('%.2f'%(bY[i]/iters)) + "\t\t"
	print(str('%.1f'%(eunoX[i]/iters)) + "\t" + str('%.2f'%(eunoY[i]/iters)) + "\t" + str('%.2f'%(bY[i]/iters)) + "\t\t")
    	file_object.write(string)

    file_object.close()

#different read ratio
def different_read_ratio(ratio, iters):
    file_object = open(save+'figure11_'+str(ratio)+'.txt', 'w')
    eunoX = [0, 0, 0, 0, 0, 0, 0]
    eunoY = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    bX = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    bY = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    size = 7
    for index in range(0, iters) :

        data = np.loadtxt(base+"ratio_data_"+str(index), dtype=float)
        thread_euno = []
        throughput_euno = []
        thread_b = []
        throughput_b = []
        strid = 112
        switcher = {
           "0": 0,
            "0.2": 28,
            "0.5": 56,
    	"0.8": 84,
        }
        init = switcher.get(ratio, 0)
        for i in range(0, len(data), 1):
    	    if i == init:
    	    	for j in range(0, 7):
    		    thread_euno.append(data[i + j * 4])
    		    throughput_euno.append((data[i + j * 4 + 3] / 1000000))
    	    if i == init + strid:
    	    	for j in range(0, 7):
    		    thread_b.append(data[i + j * 4])
    		    throughput_b.append((data[i + j * 4 + 3] / 1000000))
    	for x in range(0, len(thread_euno)):
	    eunoX[x] = eunoX[x] + thread_euno[x]
	    eunoY[x] = eunoY[x] + throughput_euno[x]
	    bX[x] = bX[x] + thread_b[x]
	    bY[x] = bY[x] + throughput_b[x]


    file_object.write("Figure 11: Performance (Throughput:Million ops/sec) under different get/put ratios in Zipfian Distribution (read ratio=" + str(ratio) + ")\n")
    print("Figure 11: Performance (Throughput:Million ops/sec) under different get/put ratios in Zipfian Distribution (read ratio=" + str(ratio) + ")")

    file_object.write("thread\tEunomia\tHTM-B+Tree\t\n")
    print("thread\tEunomia\tHTM-B+Tree\t")
    for i in range(0, size):
    	string = str('%.1f'%(eunoX[i]/iters)) + "\t" + str('%.2f'%(eunoY[i]/iters)) + "\t" + str('%.2f'%(bY[i]/iters)) + "\n"
	print(str('%.1f'%(eunoX[i]/iters)) + "\t" + str('%.2f'%(eunoY[i]/iters)) + "\t" + str('%.2f'%(bY[i]/iters)))
    	file_object.write(string)
    file_object.close()

def different_distribution_threads(distribution, iters):
    eunoX = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    eunoY = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    bX = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    bY = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    name = distribution.split('_', 1)[0]
    file_object = open(save+'figure12_'+name+'.txt', 'w')

    for index in range(0, iters) :
        data = np.loadtxt(base+distribution+"_"+str(index), dtype=float)
        thread_euno = []
        throughput_euno = []
        thread_b = []
        throughput_b = []
        strid = 28
        for i in range(0, len(data), strid):
    	    if i == 0:
    	        for j in range(0, 7):
    		    thread_euno.append(data[i + j * 4])
    		    throughput_euno.append((data[i + j * 4 + 3] / 1000000))
    	    if i == 0 + strid:
    	    	for j in range(0, 7):
    		    thread_b.append(data[i + j * 4])
    		    throughput_b.append((data[i + j * 4 + 3] / 1000000))
	for x in range(0, len(thread_euno)):
	    eunoX[x] = eunoX[x] + thread_euno[x]
	    eunoY[x] = eunoY[x] + throughput_euno[x]
	    bX[x] = bX[x] + thread_b[x]
	    bY[x] = bY[x] + throughput_b[x]

    file_object.write("Figure 12: Performance (Throughput:Million ops/sec) with different input distributions under high contention (distribution=" + name + ")\n")
    print("Figure 12: Performance (Throughput:Million ops/sec) with different input distributions under high contention (distribution=" + name + ")")

    file_object.write("thread\tEunomia\tHTM-B+Tree\t\n")
    print("thread\tEunomia\tHTM-B+Tree\t")
    for i in range(0, 7):
    	string = str('%.1f'%(eunoX[i]/iters)) + "\t" + str('%.2f'%(eunoY[i]/iters)) + "\t" + str('%.2f'%(bY[i]/iters)) + "\n"
	print(str('%.1f'%(eunoX[i]/iters)) + "\t" + str('%.2f'%(eunoY[i]/iters)) + "\t" + str('%.2f'%(bY[i]/iters)))
    	file_object.write(string)
    file_object.close()

def different_warehouse_ratio(warehouse, iters):
    eunoX = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    eunoY = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    bX = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    bY = [0, 0, 0, 0, 0, 0, 0 ,0, 0, 0]
    itersE = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    itersB = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    path = base+"threads_data_"
    name = save+"figure15_b.txt"
    upper = 7
    if warehouse == "0":
    	path = base+"warehouse_data_"
        name = save+"figure15_a.txt"
        upper = 5
    file_object = open(name, 'w')
    for index in range(0, iters) :
        data = np.loadtxt(path+str(index), dtype=float)
        x_euno = []
        throughput_euno = []
        x_b = []
        throughput_b = []
        strid = upper * 4
        switcher = {
            "0": 0,
            "1": strid,
        }
        init = 0
        for i in range(0, len(data), strid):
    	    if i == init:
    	        for j in range(0, upper):
    		    if warehouse == "0":
    		        x_euno.append(data[i + j * 4 + 1])
    		        throughput_euno.append((data[i + j * 4 + 3] / 10))
    		    else:
    		        x_euno.append(data[i + j * 4])
    		        throughput_euno.append((data[i + j * 4 + 3] / 10))
    	    if i == init + strid:
    	    	for j in range(0, upper):
    		    if warehouse == "0":
                        if (i+j*4+3) < len(data):
    		            x_b.append(data[i + j * 4 + 1])
    		            throughput_b.append((data[i + j * 4 + 3] / 10))
                        else :
                            x_b.append(0)
                            throughput_b.append(0)
		    else:
		        x_b.append(data[i + j * 4])
		        throughput_b.append((data[i + j * 4 + 3] / 10))
        euno_tree = []
        euno_throughput = []
        b_tree = []
        b_throughput = []
        length = len(x_euno)
        if warehouse == "0" :
    	    for i in range(0, len(x_euno)) :
    	        euno_tree.append(x_euno[length - i - 1])
    	    	euno_throughput.append(throughput_euno[length - i -1])
                b_tree.append(x_b[length - i - 1])
	    	b_throughput.append(throughput_b[length - i -1])
        else:
    	    for i in range(0, len(x_euno)) :
    	    	euno_tree.append(x_euno[i])
    	    	euno_throughput.append(throughput_euno[i])
    	    	b_tree.append(x_b[i])
    	    	b_throughput.append(throughput_b[i])

       	for x in range(0, len(euno_tree)):
	    eunoX[x] = eunoX[x] + euno_tree[x]
	    eunoY[x] = eunoY[x] + euno_throughput[x]
            if euno_tree[x] != 0:
                itersE[x]=itersE[x]+1
            if b_tree[x] != 0:
                itersB[x]=itersB[x]+1
	    bX[x] = bX[x] + b_tree[x]
	    bY[x] = bY[x] + b_throughput[x]

    title = "Figure 15(b):Throughput(10K ops/sec) with increasing number of threads (warehouse number is fixed to 1)"
    if warehouse == "0":
    	title = "Figure 15(a):Throughput(10K ops/sec) with increasing contention rate (decreasing warehouse number)"
    file_object.write(title+ "\n")
    print(title)
    if warehouse == "0" :
    	file_object.write("WH\tEunomia\tHTM-B+Tree\t\n")
   	print("WH\tEunomia\tHTM-B+Tree\t")
    else :
   	print("thread\tEunomia\tHTM-B+Tree\t")
    	file_object.write("thread\tEunomia\tHTM-B+Tree\t\n")

    for i in range(0, upper):
        if (itersB[i] == 0) :
            itersB[i] = 1

    	string = str('%.1f'%(eunoX[i]/itersE[i])) + "\t" + str('%.2f'%(eunoY[i]/itersE[i])) + "\t" + str('%.2f'%(bY[i]/itersB[i])) + "\n"
	print(str('%.1f'%(eunoX[i]/itersE[i])) + "\t" + str('%.2f'%(eunoY[i]/itersE[i])) + "\t" + str('%.2f'%(bY[i]/itersB[i])))
    	file_object.write(string)
    file_object.close()


#different_contention_rates()
#different_thread_numbers(0.9)
#different_read_ratio(0.9)
#different_warehouse_ratio(0)
#different_distribution_threads("Poisson_data")
def draw(picture, arguments = 0, iters = 3):
    if picture == "0":
    	different_contention_rates(arguments, iters)
    elif picture == "1":
	different_thread_numbers(arguments, iters)
    elif picture == "2":
  	different_read_ratio(arguments, iters)
    elif picture == "3":
	different_distribution_threads(arguments, iters)
    else:
	different_warehouse_ratio(arguments, iters)
if len(sys.argv) == 2:
    draw(sys.argv[1])
elif len(sys.argv) == 3:
    draw(sys.argv[1], 0, int(sys.argv[2]))
elif len(sys.argv) == 4:
    draw(sys.argv[1], sys.argv[2], int(sys.argv[3]))
else:
    print("wrong input")


