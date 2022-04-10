# Git Aliases

## git lol

Inspired by Edward Thomson : https://edwardthomson.com/blog/advent_day_9_git_lol.html

Added format padding, reordered values

```sh
git config --global alias.lol "log --pretty=format:'%Cred%h%Creset -%Creset %<(60,trunc)%s%Cgreen%<(13,trunc)(%cr) %C(bold blue)%<(15,trunc)<%an>%Creset %C(yellow)%d%Creset' --abbrev-commit --graph"
```

## git amend

Ammends all existing changes to the latest commit without changing commit message

```sh
git config --global alias.amend "commit --amend --no-edit"
```

## git reverce

Reverces changes in the latest commit and stages them
Improtant: "git revert" is a different command and works with commits

### Usage
* Reverce particular file(s): `git reverce ./src/Project/Program.cs`
* Reverce all files from a previous commit: `git reverce`

```sh
git config --global alias.reverce = "!f() { git checkout HEAD~1 -- ${@:-'*'} ; }; f"
```

## git whatsnew

Show changes after the latest commit/pulling/merging/etc
https://git.wiki.kernel.org/index.php/Aliases#:~:text=right%20HEAD...MERGE_HEAD-,What%27s%20new%3F,-To%20see%20what
https://www.atlassian.com/blog/git/advanced-git-aliases

```sh
git config --global alias.whatsnew = !sh -c 'git log $1@{1}..$1@{0} "$@"'
```

## clb

Delete Merged Branches
unix only

```sh
git branch --merged | egrep -v "(^\*|master|dev|release.*)" | xargs -r git branch -d
```
