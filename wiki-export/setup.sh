#!/bin/sh -e
# -e causes an exit on failure

if ! [ -d wiki.cusf.co.uk ]; then
	# Only import the latest revision of relevant pages
	git clone -c remote.origin.pages="Hades" \
	          -c remote.origin.shallow=true \
			  -c remote.origin.mwLogin='EllieClifford' \
	          -c remote.origin.mwPassword="$mwpassword" \
	          -c user.email="hades@cusf.co.uk" \
	          -c user.name="Hades Github Action" \
		mediawiki::https://wiki.cusf.co.uk
fi
