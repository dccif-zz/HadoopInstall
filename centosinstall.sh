#!/bin/bash

# A Script to install hadoop and jdk

# Tool install
sudo yum install net-tools

# Setup User Account
sudo adduser hadoop

# Create Data Folders
sudo mkdir /data
sudo chown hadoop:hadoop /data

# install jdk in the same dir
cd ~
mkdir /usr/lib/jvm
sudo tar -xzf jdk-8u171-linux-x64.tar.gz -C /usr/lib/jvm/

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_171/jre/bin/java 2000
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_171/bin/javac 2000

echo JAVA_HOME=/usr/lib/jvm/jdk1.8.0_171 >> ~/.bashrc
echo JRE_HOME=$JAVA_HOME/jre >> ~/.bashrc
echo PATH=$PATH:$HOME/bin:$JAVA_HOME/bin >> ~/.bashrc
# Create a oraclejdk.sh ---
# sudo touch /etc/profile.d/oraclejdk.sh

# move a created sh

# To make Sure use the sh right away
# source /etc/profile.d/oraclejdk.sh

# hadoop2
sudo tar -xzf hadoop-2.6.0-cdh5.9.3.tar.gz -C /usr/local
cd /usr/local/
sudo mv hadoop-2.6.0-cdh5.9.3/ ./hadoop
sudo chown -R hadoop:hadoop ./hadoop/

su - hadoop -c "echo JAVA_HOME=/usr/lib/jvm/jdk1.8.0_171 >> /home/hadoop/.bashrc"
su - hadoop -c "echo JRE_HOME=$JAVA_HOME/jre >> /home/hadoop/.bashrc"
su - hadoop -c "echo PATH=$PATH:$HOME/bin:$JAVA_HOME/bin >> /home/hadoop/.bashrc"

su - hadoop -c "echo export HADOOP_HOME=/usr/local/hadoop >> /home/hadoop/.bashrc"
su - hadoop -c "echo export HADOOP_INSTALL=$HADOOP_HOME >> /home/hadoop/.bashrc"
su - hadoop -c "echo export HADOOP_MAPRED_HOME=$HADOOP_HOME >> /home/hadoop/.bashrc"
su - hadoop -c "echo export HADOOP_COMMON_HOME=$HADOOP_HOME >> /home/hadoop/.bashrc"
su - hadoop -c "echo export HADOOP_HDFS_HOME=$HADOOP_HOME >> /home/hadoop/.bashrc"
su - hadoop -c "echo export YARN_HOME=$HADOOP_HOME >> /home/hadoop/.bashrc"
su - hadoop -c "echo export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native >> /home/hadoop/.bashrc"
su - hadoop -c "echo export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin >> /home/hadoop/.bashrc"

su - hadoop -c "source /home/hadoop/.bashrc"

# ssh config
su - hadoop -c "ssh-keygen -t rsa"
#cd ~/.ssh/
su - hadoop -c "cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys"
su - hadoop -c "chmod 600 /home/hadoop/authorized_keys"

# cd /usr/local/hadoop/
# mkdir tmp
# mkdir tmp/dfs
# mkdir tmp/dfs/name
# mkdir tmp/dfs/data

# move xml files
# sudo su
cd ~
mv *.xml /usr/local/hadoop/etc/hadoop/
mv hadoop-env.sh /usr/local/hadoop/etc/hadoop
#mv hdfs-site.xml /usr/local/hadoop/etc/hadoop/
chown -R hadoop:hadoop /usr/local/hadoop

su - hadoop -c "/usr/local/hadoop/bin/hdfs namenode -format"
#"cd /usr/local/hadoop"
su - hadoop -c "/usr/local/hadoop/sbin/start-dfs.sh"
su - hadoop -c "/usr/local/hadoop/sbin/start-yarn.sh"      # 启动YARN
su - hadoop -c "/usr/local/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver"  # 开启历史服务器，才能在Web中查看任务运行情况