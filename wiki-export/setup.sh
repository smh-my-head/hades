#!/bin/sh -e
# -e causes an exit on failure

# e.g. fast-start.md -> Hades/fast-start
pages="Hades $(ls ../docs | sed -n 's/\(.*\)\.md/Hades\/\1/p' | tr '\n' ' ')"

if ! [ -d wiki.cusf.co.uk ]; then
	# Only import the latest revision of relevant pages
	git clone -c remote.origin.pages="$pages" \
	          -c remote.origin.shallow=true \
			  -c remote.origin.mwLogin='EllieClifford' \
	          -c remote.origin.mwPassword="$mwpassword" \
	          -c user.email="hades@cusf.co.uk" \
	          -c user.name="Hades Github Action" \
		mediawiki::https://wiki.cusf.co.uk
fi
