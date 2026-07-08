import QtQuick
import Quickshell
import "."

PanelWindow {
    id: essentialsWidget
    property bool revealed: false
    property bool buttonHovered: false

    anchors.top: true
    anchors.right: true
    implicitWidth: essentialsWidgetContent.width + 12 * 2
    implicitHeight: essentialsWidgetContent.height + 12 * 2.2
    exclusiveZone: 0
    color: "transparent"
    mask: Region {
        item: essentialsWidgetMouseArea
    }

    SystemClock {
        id: clockData
        precision: SystemClock.Minutes
    }

    MouseArea {
        id: essentialsWidgetMouseArea
        width: essentialsWidgetContent.width + 12 * 2
        height: essentialsWidget.revealed ? essentialsWidgetContent.height + 12 * 2.2 : 10
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        hoverEnabled: true
        onEntered: {
            if (!essentialsWidget.buttonHovered) {
                essentialsWidget.revealed = true;
            }
        }
        onExited: {
            if (!essentialsWidget.buttonHovered) {
                essentialsWidget.revealed = false;
            }
        }
    }

    Item {
        anchors.fill: parent
        clip: true

        Rectangle {
            width: parent.width
            height: 50
            color: "#000000"
            border.color: "#ffffff"
            border.width: 2
            y: essentialsWidget.revealed ? 0 : -height

            Behavior on y {
                NumberAnimation {
                    duration: 180
                    easing.type: Easing.OutCubic
                }
            }

            Row {
                id: essentialsWidgetContent
                anchors.centerIn: parent
                spacing: 8

                Row {
                    Text {
                        id: dateIcon
                        text: "[ 󰃭"
                        color: "#ffffff"
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 18
                    }

                    Text {
                        id: dateLabel
                        text: " " + Qt.formatDate(clockData.date, "dd.MM.yyyy") + " ]"
                        color: "#ffffff"
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 18
                    }
                }

                Row {
                    Text {
                        id: wifiIcon
                        text: Shared.wifiIcon
                        color: "#ffffff"
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 18
                    }

                    Text {
                        id: wifiLabel
                        text: Shared.wifiText
                        color: "#ffffff"
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 18
                    }
                }

                Row {
                    Text {
                        id: clockIcon
                        text: "[ "
                        color: "#ffffff"
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 18
                    }

                    Text {
                        id: clockLabel
                        text: " " + Qt.formatTime(clockData.date, "hh:mm") + " ]"
                        color: "#ffffff"
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 18
                    }
                }
            }
        }
    }
}
