pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "../components"
import "../utils"

Item {
    id: systemWidget
    property real shadowSize
    property color barColor
    property var batteryRef
    property var cavaRef
    property var networkRef
    property var brightnessRef
    property var volumeRef

    width: systemContent.implicitWidth + 16 + shadowSize
    height: systemContent.implicitHeight + 8 + shadowSize

    BarShadow {
        id: systemShadow
        shadowOffsetX: 4
        shadowOffsetY: 4
        barColor: systemWidget.barColor
        width: systemBg.width
        height: systemBg.height
    }

    Rectangle {
        id: systemBg
        width: parent.width - systemWidget.shadowSize
        height: parent.height - systemWidget.shadowSize
        color: systemWidget.barColor
    }

    RowLayout {
        id: systemContent
        anchors.centerIn: systemBg
        spacing: 10

        Text {
            text: "["
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 16
            font.weight: 900
        }

        Row {
            spacing: 10

            Text {
                text: Icons.getBrightnessIcon(systemWidget.brightnessRef)
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 15
                font.weight: 900
            }

            Text {
                text: systemWidget.networkRef.icon
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 15
                font.weight: 900
            }

            Text {
                text: systemWidget.volumeRef.muted ? "" : Icons.getVolumeIcon(systemWidget.volumeRef)
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 15
                font.weight: 900

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: systemWidget.volumeRef.toggleMute()
                    onWheel: wheel => {
                        systemWidget.volumeRef.changeVolume(wheel.angleDelta.y > 0 ? 0.05 : -0.05);
                    }
                }
            }

            Text {
                text: Icons.getBatteryIcon(systemWidget.batteryRef)
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 15
                font.weight: 900
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
