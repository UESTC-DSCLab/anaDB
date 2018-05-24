#!/bin/bash

# Download Cassandra from http://mirror.bit.edu.cn/apache/cassandra/3.11.2/apache-cassandra-3.11.2-bin.tar.gz
# and KairosDB from https://github.com/kairosdb/kairosdb/releases/download/v1.2.1/kairosdb-1.2.1-1.tar.gz

# 这里调用wget工具下载cassandra， 并使用tar解压
echo "下载并解压Cassandra"
wget -O- http://mirror.bit.edu.cn/apache/cassandra/3.11.2/apache-cassandra-3.11.2-bin.tar.gz | tar -xz

# 重命名文件夹，便于后续操作
mv apache-cassandra-3.11.2 cassandra

echo "下载并解压KairosDB"

if [ -f "/usr/bin/google-chrome" ]; then
    echo "即将使用chrome下载kairosdb，请保存到本文件夹内"
    read -p "输入任意键开始下载" tmp
    google-chrome https://github.com/kairosdb/kairosdb/releases/download/v1.2.1/kairosdb-1.2.1-1.tar.gz
elif [ -f "/usr/bin/firefox" ]; then
    echo "即将使用firefox下载kairosdb,请保存到本文件夹内"
    read -p "输入任意键开始下载" tmp
    firefox https://github.com/kairosdb/kairosdb/releases/download/v1.2.1/kairosdb-1.2.1-1.tar.gz 
else
    echo "由于命令行下载github上面的东西较慢，请使用其他工具下载kairosdb的压缩包到本文件夹下，链接如下："
    echo "https://github.com/kairosdb/kairosdb/releases/download/v1.2.1/kairosdb-1.2.1-1.tar.gz"
fi

read -p "请在下载完成后输入回车键继续：" tmp

if [ ! -f "./kairosdb-1.2.1-1.tar.gz" ];then
    echo "未找到kairosdb-1.2.1-1.tar.gz文件，即将退出..."
    echo "BYE-BYE"
    exit 1
fi

# 解压kairosdb
tar -zxf kairosdb-1.2.1-1.tar.gz && rm kairosdb-1.2.1-1.tar.gz

# 安装Grafana
sudo dpkg -i grafana_5.1.3_amd64.deb 

# 配置Grafana-service
sudo /bin/systemctl enable grafana-server.service

# 安装grafana数据库插件
echo "开始安装Grafana插件，支持时序数据库将数据导入Grafana"
sudo grafana-cli plugins install grafana-kairosdb-datasource

echo "安装完毕，重启grafana完成安装"
sudo service grafana-server restart

# 记住当前目录
CurDIR=$(pwd) 

# 进入kairosdb的配置目录，准备修改kairosdb的配置，使其使用cassandra存储
cd kairosdb/conf/

# 注释掉默认的H2存储引擎
sed 's/^kairosdb.service.datastore=org.kairosdb.datastore.h2.H2Module/#&/' kairosdb.properties -i

# 去掉cassandra的注释
sed 's/^#\(kairosdb.service.datastore=org.kairosdb.datastore.cassandra.CassandraModule\)/\1/' kairosdb.properties -i

# 回到根目录
cd $CurDIR

# 询问是否启动kairosDB
echo "if you want to run kairosDB now? y/n"

# 获取用户输入
read choice

# 用户输入为y， 调用start.sh脚本启动kairosdb
if [ $choice == "y" ] || [ $choice == "Y" ]; then 
    echo "starting now..."
    exec ./start.sh
else
    echo "BYE-BYE"
fi

exit 0
