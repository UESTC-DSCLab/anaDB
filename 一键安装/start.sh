#!/bin/bash

# Start Cassandra
CurDIR=$(pwd)
cd cassandra/bin
CASSANDRA=$(pwd)

# 在新的窗口启动cassandra
gnome-terminal --working-directory=$CASSANDRA -x bash -c "echo 'Starting Cassandra...'; sleep 1; ./cassandra -f; exec bash"

# 等待cassandea准备就绪才会启动kairosdb
read -p "请在cassandra就绪后输入回车键启动kairosdb" tmp

cd $CurDIR
cd kairosdb/bin
KAIROSDB=$(pwd)

# 新窗口中启动kairosdb
gnome-terminal --working-directory=$KAIROSDB -x bash -c "echo 'Starting KairosDB...'; sleep 1; ./kairosdb.sh run; exec bash"

exit 0