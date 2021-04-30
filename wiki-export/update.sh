#!/bin/bash
# Can't actually remember what bashism I thought i was using (and can't find
# one) but don't want to break it so...
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

cd wiki.cusf.co.uk
git pull --rebase


# Briefly, do the following:
# Combine all the pages in docs/
# Replace links
# Remove extra license notices
# Convert to mediawiki
# Prepend wiki-specific file

fileorder="install-with-image.md
install.md
fast-start.md
ssh.md
minify.md
windows-tweaks.md
dracula.md
"

markdown_tmpfile=$(mktemp)

map="" # filename|title
for f in $fileorder; do
	# get mapping of section names to file names
	map="$map:$f|$(sed -n 's/^# *//p' ../../docs/$f | head -n1)"

	echo >> $markdown_tmpfile
	# Ripgrep for this one. I'm not writing a crazy perl/awk script for
	# something so simple
	# Remove license
	rg -vUF 'This file is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].
See [DOC_LICENSE](../DOC_LICENSE).

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png' \
	../../docs/$f >> $markdown_tmpfile
done

# Fix links to other sections

map="$(echo $map | tr ':' '\n')"
IFS="
"
for i in $map; do
	# This is the most disgusting thing I have ever written
	sed -i "$(echo "$i" | awk -F"|" \
		'{print "s|\\[[^]]*](docs/"$1")|[[Hades#"$2"\\|"$2"]]|g"}')" \
		$markdown_tmpfile
done

# Replace links to github
# too big brain for sed
perl -i -pe \
	's|]\((?!http)([^)]*)\)|](https://github.com/smh-my-head/hades/$1)|g' \
	$markdown_tmpfile


cp ../wiki.mw Hades.mw
pandoc --from markdown --to mediawiki $markdown_tmpfile >> Hades.mw

git add .
git commit -m "Update Hades from latest on GitHub"
git push
