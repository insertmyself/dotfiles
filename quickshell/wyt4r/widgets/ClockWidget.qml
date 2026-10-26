pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import "../components"

Item {
    id: clockWidget
    property real shadowSize
    property color barColor
    property SystemClock clockRef

    width: clockContent.implicitWidth + 16 + shadowSize
    height: clockContent.implicitHeight + 8 + shadowSize

    BarShadow {
        id: clockShadow
        shadowOffsetX: 4
        shadowOffsetY: 4
        barColor: clockWidget.barColor
        width: clockBg.width
        height: clockBg.height
    }

    Rectangle {
        id: clockBg
        width: parent.width - clockWidget.shadowSize
        height: parent.height - clockWidget.shadowSize
        color: clockWidget.barColor
    }

    RowLayout {
        id: clockContent
        anchors.centerIn: clockBg
        spacing: 10

        Text {
            text: "["
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 16
            font.weight: 900
        }

        Text {
            text: Qt.formatDateTime(clockWidget.clockRef.date, "hh:mm | dd/MM/yy")
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            font.weight: 900
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
