# Centos 下的 Hadoop 安装脚本

## 参考

[Hadoop安装教程_伪分布式配置](http://dblab.xmu.edu.cn/blog/install-hadoop-in-centos)

## 使用方法

脚本完成的是Hadoop的伪分布式配置，集群请参考[Hadoop集群安装配置教程](http://dblab.xmu.edu.cn/blog/install-hadoop-cluster/)

前提条件：

- 以root身份登录
- 老师给的tar.gz在脚本的同目录下
  - 推荐先clone脚本，再上传文件到与脚本的同目录下

```shell
git clone https://github.com/dccif/HadoopInstall.git
cd HadoopInstall
chmod 755 centosinstall.sh
./centosinstall.sh
```

