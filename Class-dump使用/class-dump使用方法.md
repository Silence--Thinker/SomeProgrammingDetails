### class-dump使用方法
#### gitHub连接
[class-dump](https://github.com/nygard/class-dump)
#### 基本使用
##### 规则
###### **class-dump 文件位置 命令 源文件位置**
##### 获取头文件 
######** -H 获取头文件 -o 指定输出文件夹**
`/Applications/class-dump -H /Users/Silent/Music/WisdomTree\ 2017-04-26\ 17-43-32/Payload/WisdomTree.app/WisdomTree -o /Users/Silent/Desktop/Study/WiddomTreeHeader`
##### 查找某个方法
###### **-f 查找方法 setReloadForMessage:index: 方法名**
`/Applications/class-dump -f setReloadForMessage:index: /Users/Silent/Music/WisdomTree\ 2017-04-26\ 17-43-32/Payload/WisdomTree.app/WisdomTree`
##### 查看机器对指令集
###### **--list-arches** 
`/Applications/class-dump --list-arches /Users/Silent/Music/WisdomTree\ 2017-04-26\ 17-43-32/Payload/WisdomTree.app/WisdomTree`
##### 查看framework里面的
###### **直接拼接地址** 
`/Applications/class-dump /System/Library/Frameworks/AVFoundation.framework`
