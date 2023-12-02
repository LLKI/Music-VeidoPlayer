import QtQuick 2.15
import Skin 1.0
import QtGraphicalEffects 1.15
import "qrc:/CusWidgets" as CusWidgets
import "qrc:/Delegate" as Dele

Rectangle {
    id: root
    implicitWidth: 10
    implicitHeight: 400
    color: Skin.mainColor
    property int currentIndex: leftLV.currentIndex

    Column {
        anchors.fill: parent
        ListView {
            id: leftLV
            model: ListModel {
                ListElement {iconPath: "qrc:/source/icons/videoplayer.png"}
                ListElement {iconPath: "qrc:/source/icons/musicplayer.png"}
            }

            width: parent.width
            height: parent.height
            delegate: leftbar
            currentIndex: 0

            Component {
                id: leftbar
                Dele.LeftNaviDelegate {
                    width: ListView.view.width
                    height: ListView.view.height*1/2
                }
            }
        }
    }
}
