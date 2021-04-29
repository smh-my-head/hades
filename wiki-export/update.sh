#!/bin/bash -e

cd wiki.cusf.co.uk
git pull --rebase


# Briefly, do the following:
# Combine all the pages in docs/
# Replace links
# Remove extra license notices
# Convert to mediawiki
# Prepend wiki-specific file

markdown_tmpfile=$(mktemp)
cat ../../README.md >> $markdown_tmpfile
echo $markdown_tmpfile

map=""
for f in $(ls ../../docs | grep '\.md'); do
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

# Replace links to other sections

map="$(echo $map | tr ':' '\n')"
IFS="
"
for i in $map; do
	# This is the most disgusting thing I have ever written
	sed -i "$(echo "$i" | awk -F"|" \
		'{print "s|\\[[^]]*](docs/"$1")|[[Hades#"$2"]]|g"}')" $markdown_tmpfile
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
