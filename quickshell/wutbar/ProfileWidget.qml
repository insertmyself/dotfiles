import QtQuick
import Quickshell
import "."

PanelWindow {
    id: profileWidget
    property bool revealed: false
    property bool buttonHovered: false

    anchors.bottom: true
    anchors.left: true
    implicitWidth: profileWidgetContent.width + 12 * 2
    implicitHeight: profileWidgetContent.height + 12 * 2.5
    exclusiveZone: 0
    color: "transparent"
    mask: Region {
        item: profileWidgetMouseArea
    }

    MouseArea {
        id: profileWidgetMouseArea
        width: profileWidgetContent.width + 12 * 2
        height: profileWidget.revealed ? profileWidgetContent.height + 12 * 2.5 : 10
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        hoverEnabled: true
        onEntered: {
            if (!profileWidget.buttonHovered) {
                profileWidget.revealed = true;
            }
        }
        onExited: {
            if (!profileWidget.buttonHovered) {
                profileWidget.revealed = false;
            }
        }
    }

    Item {
        anchors.fill: parent
        clip: true

        Rectangle {
            width: profileWidgetContent.width + 12 * 2
            height: profileWidgetContent.height + 12 * 2.5
            color: "#000000"
            border.color: "#ffffff"
            border.width: 2
            y: profileWidget.revealed ? 0 : height

            Behavior on y {
                NumberAnimation {
                    duration: 180
                    easing.type: Easing.OutCubic
                }
            }

            Row {
                id: profileWidgetContent
                anchors.centerIn: parent
                spacing: 8

                Column {
                    spacing: 34

                    Column {
                        spacing: 8

                        Image {
                            id: profilePicture
                            width: 220
                            height: 220
                            source: Qt.resolvedUrl("assets/images/profile.png")
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Row {
                            Text {
                                text: "[ "
                                color: "#ffffff"
                                font.pixelSize: 18
                                font.family: "JetBrainsMono Nerd Font"
                            }

                            Text {
                                text: "  " + Shared.username
                                color: "#ffffff"
                                font.pixelSize: 18
                                width: 180
                                font.family: "JetBrainsMono Nerd Font"
                                elide: Text.ElideRight
                            }

                            Text {
                                text: " ]"
                                color: "#ffffff"
                                font.pixelSize: 18
                                font.family: "JetBrainsMono Nerd Font"
                            }
                        }

                        Row {
                            Text {
                                text: "[ "
                                color: "#ffffff"
                                font.pixelSize: 18
                                font.family: "JetBrainsMono Nerd Font"
                            }

                            Text {
                                text: "  " + Shared.distro
                                color: "#ffffff"
                                font.pixelSize: 18
                                width: 180
                                font.family: "JetBrainsMono Nerd Font"
                                elide: Text.ElideRight
                            }

                            Text {
                                text: " ]"
                                color: "#ffffff"
                                font.pixelSize: 18
                                font.family: "JetBrainsMono Nerd Font"
                            }
                        }

                        Row {
                            Text {
                                text: "[ "
                                color: "#ffffff"
                                font.pixelSize: 18
                                font.family: "JetBrainsMono Nerd Font"
                            }

                            Text {
                                text: "󱪊  " + Shared.windowManager
                                color: "#ffffff"
                                font.pixelSize: 18
                                width: 180
                                font.family: "JetBrainsMono Nerd Font"
                                elide: Text.ElideRight
                            }

                            Text {
                                text: " ]"
                                color: "#ffffff"
                                font.pixelSize: 18
                                font.family: "JetBrainsMono Nerd Font"
                            }
                        }

                        Row {
                            Text {
                                text: "[ "
                                color: "#ffffff"
                                font.pixelSize: 18
                                font.family: "JetBrainsMono Nerd Font"
                            }

                            Row {
                                width: 180

                                Text {
                                    text: "  "
                                    color: "#ffffff"
                                    font.pixelSize: 18
                                    font.family: "JetBrainsMono Nerd Font"
                                }

                                Text {
                                    text: Shared.githubUsername
                                    color: githubHoverHandler.hovered ? "#656565" : "#ffffff"
                                    font.pixelSize: 18
                                    font.family: "JetBrainsMono Nerd Font"

                                    Behavior on color {
                                        ColorAnimation {
                                            duration: 180
                                        }
                                    }

                                    HoverHandler {
                                        id: githubHoverHandler
                                        cursorShape: Qt.CursorShape.PointingHandCursor
                                        blocking: true
                                        onHoveredChanged: {
                                            profileWidget.buttonHovered = hovered;

                                            if (hovered) {
                                                profileWidget.revealed = true;
                                            } else {
                                                if (!profileWidgetMouseArea.containsMouse) {
                                                    profileWidget.revealed = true;
                                                }
                                            }
                                        }
                                    }

                                    TapHandler {
                                        onTapped: Qt.openUrlExternally("https://github.com/" + Shared.githubUsername.replace(/\./g, ""))
                                    }
                                }
                            }

                            Text {
                                text: " ]"
                                color: "#ffffff"
                                font.pixelSize: 18
                                font.family: "JetBrainsMono Nerd Font"
                            }
                        }
                    }
                }
            }
        }
    }
}
