#!/bin/bash

# 配置Git信息
git_username="你的Git用户名"
git_email="602012854@qq.com"
repository_path="/Users/mengxiaopeng/Desktop/code/Tools"

# 配置Git用户信息
git config --global user.name "$git_username"
git config --global user.email "$git_email"

# 进入仓库目录
cd $repository_path

# 确保工作区是干净的
git checkout main
git pull origin main

# 提交次数
commit_count=10

# 文件列表
files=("file1.txt" "file2.txt" "file3.txt")

# 当前时间
current_time=$(date +%s)

# 过去一个月的秒数
seconds_in_month=$((30 * 24 * 60 * 60))

# 每次提交的时间间隔
interval=$((seconds_in_month / commit_count))

for ((i=1; i<=commit_count; i++))
do
    echo "进行第 $i 次提交"

    # 随机选择一个文件进行操作
    file_to_modify=${files[$RANDOM % ${#files[@]}]}

    # 随机决定是添加还是删除空行
    if [ $((RANDOM % 2)) -eq 0 ]; then
        echo "" >> $file_to_modify
        action="添加"
    else
        sed -i '' -e '$ d' $file_to_modify
        action="删除"
    fi

    # 计算提交的时间戳
    commit_time=$(($current_time - $seconds_in_month + $interval * $i))
    commit_date=$(date -r $commit_time +"%Y-%m-%dT%H:%M:%S")

    # 添加修改并提交
    git add $file_to_modify
    GIT_COMMITTER_DATE="$commit_date" git commit --date="$commit_date" -m "第 $i 次提交 - $action 空行"

    # 推送到远程仓库
    git push origin main

    # 等待一段时间再进行下一次提交
    sleep 5
done

echo "所有提交完成！"
