import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

PanelWindow {
    id: controllerWidget
    property bool revealed: false
    property bool buttonHovered: false

    implicitWidth: controllerWidgetContent.width + 12 * 2
    implicitHeight: controllerWidgetContent.height + 12 * 2
    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    exclusiveZone: 0
    color: "transparent"
    mask: Region {
        item: controllerWidgetMouseArea
    }

    MouseArea {
        id: controllerWidgetMouseArea
        width: controllerWidget.revealed ? controllerWidgetContent.width + 12 * 2 : 10
        height: controllerWidgetContent.height
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        hoverEnabled: true
        onEntered: {
            if (!controllerWidget.buttonHovered) {
                controllerWidget.revealed = true;
            }
        }
        onExited: {
            if (!controllerWidget.buttonHovered) {
                controllerWidget.revealed = false;
            }
        }
    }

    Item {
        anchors.fill: parent
        clip: true

        Rectangle {
            width: controllerWidgetContent.width + 12 * 2
            height: controllerWidgetContent.height + 12 * 2
            color: "#000000"
            border.color: "#ffffff"
            border.width: 2
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: controllerWidget.revealed ? 0 : -width

            Behavior on anchors.leftMargin {
                NumberAnimation {
                    duration: 180
                    easing.type: Easing.OutCubic
                }
            }

            Column {
                id: controllerWidgetContent
                anchors.centerIn: parent
                spacing: 8

                Row {
                    Text {
                        id: volumeIcon
                        text: "[   "
                        color: "#ffffff"
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 18
                    }

                    Item {
                        width: 200
                        height: 18
                        anchors.verticalCenter: parent.verticalCenter

                        Rectangle {
                            width: parent.width
                            height: parent.height
                            color: "#252525"
                        }

                        Rectangle {
                            width: (Pipewire.defaultAudioSink.audio?.volume ?? 0) * 200
                            height: parent.height
                            color: "#ffffff"
                        }
                    }

                    Text {
                        text: " ]"
                        color: "#ffffff"
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 18
                    }
                }

                Row {
                    Text {
                        id: brightnessIcon
                        text: "[ 󰃠  "
                        color: "#ffffff"
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 18
                    }

                    Item {
                        width: 200
                        height: 18
                        anchors.verticalCenter: parent.verticalCenter

                        Rectangle {
                            width: parent.width
                            height: parent.height
                            color: "#252525"
                        }

                        Rectangle {
                            width: Shared.brightness * 2
                            height: parent.height
                            color: "#ffffff"
                        }
                    }

                    Text {
                        text: " ]"
                        color: "#ffffff"
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 18
                    }
                }
            }
        }
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
}
