import QtQuick 2.15
import Skin 1.0
import Config 1.0
import QtQuick.Layouts 1.3
import Lyrics 1.0


Rectangle {
    id: root
    color: Skin.background
    property int lyricIndex: -1

    Lyrics{id:lyrics}
    property alias imageSource: lyrics.picUrl
    //图片
    Item {
        id: leftpanel
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        width: parent.width / 2

        Item {
            width: Math.min(leftpanel.width, 250)
            height: width
            clip: true // 应用裁剪效果
            anchors.centerIn: parent
            Image {
                id: songImage
                width: parent.width
                height: parent.height
                fillMode: Image.PreserveAspectCrop // 设置为 Image.PreserveAspectCrop 以裁剪为正圆形
                source: lyricIndex === -1 ? "qrc:/source/images/defaultsinger.png" : imageSource
                anchors.centerIn: parent
                function updataPic(){
                    songImage.source=lyrics.picUrl
                    if(songImage.source==="")
                    {
                        songImage.source="qrc:/source/images/defaultsinger.png"
                    }
                }
                Timer {
                            id: imageUpdateTimer
                            interval: 1000
                            running: true
                            repeat: true
                            onTriggered: songImage.updataPic()
                        }
            }

//            Behavior on rotation {
//                NumberAnimation {
//                    duration: 1000 // 旋转动画的持续时间，单位为毫秒
//                    loops: Animation.Infinite // 无限循环
//                    property: "rotation"
//                    from: -360 // 设置为负的旋转角度，使动画立即开始旋转
//                    to: 0
//                }
//            }
        }
    }
    //歌词
    Item {
        id: rightpanel
        anchors.right: parent.right
        anchors.left: leftpanel.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top

        ListView {
            id: lyricsList
            width: parent.width
            height: parent.height*3/4
            anchors.centerIn: parent
            model: myMusicPlayer.lyricModel
            spacing: 40
            preferredHighlightBegin: height / 2 - 10
            preferredHighlightEnd: height / 2 + 10
            highlightRangeMode: ListView.StrictlyEnforceRange
            clip: true
            currentIndex: lyricIndex===-1?currentIndex:lyricIndex  // -1表示当前没有要显示的歌词，没有歌词显示就显示当前显示的那一句歌词

            delegate: Text {
                id: lyric
                text: display
                horizontalAlignment: Text.AlignHCenter
                width: lyricsList.width
                height: contentHeight
                color: {
                    if (lyricsList.currentIndex === index) {
                        if (Skin.currentTheme===1) {
                            return Skin.textColor
                        } else {
                            return Skin.mainColor
                        }
                    }  else {
                        if (Skin.currentTheme===1) {
                            return Qt.darker(Skin.textColor, 1.5)
                        } else {
                            return Skin.textColor
                        }
                    }
                }

                font.family: Config.fontFamily
                font.pixelSize: 20
            }

        }
    }
}
