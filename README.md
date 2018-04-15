# anaDB

## 使用[Intellij Idea](https://www.jetbrains.com/idea/)调试运行

1. 克隆项目到本地

```bash
$ git@github.com:UESTC-DSCLab/anaDB.git
```

2. 使用Intellij Idea打开项目

打开Intellij Idea，选择`open`选项，打开第一步中克隆下来的项目

3. 设置Intellij Idea的JDK

选择菜单栏中的`File`->`Project Structure`，找到左侧的`SDKS`选项，点击`+`号，找到你的`jdk`目录，点击确认。

*请不要使用jdk9,我使用jdk9会出现各种错误*

4. 编译项目

选择菜单栏中的`Build`->`Build Project`选项，编译/构建项目，生成`class`文件。

5. 配置启动参数

打开菜单栏中的`Run`->`Edit Configurations`选项。点击`+`号，选择`Application`选项，然后设置以下参数。

|选项 | 参数值 |
|:--:|:--:|
| Name | main (随便取，此处为了方便第7步的说明设置成main)|
| Main class | `org.kairosdb.core.Main` |
| Program arguments | `-c run -p pathto/kairosdb.properties`(`-p`后面的是你的配置文件路径，请用绝对路径) |

*本项目提供了一个设置好的配置文件(使用cassandra)*

6. 启动`Cassandra`

找到你下载的`Cassandra`目录，运行如下命令,启动cassandra。
```bash
$ ./bin/cassandra -f
```

7. 启动KairosDB 

打开`Intellij Idea`菜单栏中的`Run`，选择`Run 'main'`(main为你在第5步设置的`Name`)。

也可以通过右上方的几个绿色按钮`启动项目`或者`调试项目`，在代码左侧行号处点击设置断点。

## 一键安装运行Cassandra和KairosDB 

下载`install.sh`和`start.sh`到一个单独的文件夹内（等下将会把下载到的`Cassandra`和`KairosDB`都放到该文件夹下面），然后运行`install.sh`即可。

如果运行`install.sh`的过程中你选择了不启动kairosDB，你可以通过运行`start.sh`来启动他们。