#!/bin/bash

# 替换your_process_name为要重启的进程的名称
PROCESS_NAME="h9-miner-spacemesh-linux-amd64"
# 替换start_command为启动进程的命令
START_COMMAND="h9-miner-spacemesh-linux-amd64"

# 使用pgrep命令获取进程的PID
PID=$(pgrep $PROCESS_NAME)

# 在整个文件系统中搜索文件
FILE_PATH=$(find / -name "start-gpu-miner.sh" 2>/dev/null | head -n 1)
START_PATH=$(find / -name $START_COMMAND 2>/dev/null | head -n 1)


if [ -n "$FILE_PATH" ]; then
    echo "找到文件，路径是: $FILE_PATH"
        if [ -z "$PID" ]; then
                echo "没有找到名为 $PROCESS_NAME 的进程，尝试直接启动..."
                nohup $START_PATH -gpuServer -license yes >>gpu-miner.log 2 >&1 & # 在后台启动进程
        else
                echo "找到名为 $PROCESS_NAME 的进程，PID为 $PID，正在尝试杀死它..."
                kill $PID  # 尝试优雅地终止进程

                # 等待进程终止，或者超时后强制杀死
                TIMEOUT=5
                COUNT=0
                while [ $COUNT -lt $TIMEOUT ]; do
                        sleep 1
                        if ! pgrep -x "$PROCESS_NAME" >/dev/null; then
                                break
                        fi
                        ((COUNT++))
                done

                if pgrep -x "$PROCESS_NAME" >/dev/null; then
                        echo "进程未在$TIMEOUT秒内终止，强制杀死..."
                        kill -9 $PID
                        sleep 1  # 确保进程被杀死
                fi

                echo "5秒后尝试重新启动进程..."
                sleep 5
                #cd H9-spacemesh-linux-3.0.3-5/
                nohup $START_PATH -gpuServer -license yes  >>gpu-miner.log 2 >&1 &
                #$START_COMMAND &  # 在后台启动进程
        fi
else
    echo "未找到启动文件,程序启动失败"
fi