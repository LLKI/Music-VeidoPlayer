import QtQuick 2.0
import "qrc:/CusWidgets" as CusWidgets
import Skin 1.0
import Config 1.0

Item {
    id: root
    width: 300
    height: 50
    property string path: ""
    signal searchClicked(string content)
    signal choosePathClicked(string path)
    Row  {
        anchors.fill: parent
        spacing: 20

    }

    CusWidgets.CusButton {
        id: openDirBtn
        text: "选择目录"
        width: 100
        height: 40
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
            choosePathClicked(currentPath.text)
        }
    }
    Text {
        id: currentPath
        text: root.path
        anchors.leftMargin: 20
        anchors.left: openDirBtn.right
        anchors.verticalCenter: parent.verticalCenter
        color: Skin.textColor
        font.family: Config.fontFamily
    }
}
