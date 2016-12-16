import numpy as np
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages
import sys
base="../Data/data/"
base_figure="../Data/figures/"
def different_contention_rates():
    pp = PdfPages(base_figure+"different_contention_data.pdf")
    data_euno = np.loadtxt(base+"euno_theta_data", dtype=float)
    data_b = np.loadtxt(base+"b+_theta_data", dtype=float)
    data_mass = np.loadtxt(base+"Masstree_theta_data", dtype=float)
    data_htm = np.loadtxt(base+"HTM-Masstree_theta_data", dtype=float)
    theta_euno = []
    throughput_euno = []
    theta_b = []
    throughput_b = []
    theta_mass = []
    throughput_mass = []
    theta_htm = []
    throughput_htm = []
    for i in range(0, len(data_euno)):
        if i % 4 == 1:
	    theta_euno.append(data_euno[i])
	    theta_b.append(data_b[i])
	    theta_mass.append(data_mass[i])
	    theta_htm.append(data_htm[i])
        elif i % 4 == 3:
	    throughput_euno.append(data_euno[i])
	    throughput_b.append(data_b[i])
	    throughput_mass.append(data_mass[i] * 1000000)
	    throughput_htm.append(data_htm[i] * 1000000)
    plt.plot(theta_euno, throughput_euno, '-xb', label="Eunomia")
    plt.plot(theta_b, throughput_b, '-og', label="HTM-B+Tree")
    plt.plot(theta_mass, throughput_mass, '-pr', label="Masstree")
    plt.plot(theta_htm, throughput_htm, '-dy', label="HTM-Masstree")
    plt.legend(bbox_to_anchor=(1, 1), loc=1, borderaxespad=0.)

    plt.xlabel("Skew Coefficient")
    plt.ylabel("Throughput (Million ops/sec)")
    plt.ylim(0.0, 40000000.)
    plt.title("Throughput under different contention rates")
    plt.savefig(pp, format='pdf')
    pp.savefig()

def different_thread_numbers(theta):
    pp = PdfPages(base_figure+str(theta)+ "_theta_dif_thread_data.pdf")
    data = np.loadtxt(base+"thread_data", dtype=float)
    thread_euno = []
    throughput_euno = []
    thread_b = []
    throughput_b = []
    thread_mass = []
    throughput_mass = []
    thread_htm = []
    throughput_htm = []
    strid = 112
    switcher = {
        0.2: 0,
        0.6: 28,
        0.9: 56,
	0.99: 84,
    }
    init = switcher.get(theta, 0)
    for i in range(0, len(data), 1):
	if i == init:
	    for j in range(0, 7):
		thread_euno.append(data[i + j * 4])
		throughput_euno.append(data[i + j * 4 + 3])
	if i == init + strid:
	    for j in range(0, 7):
		thread_b.append(data[i + j * 4])
		throughput_b.append(data[i + j * 4 + 3])
	if i == init + 2 * strid:
	    for j in range(0, 7):
		thread_mass.append(data[i + j * 4])
		throughput_mass.append(data[i + j * 4 + 3] * 1000000)
	if i == init + 3 * strid:
	    for j in range(0, 7):
		thread_htm.append(data[i + j * 4] )
		throughput_htm.append(data[i + j * 4 + 3] * 1000000)
    plt.plot(thread_euno, throughput_euno, '-xb', label="Eunomia")
    plt.plot(thread_b, throughput_b, '-og', label="HTM-B+Tree")
    plt.plot(thread_mass, throughput_mass, '-pr', label="Masstree")
    plt.plot(thread_htm, throughput_htm, '-dy', label="HTM-Masstree")
    plt.legend(bbox_to_anchor=(0.4, 1), loc=1, borderaxespad=0.)
 
    plt.xlabel("Number of threads")
    plt.ylabel("Throughput (Million ops/sec)")
    if theta == "0.2":
        plt.ylim(0.0, 40000000.)
    elif theta == "0.6":
	plt.ylim(0.0, 30000000.)
    else: 
	plt.ylim(0.0, 25000000.)
    plt.title("theta="+str(theta))
    plt.savefig(pp, format='pdf')
    pp.savefig()

def different_read_ratio(ratio):
    pp = PdfPages(base_figure+str(ratio)+ "_ratio_data.pdf")
    data = np.loadtxt(base+"ratio_data", dtype=float)
    thread_euno = []
    throughput_euno = []
    thread_b = []
    throughput_b = []
    thread_mass = []
    throughput_mass = []
    thread_htm = []
    throughput_htm = []
    strid = 112
    switcher = {
        0: 0,
        0.2: 28,
        0.5: 56,
	0.8: 84,
    }
    init = switcher.get(ratio, 0)
    for i in range(0, len(data), strid):
	if i == init:
	    for j in range(0, 7):
		thread_euno.append(data[i + j * 4])
		throughput_euno.append(data[i + j * 4 + 3])
	if i == init + strid:
	    for j in range(0, 7):
		thread_b.append(data[i + j * 4])
		throughput_b.append(data[i + j * 4 + 3])
	if i == init + 2 * strid:
	    for j in range(0, 7):
		thread_mass.append(data[i + j * 4])
		throughput_mass.append(data[i + j * 4 + 3] * 1000000)
	if i == init + 3 * strid:
	    for j in range(0, 7):
		thread_htm.append(data[i + j * 4] )
		throughput_htm.append(data[i + j * 4 + 3] * 1000000)
    plt.plot(thread_euno, throughput_euno, '-xb', label="Eunomia")
    plt.plot(thread_b, throughput_b, '-og', label="HTM-B+Tree")
    plt.plot(thread_mass, throughput_mass, '-pr', label="Masstree")
    plt.plot(thread_htm, throughput_htm, '-dy', label="HTM-Masstree")
    plt.legend(bbox_to_anchor=(0.4, 1), loc=1, borderaxespad=0.)
    plt.xlabel("Number of threads")
    plt.ylabel("Throughput (Million ops/sec)")
    if ratio == 0:
	plt.title("0% Get/100% Put")
        plt.ylim(0.0, 25000000.)
    elif ratio == 0.2:
	plt.title("20% Get/80% Put")
	plt.ylim(0.0, 25000000.)
    elif ratio == 0.5: 
	plt.title("50% Get/50% Put")
	plt.ylim(0.0, 25000000.)
    else:
	plt.title("80% Get/20% Put")
	plt.ylim(0.0, 30000000.)
    plt.savefig(pp, format='pdf')
    pp.savefig()

def different_warehouse_ratio(warehouse):
    pp = PdfPages(base_figure+"threads_data.pdf")
    data = np.loadtxt(base+"threads_data", dtype=float)
    if warehouse == "0":
	data = np.loadtxt(base+"warehouse_data", dtype=float)
	pp = PdfPages(base+"warehouse_data.pdf")
    x_euno = []
    throughput_euno = []
    x_b = []
    throughput_b = []
    thread_mass = []
    strid = 28
    switcher = {
        0: 0,
        1: 28,
    }
    init = 0
    for i in range(0, len(data), strid):
	if i == init:
	    for j in range(0, 7):
		if warehouse == "0":
		    x_euno.append(data[i + j * 4 + 1])
		    throughput_euno.append(data[i + j * 4 + 3])
		else:
		    x_euno.append(data[i + j * 4])
		    throughput_euno.append(data[i + j * 4 + 3] )
	if i == init + strid:
	    for j in range(0, 7):
		if warehouse == "0":
		    x_b.append(data[i + j * 4 + 1])
		    throughput_b.append(data[i + j * 4 + 3])
		else:
		    x_b.append(data[i + j * 4])
		    throughput_b.append(data[i + j * 4 + 3] )
    plt.plot(x_euno, throughput_euno, '-xb', label="Eunomia")
    plt.plot(x_b, throughput_b, '-og', label="HTM-B+Tree")
    plt.legend(bbox_to_anchor=(0.4, 1), loc=1, borderaxespad=0.)
   
    plt.ylabel("Throughput (K ops/sec)")
    if warehouse == "0":
 	plt.xlabel("Number of warehouse")
	plt.title("The working thread number is fixed to 20")
        #plt.ylim(0.0, 120000000.)
    else:
	plt.xlabel("Number of threads")
	plt.title("warehouse number is fixed to 1")
	#plt.ylim(0.0, 35000000.)
    plt.savefig(pp, format='pdf')
    pp.savefig()

def different_distribution_threads(distribution):
    pp = PdfPages(base_figure+distribution + '.pdf')
    data = np.loadtxt(base+distribution, dtype=float)
    thread_euno = []
    throughput_euno = []
    thread_b = []
    throughput_b = []
    strid = 28
    
    for i in range(0, len(data), strid):
	if i == 0:
	    for j in range(0, 7):
		thread_euno.append(data[i + j * 4])
		throughput_euno.append(data[i + j * 4 + 3])
	if i == 0 + strid:
	    for j in range(0, 7):
		thread_b.append(data[i + j * 4])
		throughput_b.append(data[i + j * 4 + 3])
    plt.plot(thread_euno, throughput_euno, '-bx', label="Eunomia")
    plt.plot(thread_b, throughput_b, '-og', label="HTM-B+Tree")
    #, thread_b, throughput_b, label="HTM-B+Tree", linestyle='-og'
    plt.legend(bbox_to_anchor=(0.4, 1), loc=1, borderaxespad=0.)
    plt.xlabel("Number of threads")
    plt.ylabel("Throughput (Million ops/sec)")
    if distribution=="Posisson_data" :
    	plt.title("Poisson Distribution")
	plt.ylim(0.0, 16000000.)
    elif distribution=="Normal_data" :
	plt.title("Normal Distribution")
	plt.ylim(0.0, 16000000.)
    elif distribution=="Self-Similar_data" :
	plt.title("Self-Similar Distribution")
	plt.ylim(0.0, 14000000.)
    plt.savefig(pp, format='pdf')
    pp.savefig()

#different_contention_rates()
#different_thread_numbers(0.9)
#different_read_ratio(0.9)
#different_warehouse_ratio(0)
def draw(picture, arguments = 0):
    if picture == "0":
    	different_contention_rates()
    elif picture == "1":
	different_thread_numbers(arguments)
    elif picture == "2":
  	different_read_ratio(arguments)
    elif picture == "3":
	different_distribution_threads(arguments)
    else:
	different_warehouse_ratio(arguments)
if len(sys.argv) == 2:
    draw(sys.argv[1])
elif len(sys.argv) == 3:
    draw(sys.argv[1], sys.argv[2])
else:
    print("wrong input")
















