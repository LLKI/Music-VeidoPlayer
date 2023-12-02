这是一个基于QT/QML开发的音频视频播放器<br>
平台工具：QT，QML，JavaScript，node.js(用于部署网易云音乐API)
具体功能如下：
- 视频模块
  - 本地视频播放
  - 视频播放基本操作：暂停、调音量、亮度、曝光度、进度条
- 音频模块
  - 本地及在线音乐播放
  - 音乐MV播放
  - 歌词显示
  - 音乐播放基本操作：暂停、切换播放模式、调音量、切换歌曲

## 设计思路
### 视频模块
- 视频播放

   视频列表通过TableView实现，其代理（delegate）要显示的数据来自videoplayer.h的m_videoTableModel，当双击列表某一行时，触发VideoTable.qml中自定义的信号doubleClicked(int row)，该信号将页面切换到VideoSecondPage.qml（播放视频的页面），同时把双击的行号传给VideoSecondPage.qml，这样VideoSecondPage.qml就可以根据行号调用C++函数获取当前双击行对应的视频路径，播放视频
### 音频模块
- 音频播放
  - 本地音频：
    
      音频列表通过TableView实现，其代理（delegate）要显示的数据来自musicplayer.h的m_musicTableModel，当双击列表某一行时，触发MusicTable.qml中自定义的信号doubleClicked(int row)，该信号把双击的行号传给MusicControlBar.qml（控制音频播放等页面），这样MusicControlBar.qml就可以根据行号调用C++函数获取当前双击行对应的音频路径
  - 在线音频：

    与本地音频差不多，只是最后提供发送HTTP请求来获取歌曲连接进行播放
    
- 歌词滚动
  - 通过请求获取歌曲的LRC歌词文件，使用正则表达式进行提取，将歌词的时间戳和对应的歌词索引存入QMap中，时间戳是键，索引是值，再将歌词内容存入QStringList，通过歌曲播放时的`onPositionChanged`信号，获取到当前音乐播放进度pos，遍历QMap获取对应歌词的索引，通过QStringList进行调用
- 音频MV播放
  - 若该音频存在MV，则呈现视频图标，双击视频图标时，根据当前歌曲ID发送HTTP请求，获取到对应的MV进行播放
## 参考资料
- [基于Qt的网络音乐播放器（五）实现歌词滚动显示_qtlyrics类-CSDN博客](https://blog.csdn.net/Fdog_/article/details/108053624)
- [玩转Qml(3)-换皮肤 | 涛哥的博客 (jaredtao.github.io)](https://jaredtao.github.io/2019/05/12/玩转Qml(3)-换皮肤/#带三角形尖尖的弹窗组件)
- [QMLBook-Chinese](https://github.com/cwc1987/QmlBook-In-Chinese)https://github.com/cwc1987/QmlBook-In-Chinese

