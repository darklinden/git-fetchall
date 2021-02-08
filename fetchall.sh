#!/bin/bash

fetchFun() {
    echo 'fetch in '$(pwd)
    git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
    git fetch --all
    echo ''
}

cwd=$(pwd)

cd $cwd
fetchFun

sb=$(git config --file .gitmodules --get-regexp path | awk '{ print $2 }')
for f in $sb; do
  echo ""
  cd $cwd'/'$f
  fetchFun
done
