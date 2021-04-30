#!/bin/sh
#
# This file is part of Hades, a minimal Windows VM for SolidWorks.
# Copyright (C) 2021 Ellie Clifford, Henry Franks
#
# Hades is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your
# option) any later version.
#
# Hades is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public
# License for more details.
#
# You should have received a copy of the GNU Affero General Public
# License along with Hades. If not, see <https://www.gnu.org/licenses/>.

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
