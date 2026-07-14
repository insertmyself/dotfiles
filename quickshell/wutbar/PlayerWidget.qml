import QtQuick
import Quickshell
import "."

PanelWindow {
    id: playerWidget
    property bool revealed: false
    property bool buttonHovered: false

    anchors.bottom: true
    anchors.right: true
    implicitWidth: playerWidgetContent.width + 12 * 2
    implicitHeight: playerWidgetContent.height + 12 * 2.5
    exclusiveZone: 0
    color: "transparent"
    mask: Region {
        item: playerWidgetMouseArea
    }

    MouseArea {
        id: playerWidgetMouseArea
        width: playerWidgetContent.width + 12 * 2
        height: playerWidget.revealed ? playerWidgetContent.height + 12 * 2.5 : 10
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        hoverEnabled: true
        onEntered: {
            if (!playerWidget.buttonHovered) {
                playerWidget.revealed = true;
            }
        }
        onExited: {
            if (!playerWidget.buttonHovered) {
                playerWidget.revealed = false;
            }
        }
    }

    Item {
        anchors.fill: parent
        clip: true

        Rectangle {
            width: playerWidgetContent.width + 12 * 2
            height: playerWidgetContent.height + 12 * 2.5
            color: "#000000"
            border.color: "#ffffff"
            border.width: 2
            y: playerWidget.revealed ? 0 : height

            Behavior on y {
                NumberAnimation {
                    duration: 180
                    easing.type: Easing.OutCubic
                }
            }

            Row {
                id: playerWidgetContent
                anchors.centerIn: parent
                spacing: 8

                Column {
                    spacing: 34

                    Column {
                        spacing: 8

                        Image {
                            id: songAlbum
                            width: 220
                            height: 220
                            source: Shared.artUrl.length > 0 ? Shared.artUrl : Qt.resolvedUrl("assets/images/album.png")
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            asynchronous: true

                            Image {
                                anchors.fill: parent
                                source: Qt.resolvedUrl("assets/images/album.png")
                                fillMode: Image.PreserveAspectCrop
                                visible: songAlbum.status !== Image.Ready
                                z: -1
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
                                text: Shared.titleIcon + " " + Shared.titleText
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
                                text: Shared.artistIcon + " " + Shared.artistText
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
                    }

                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 10

                        Rectangle {
                            color: previousButtonHoverHandler.hovered ? "#656565" : "#ffffff"
                            width: 40
                            height: 40

                            Text {
                                text: ""
                                color: "#000000"
                                font.pixelSize: 18
                                font.family: "JetBrainsMono Nerd Font"
                                anchors.centerIn: parent
                            }

                            Behavior on color {
                                ColorAnimation {
                                    duration: 180
                                }
                            }

                            HoverHandler {
                                id: previousButtonHoverHandler
                                blocking: true
                                cursorShape: Qt.CursorShape.PointingHandCursor
                                onHoveredChanged: {
                                    playerWidget.buttonHovered = hovered;

                                    if (hovered) {
                                        playerWidget.revealed = true;
                                    } else {
                                        if (!playerWidgetMouseArea.containsMouse) {
                                            playerWidget.revealed = false;
                                        }
                                    }
                                }
                            }

                            TapHandler {
                                onTapped: Quickshell.execDetached(["playerctl", "-p", "spotify", "previous"])
                            }
                        }

                        Rectangle {
                            color: toggleButtonHoverHandler.hovered ? "#656565" : "#ffffff"
                            width: 40
                            height: 40

                            Text {
                                text: Shared.isPlaying ? "" : ""
                                color: "#000000"
                                font.pixelSize: 18
                                font.family: "JetBrainsMono Nerd Font"
                                anchors.centerIn: parent
                            }

                            Behavior on color {
                                ColorAnimation {
                                    duration: 180
                                }
                            }

                            HoverHandler {
                                id: toggleButtonHoverHandler
                                cursorShape: Qt.CursorShape.PointingHandCursor
                                blocking: true
                                onHoveredChanged: {
                                    playerWidget.buttonHovered = hovered;

                                    if (hovered) {
                                        playerWidget.revealed = true;
                                    } else {
                                        if (!playerWidgetMouseArea.containsMouse) {
                                            playerWidget.revealed = false;
                                        }
                                    }
                                }
                            }

                            TapHandler {
                                onTapped: Quickshell.execDetached(["playerctl", "-p", "spotify", "play-pause"])
                            }
                        }

                        Rectangle {
                            color: nextButtonHoverHandler.hovered ? "#656565" : "#ffffff"
                            width: 40
                            height: 40

                            Text {
                                text: ""
                                color: "#000000"
                                font.pixelSize: 18
                                font.family: "JetBrainsMono Nerd Font"
                                anchors.centerIn: parent
                            }

                            Behavior on color {
                                ColorAnimation {
                                    duration: 180
                                }
                            }

                            HoverHandler {
                                id: nextButtonHoverHandler
                                cursorShape: Qt.CursorShape.PointingHandCursor
                                blocking: true
                                onHoveredChanged: {
                                    playerWidget.buttonHovered = hovered;

                                    if (hovered) {
                                        playerWidget.revealed = true;
                                    } else {
                                        if (!playerWidgetMouseArea.containsMouse) {
                                            playerWidget.revealed = false;
                                        }
                                    }
                                }
                            }

                            TapHandler {
                                onTapped: Quickshell.execDetached(["playerctl", "-p", "spotify", "next"])
                            }
                        }
                    }
                }
            }
        }
    }
}
