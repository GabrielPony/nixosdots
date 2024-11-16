#!/bin/sh

# 检查 dos2unix 是否已安装
if ! command -v dos2unix &> /dev/null; then
    echo "dos2unix 未安装，请先安装 dos2unix"
    exit 1
fi

# 计数器
processed=0
failed=0

# 遍历当前目录下的所有文件
find . -type f | while read -r file; do
    # 尝试转换文件
    if dos2unix "$file" 2>/dev/null; then
        echo "成功处理: $file"
        ((processed++))
    else
        echo "处理失败: $file"
        ((failed++))
    fi
done

# 输出统计信息
echo "----------------------------------------"
echo "处理完成!"
echo "成功处理文件数: $processed"
echo "处理失败文件数: $failed"

