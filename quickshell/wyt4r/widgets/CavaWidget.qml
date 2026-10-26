pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "../components"

Item {
    id: cavaWidget
    property real shadowSize
    property color barColor
    property var cavaRef

    width: cavaContent.implicitWidth + 16 + cavaWidget.shadowSize
    height: cavaContent.implicitHeight + 8 + cavaWidget.shadowSize

    BarShadow {
        id: cavaShadow
        shadowOffsetX: 4
        shadowOffsetY: 4
        barColor: cavaWidget.barColor
        width: cavaBg.width
        height: cavaBg.height
    }

    Rectangle {
        id: cavaBg
        width: parent.width - cavaWidget.shadowSize
        height: parent.height - cavaWidget.shadowSize
        color: cavaWidget.barColor
    }

    RowLayout {
        id: cavaContent
        anchors.centerIn: cavaBg
        spacing: 6

        Row {
            spacing: 8

            Text {
                text: "["
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 16
                font.weight: 900
            }

            Repeater {
                model: cavaWidget.cavaRef.barCount
                delegate: Rectangle {
                    required property int index

                    anchors.verticalCenter: parent.verticalCenter
                    width: 10
                    color: "#000000"
                    height: Math.max(20, cavaWidget.cavaRef.bars[index] || 0) / 380 * 45
                }
            }

            Text {
                text: "]"
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 16
                font.weight: 900
            }
        }
    }
}
