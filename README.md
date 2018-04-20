# luban


How to write gitignore files to include only certain file extensions
*
!.gitattributes
!.gitignore
!readme.md
!.gitkeep
!*.php
!*/

ln -s ~/Dropbox/my_workspace/luban/config_stuff/flake8 .flake8rc

https://rtyley.github.io/bfg-repo-cleaner/

git reset filename.txt

Will remove a file named filename.txt from the current index, the "about to be committed" area, without changing anything else.

To undo git add . use git reset (no dot).

git lfs migrate import --verbose --everything -I="*.pdf"
git push --all origin
git push --all --force origin
