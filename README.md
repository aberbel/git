Cambiado desarrollo por otra persona

# git

echo "# git" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/aberbel/git.git
git push -u origin main
Initialized empty Git repository in C:/Users/Casa/Desktop/gitdesa/.git/
warning: in the working copy of 'README.md', LF will be replaced by CRLF the next time Git touches it
[main (root-commit) c7c0d7b] first commit
1 file changed, 1 insertion(+)
create mode 100644 README.md
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Writing objects: 100% (3/3), 210 bytes | 210.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To https://github.com/aberbel/git.git

- [new branch] main -> main
  branch 'main' set up to track 'origin/main'.

git add .
git commit -m "Modificado fichero readme"
git push

Nueva rama desarrollo
Segundo merge
