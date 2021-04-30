all:
	./util/setup.sh

with-image:
	@if [ -z "$$image" ]; then \
		echo -e '\e[31mERROR: You must define image=path/to/image.qcow2\e[0m';\
		exit 1; \
	fi
	./util/setup-with-image.sh $$image

install:
	mkdir -p /usr/local/bin
	cp hades.sh /usr/local/bin/hades
	chmod +x /usr/local/bin/hades
	cp util/qemu_monitor.sh /usr/local/bin/hades-monitor
	chmod +x /usr/local/bin/hades-monitor
	@if ! mkdir /var/local/hades; then \
		echo -e '\e[31mERROR: Hades is already installed, refusing to overwrite\e[0m'; \
		exit 1; \
	fi
	mv run/* /var/local/hades/
	rmdir run
	@echo -e '\e[32m====> Installation complete\e[0m'
	@echo -n 'You may now delete this folder if you wish to (but if you want '
	@echo    'to set up fast-starting SolidWorks, do that first)'

solidworks:
	echo "#!/bin/sh" > /usr/local/bin/solidworks
	echo "hades -loadvm solidworks" > /usr/local/bin/solidworks
	chmod +x /usr/local/bin/solidworks
