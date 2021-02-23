# use fzf for interactive checkout
git-checkout() {
  git checkout $(git show-ref --heads | awk -F'/' '{print $3}' | fzf --layout=reverse --height=20% --border)
}

# execute rebase sequence on current branch
git-rebase() {
  local _cur_branch
  _cur_branch=$(git branch --show-current)
  git checkout master
  git fetch bitly
  git rebase bitly/master
  git checkout $_cur_branch
  git rebase master
}

# delete branch from local and remote
git-del-branch() {
  local _old_branch
  _old_branch=$(git branch --show-current)
  git checkout master
  git fetch bitly
  git rebase bitly/master
  git branch -D $_old_branch
  git push jharshman :$_old_branch
}

# The following two functions leverage git-stack.
# This facilitates a method of quickly switching between WIP 
# git branches similar to a directory stack.
# add a branch to the branch stack
git++() {
  local _cur_branch
  _cur_branch=$(git branch --show-current)
  git-stack push $_cur_branch
}

# pop a branch from the branch stack
git--() {
  git checkout $(git-stack pop)
}
