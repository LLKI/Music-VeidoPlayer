import QtQuick 2.15
import Qt.labs.qmlmodels 1.0
import Skin 1.0
import Config 1.0

// 用于呈现视频列表的信息

Item {
    id: root
    property var columnWidths: [100,(width-300)*2/3, (width-300)/3, 200]
    signal doubleClicked(int row)
    property int fistColumnLeftPadding: 30
    // 表头（表格标题）
    Rectangle {
        id: tableHeader
        width: parent.width
        height: 50
        color: Skin.background
        Row {
            Repeater {//重复
                model: myMusicPlayer.musicTableModel.headerDatas  // 使用tableView.column会出现Model size of -1 is less than 0
                Rectangle {
                    width: tableView.columnWidthProvider(index)+tableView.columnSpacing//columnSpacing是自带的，表示列表的列之间的宽度 index是每个重复项的索引
                    height: tableHeader.height
                    color: "transparent"//透明
                    Text {
                        text: modelData
                        anchors.left: parent.left
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 10
                        font.family: Config.fontFamily
                        color: Skin.textColor
                        leftPadding:{
                            if (index === 0) return root.fistColumnLeftPadding
                            else return 0
                        }
                    }
                }
            }
        }
    }

    // 音乐列表视图
    TableView {
        id: tableView
        anchors.top: tableHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        implicitWidth: 100
        clip: true//防止代理项可以在列表视图外显示
        boundsBehavior: Flickable.StopAtBounds   // 关闭回弹效果
        property int selectedRow: -1   // 记录选中了哪一行
        columnWidthProvider: function(colum) { return root.columnWidths[colum] }
        onWidthChanged: {
            forceLayout()
        }

        rowHeightProvider: function(row) { return 50 }

        model: myMusicPlayer.musicTableModel//使用model传递数据
        delegate: Rectangle {  // 每一个delegate只表示一个cell，列宽由columnWidthProvider指定
            implicitWidth: 50
            color: {
                if (model.row === tableView.selectedRow) {
                    return Skin.currentTheme===1?Qt.lighter(Skin.background, 1.8):Qt.darker(Skin.background, 1.05)
                }
                else {
                    return (model.row % 2) ? Skin.background : (Skin.currentTheme===1?Qt.lighter(Skin.background, 1.15):Qt.lighter(Skin.background, 1.04))
                }
            }

            Text {
                text: display// 使用Qt::DisplayRole中的数据显示文本
                anchors.left: parent.left
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                color: Skin.textColor
                font.family: Config.fontFamily
                elide: Text.ElideRight   // 文字过长就显示省略号
                leftPadding: {
                    if (model.column === 0) {
                        return root.fistColumnLeftPadding
                    }
                    else {
                        return 0
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    tableView.selectedRow = model.row
                }
                // 双击某行则触发信号，便于播放
                onDoubleClicked: {
                    root.doubleClicked(model.row)
                }
            }
        }
    }
}
