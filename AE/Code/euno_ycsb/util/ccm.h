//#include <arch/x86/include/asm/bitops.h>
#include <stdint.h>
#include "port/atomic.h"
#include "util/spinlock.h"
//conflict control module
#define ISBIT(bits, index) ((bits >> index) & 0x1)
#define SETBIT(bits, index) (bits | (1UL << index))
#define UNSETBIT(bits, index) (bits & ((-1) - (1UL << index)))
#define SEEDCOUNT 6
#define LEN 5
#define SIZE 64
#define LEAF_THRESHOLD 12
class CCM {	
public:

	SpinLock spinlock[32];
	uint64_t mark_bits;
	uint64_t operation;
	bool skip_lock = false;
	struct Counter {
		unsigned conflict_count;
		unsigned mark_count; 
	} counter;
public:
	CCM() {}

	//lock operation
	inline void read_Lock(unsigned int index) {
		//read_lock_bits = SETBIT(read_lock_bits, index);
		if(index >=32)
			index = index % 32;
		spinlock[index].read_Lock();
	}
	
	inline void read_Unlock(unsigned int index) {
		if(index >=32)
			index = index % 32;
		spinlock[index].read_Unlock();
	}
	inline void write_Lock(int index) {
		if(index >=32)
			index = index % 32;

		spinlock[index].write_Lock();
	}

	inline void write_Unlock(int index) {
		if(index >=32)
			index = index % 32;

		spinlock[index].write_Unlock();
	}
	/*
	inline uint16_t IsReadLocked(unsigned int index) {
		return read_lock_bits;
	}*/
	
	inline void set_mark_bits(uint64_t key, unsigned int slot) {
		if(!ISBIT(key, slot)) {
			counter.mark_count++;	
		}
		add_mark_bit(slot);
	}
	inline void unset_mark_bits(uint64_t key) {
		unsigned slot = getIndex(key);
		if(ISBIT(key, slot)) {
			counter.mark_count--;	
		}
		delete_mark_bit(slot);
	}
	inline bool isfound(uint64_t key) {
		return ((mark_bits >> getIndex(key)) & 0x1);
	}
	inline void clear_conflict() {
		counter.conflict_count = 0;	
	}
	inline void add_conflict_num(unsigned add_num) {
		counter.conflict_count += add_num;	
	}
	inline int get_conflict_num() {
		return 	counter.conflict_count;
	}
	inline void add_operation_num() {
		operation++;	
	}
	inline void clearMarkCount() {
		mark_bits = 0;
		counter.mark_count = 0;
	}
	inline bool is_conflict() {
		if(skip_lock) {
			return true;
		}
		else {
			if(get_conflict_num() > 100) {
				skip_lock = true;
				return true;
			}
			else 
				return false;		
		}
	}
	inline void set_conflict() {
		skip_lock ^ 1;
	}
	inline double get_conflict() {
		//printf("operation:%ld, conflict:%d, rate:%f\n", operation, counter.conflict_count, (counter.conflict_count + 0.0) / (operation + 0.0));
		//printf("operation:%ld, conflict:%d, rate:%f\n", operation, counter.conflict_count, (counter.conflict_count + 0.0) / (operation + 0.0));
		if(operation > 10) {
			return ((counter.conflict_count + 0.0) / (operation + 0.0));
		}
		else
			return 0.5;
	}
	unsigned int getIndex(uint64_t key) {
		int Ret[SEEDCOUNT];
		int temp = 0;
		GenerateHashValue(key, LEN, Ret, SEEDCOUNT);		
		for(int i = 0; i < SEEDCOUNT; i++) 
			temp += Ret[i];
		return (temp % 64 + 64) % 64;
	}
	inline bool skipBF() {
		return counter.mark_count >= LEAF_THRESHOLD;
	}
	inline uint64_t getOperation() {
		return operation;	
	}
private:
	//mark_bits
	inline void add_mark_bit(unsigned int index) {
		mark_bits = SETBIT(mark_bits, index);
	}
	inline void delete_mark_bit(unsigned int index) {
		mark_bits = UNSETBIT(mark_bits, index);
	}

	int GenerateHashValue(uint64_t key, unsigned int len, int* Ret, int retLen)  {  
    		if(retLen > SEEDCOUNT) {  
        		return -1;  
    		}  
    		for(int i = 0; i < retLen; i++) {  
        		Ret[i] = GenerateHashValue(key, len, i);
    		}  
    		return retLen;  
	} 
	int GenerateHashValue(uint64_t str, unsigned int len, int hasFunIndex) {  
    		switch(hasFunIndex) {  
    		case 0:  
        		return RSHash(str, len);  
    		case 1:  
        		return JSHash(str, len); 
		default:
			return RSHash(str, len);
		}
	} 
	//hash1
	unsigned int RSHash(uint64_t str, unsigned int len) {    
	   	unsigned int b    = 378551;    
	   	unsigned int a    = 63689;    
	   	unsigned int hash = 0;    
	   	unsigned int i    = 0;    
	   	for(i = 0; i < len; str++, i++) {    
	      		hash = hash * a + str;    
	      		a = a * b;    
	   	}    
	   	return hash;    
	}
	//hash2
	unsigned int JSHash(uint64_t str, unsigned int len) {    
   		unsigned int hash = 1315423911;    
   		unsigned int i    = 0;    
   		for(i = 0; i < len; str++, i++) {    
      			hash ^= ((hash << 5) + str + (hash >> 2));    
   		}    
   		return hash;    
	}    
};

