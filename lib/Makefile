### CONFIG
SUBDIRS    := $(patsubst ./%,%,$(shell find . -maxdepth 1 -type d))


.PHONY: info all clean cleanall

info:
	$(SUBDIRS)

all:
	$(MAKE) -C tinyPTC
	$(MAKE) -C picoPNG.ua

clean:
	$(MAKE) -C tinyPTC clean
	$(MAKE) -C picoPNG.ua clean

cleanall:
	$(MAKE) -C tinyPTC cleanall
	$(MAKE) -C picoPNG.ua cleanall

# all:
# 	$(foreach F,$(SUBDIRS), $(MAKE) -C $(F))

# clean:
# 	$(foreach F,$(SUBDIRS), $(MAKE) -C $(F) clean)

# cleanall:
# 	$(foreach F,$(SUBDIRS), $(MAKE) -C $(F) cleanall)