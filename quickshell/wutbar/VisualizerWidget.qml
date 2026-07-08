import QtQuick
import Quickshell
import "."

PanelWindow {
    id: visualizerWidget
    property bool revealed: false
    property bool buttonHovered: false

    anchors.bottom: true
    implicitWidth: visualizerWidgetContent.width + 12 * 2
    implicitHeight: visualizerWidgetContent.height + 12 * 2.2
    exclusiveZone: 0
    color: "transparent"
    mask: Region {
        item: visualizerWidgetMouseArea
    }

    MouseArea {
        id: visualizerWidgetMouseArea
        width: visualizerWidgetContent.width + 12 * 2
        height: visualizerWidget.revealed ? visualizerWidgetContent.height + 12 * 2.2 : 10
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        hoverEnabled: true
        onEntered: {
            if (!visualizerWidget.buttonHovered) {
                visualizerWidget.revealed = true;
            }
        }
        onExited: {
            if (!visualizerWidget.buttonHovered) {
                visualizerWidget.revealed = false;
            }
        }
    }

    Item {
        anchors.fill: parent
        clip: true

        Rectangle {
            width: visualizerWidgetContent.width + 12 * 2
            height: visualizerWidgetContent.height + 12 * 2.2
            color: "#000000"
            border.color: "#ffffff"
            border.width: 2
            y: visualizerWidget.revealed ? 0 : height
            anchors.horizontalCenter: parent.horizontalCenter

            Behavior on y {
                NumberAnimation {
                    duration: 180
                    easing.type: Easing.OutCubic
                }
            }

            Row {
                id: visualizerWidgetContent
                anchors.centerIn: parent
                spacing: 1

                Text {
                    text: "[ "
                    color: "#ffffff"
                    font.pixelSize: 18
                    font.family: "JetBrainsMono Nerd Font"
                }

                Repeater {
                    model: Shared.levels

                    Rectangle {
                        width: 18
                        height: modelData
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 4
                        color: "#ffffff"
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
