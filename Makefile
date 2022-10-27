#
#  Makefile
#

SRC = tcp_cubic_bw
obj-m := $(SRC).o
KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd) 

default:
	$(MAKE) -C $(KDIR) M=$(PWD) modules 

clean:
	$(RM) -f *.ko *.o
	$(RM) -f $(SRC).mod.c
	$(RM) -f Module.symvers modules.order
	$(RM) -fr .tmp_versions
	$(RM) -f $(SRC).mod .modules.* .$(SRC).* .cache.mk
