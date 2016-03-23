export NODEMCU_UPLOADER ?= nodemcu-uploader
export PORT ?= 
export SPEED ?= 

all:

terminal:
	$(NODEMCU_UPLOADER) $(SPEED) $(PORT) terminal

restart:
	$(NODEMCU_UPLOADER) $(SPEED) $(PORT) node restart

upload:
	$(NODEMCU_UPLOADER) $(SPEED) $(PORT) upload --compile *.lua file/*.lua webserver/*.lua htdocs/*.lua
	$(NODEMCU_UPLOADER) $(SPEED) $(PORT) upload htdocs/*.html htdocs/*.gz

.PHONY: all terminal restart upload
