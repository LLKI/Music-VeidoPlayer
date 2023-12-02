import QtQuick 2.15
import QtMultimedia 5.15
import QtQuick.Controls 2.15
import "qrc:/CusWidgets" as CusWidgets
import Skin 1.0
import QtGraphicalEffects 1.15

// 视频播放器，用于播放视频
Rectangle {
    id: root
    color: "black"
    property string source: ""
    MediaPlayer {
        id: mediaplayer
        source: root.source
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        source: mediaplayer
    }

    // 调节视频亮度对比度
    BrightnessContrast {
        id: brightnessContrast
        anchors.fill: videoOutput
        source: videoOutput
        brightness: 0.0
        contrast: 0.0
    }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: {
            videoControlbar.visible = false;
        }
    }

    MouseArea {
        id: playArea
        hoverEnabled: true
        anchors.fill: parent
        onClicked: {
            // 如果不是播放状态，那么就播放视频
            togglePlayback()
        }
        onEntered: {
                videoControlbar.visible = true;
                hideTimer.stop(); // 解决进度条闪烁问题
            }
            onExited: {
                hideTimer.start();
            }
    }
//    Keys.onPressed: {
//        console.log("Key Pressed: " + event.key);
//        if (event.key === Qt.Key_Space) {
//            togglePlayback();
//        }
//    }//为什么不触发啊啊啊啊
    //底部控制视频的部件
    VideoControlBar {
        id: videoControlbar
        height: 80
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        // 调节对比度和亮度
        onBrightnessChanged: {
            brightnessContrast.brightness = value
        }
        onContrastChanged: {
            brightnessContrast.contrast = value
        }
    }

    // 加载完成就播放视频
    Component.onCompleted: {
        if (root.source !== "") {
            mediaplayer.play()
        }
    }

    function togglePlayback() {
            if (mediaplayer.playbackState !== MediaPlayer.PlayingState) {
                mediaplayer.play();
            } else {
                mediaplayer.pause();
            }
        }
}
