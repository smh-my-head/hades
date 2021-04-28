#!/bin/sh -e
# -e causes an exit on failure

cd wiki.cusf.co.uk
git pull --rebase

pandoc --from markdown --to mediawiki ../../README.md -o Hades.mw
mkdir -p Hades && cd Hades
for f in $(ls ../../../docs | grep '\.md'); do
	wiki_name="$(echo $f | sed 's/\.md/\.mw/')"
	pandoc --from markdown --to mediawiki "../../../docs/$f" -o "$wiki_name"
done
cd -
git add .
git commit -m "Update Hades from latest on GitHub"
git push
