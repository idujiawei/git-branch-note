#!/bin/bash
# 遍历，输出本地分支备注
function echoBranchNote() {
  # 获取本地分支
  branches=`git branch --list`

  # 遍历
  while read -r branch; do
    # 当前分支前面会带 *，干掉 *
    clean_branch_name=${branch//\*\ /}
    
    # 获取当前分支备注
    note=`git config branch.$clean_branch_name.note`

    # 判断是否前面带*
    if [ "${branch::1}" == "*" ]; then
      echo -e "\e[1;34m$branch\e[0m $note"
    else
      printf "  $branch $note\n"
    fi
  done <<< "$branches"
}

# 判断是否带有参数
# 没有，输出分支的备注
if [[ "$1" = "" ]]; then
echoBranchNote
else
# 有参数
# 获取当前分支名
branch_name=`git symbolic-ref --short HEAD`

# 为当前分支设置备注
git config branch.$branch_name.note $1

# 调用方法，输出全部分支的备注
echoBranchNote
fi