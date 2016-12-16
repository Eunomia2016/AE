#include "memstore.h"
namespace leveldb {
class MemstoreBPlusTree: public Memstore{
public:
	MemstoreBPlusTree();
	MemstoreBPlusTree(int id);
	~MemstoreBPlusTree();

	//Only for initialization
	Memstore::Iterator* GetIterator();

	MemNode* Put(uint64_t k, uint64_t* val);

	MemNode* Get(uint64_t key);

	InsertResult GetWithInsert(uint64_t key);

	MemNode* GetForRead(uint64_t key);
};
}
