# After adding new files and folders to .gitignore in an exiting repo

#remove cached
git rm -r --cached .

#re-stage all file(exclude .gitignore files and folders)
git add .

#commit the new change
git commit -m ".gitignore is now working"