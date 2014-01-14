#!/bin/sh

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: $0 from_branch [to_branch]"
    exit 1
fi

FROM_BRANCH=$1
TO_BRANCH=$2
if [ "$#" -ne 2 ]; then
    TO_BRANCH=$(git name-rev HEAD 2> /dev/null | awk "{ print \$2 }")
fi

git checkout $FROM_BRANCH
git fetch origin
git rebase origin/$FROM_BRANCH
if [ $FROM_BRANCH != $TO_BRANCH ]; then
    git checkout $TO_BRANCH
    git rebase $FROM_BRANCH
fi

