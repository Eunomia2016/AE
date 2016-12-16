#!/bin/bash
tar xzvf actrtm.tar.gz
cd actrtm/
make
sudo insmod actrtm.ko
sudo apt-get install libnuma-dev libjemalloc-dev libdb5.3++-dev libmysqld-dev libaio-dev

