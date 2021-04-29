#!/bin/bash -e

cd wiki.cusf.co.uk
git pull --rebase


# Briefly, do the following:
# Combine all the pages in docs/
# Replace links
# Remove extra license notices

markdown_tmpfile=$(mktemp)
cat ../../README.md >> $markdown_tmpfile
echo $markdown_tmpfile

for f in $(find ../../docs -name '*.md'); do
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
	$f >> $markdown_tmpfile
done

# Replace links to other sections
sed -i 's|\[[^\]]*](docs/\([^)]*\))|[[Hades#\1]]|g' $markdown_tmpfile

# Move License to the end

# Replace links to github
# too big brain for sed
perl -i -pe \
	's|]\((?!http)([^)]*)\)|](https://github.com/smh-my-head/hades/$1)|g' \
	$markdown_tmpfile

pandoc --from markdown --to mediawiki $markdown_tmpfile -o Hades.mw

git add .
git commit -m "Update Hades from latest on GitHub"
git push
