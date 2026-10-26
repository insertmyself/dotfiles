pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import "../components"

Item {
    id: powerWidget
    property real shadowSize
    property color barColor

    width: 40 + powerWidget.shadowSize
    height: powerContent.implicitHeight + 8 + powerWidget.shadowSize

    BarShadow {
        id: powerShadow
        shadowOffsetX: powerMouseArea.pressed ? 2 : 4
        shadowOffsetY: powerMouseArea.pressed ? 2 : 4
        barColor: powerWidget.barColor
        width: powerBg.width
        height: powerBg.height

        Behavior on shadowOffsetX {
            NumberAnimation {
                duration: 80
                easing.type: Easing.OutQuad
            }
        }
        Behavior on shadowOffsetY {
            NumberAnimation {
                duration: 80
                easing.type: Easing.OutQuad
            }
        }
    }

    Rectangle {
        id: powerBg
        x: powerMouseArea.pressed ? 2 : 0
        y: powerMouseArea.pressed ? 2 : 0
        width: parent.width - powerWidget.shadowSize
        height: parent.height - powerWidget.shadowSize
        color: powerWidget.barColor

        Behavior on x {
            NumberAnimation {
                duration: 80
                easing.type: Easing.OutQuad
            }
        }
        Behavior on y {
            NumberAnimation {
                duration: 80
                easing.type: Easing.OutQuad
            }
        }
    }

    Row {
        id: powerContent
        anchors.centerIn: powerBg

        Text {
            text: "󰐥"
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 20
            font.weight: 900
        }
    }

    MouseArea {
        id: powerMouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: powerPopup.open = !powerPopup.open
        onEntered: {
            powerShadow.barColor = Qt.darker(powerWidget.barColor, 1.2);
            powerBg.color = Qt.darker(powerWidget.barColor, 1.2);
        }
        onExited: {
            powerShadow.barColor = powerWidget.barColor;
            powerBg.color = powerWidget.barColor;
        }
    }

    PopupWindow {
        id: powerPopup
        property bool open: false

        anchor.window: powerWidget.QsWindow.window
        anchor.rect.x: powerWidget.QsWindow.window ? (powerWidget.QsWindow.window.screen.width - implicitWidth) / 2 : 0
        anchor.rect.y: powerWidget.QsWindow.window ? (powerWidget.QsWindow.window.screen.height - implicitHeight) / 2 : 0
        anchor.edges: Edges.Top | Edges.Left
        anchor.gravity: Edges.Bottom | Edges.Right
        implicitWidth: popupLayout.implicitWidth + 32 + powerWidget.shadowSize
        implicitHeight: popupLayout.implicitHeight + 32 + powerWidget.shadowSize
        color: "transparent"
        onOpenChanged: {
            if (open) {
                visible = true;
                popupOpen.start();
            } else {
                popupClose.start();
            }
        }

        Item {
            id: popupContent
            anchors.fill: parent
            transformOrigin: Item.Top
            scale: 0.85
            y: -10

            BarShadow {
                id: popupShadow
                shadowOffsetX: 4
                shadowOffsetY: 4
                barColor: powerWidget.barColor
                width: popupBg.width
                height: popupBg.height
            }

            Rectangle {
                id: popupBg
                width: parent.width - powerWidget.shadowSize
                height: parent.height - powerWidget.shadowSize
                color: powerWidget.barColor
            }

            RowLayout {
                id: popupLayout
                anchors.left: popupBg.left
                anchors.top: popupBg.top
                anchors.topMargin: 16
                anchors.leftMargin: 16
                spacing: 15

                Item {
                    Layout.preferredWidth: 64
                    Layout.preferredHeight: 64

                    BarShadow {
                        shadowOffsetX: offMouseArea.pressed ? 2 : 4
                        shadowOffsetY: offMouseArea.pressed ? 2 : 4
                        barColor: "#000000"
                        width: offBg.width
                        height: offBg.height

                        Behavior on shadowOffsetX {
                            NumberAnimation {
                                duration: 80
                                easing.type: Easing.OutQuad
                            }
                        }
                        Behavior on shadowOffsetY {
                            NumberAnimation {
                                duration: 80
                                easing.type: Easing.OutQuad
                            }
                        }
                    }

                    Rectangle {
                        id: offBg
                        color: "#000000"
                        width: 64
                        height: 64
                        x: offMouseArea.pressed ? 2 : 0
                        y: offMouseArea.pressed ? 2 : 0

                        Behavior on x {
                            NumberAnimation {
                                duration: 80
                                easing.type: Easing.OutQuad
                            }
                        }
                        Behavior on y {
                            NumberAnimation {
                                duration: 80
                                easing.type: Easing.OutQuad
                            }
                        }

                        Text {
                            text: "󰚌"
                            color: "#ffffff"
                            font.family: "JetBrainsMono Nerd Font"
                            font.pixelSize: 26
                            font.weight: 900
                            anchors.centerIn: parent
                        }
                    }

                    MouseArea {
                        id: offMouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            noticePopup.text = "Shutdown?";
                            noticePopup.open = true;
                            noticePopup.command = "systemctl poweroff";
                        }
                    }
                }

                Item {
                    Layout.preferredWidth: 64
                    Layout.preferredHeight: 64

                    BarShadow {
                        shadowOffsetX: restartMouseArea.pressed ? 2 : 4
                        shadowOffsetY: restartMouseArea.pressed ? 2 : 4
                        barColor: "#000000"
                        width: restartBg.width
                        height: restartBg.height

                        Behavior on shadowOffsetX {
                            NumberAnimation {
                                duration: 80
                                easing.type: Easing.OutQuad
                            }
                        }
                        Behavior on shadowOffsetY {
                            NumberAnimation {
                                duration: 80
                                easing.type: Easing.OutQuad
                            }
                        }
                    }

                    Rectangle {
                        id: restartBg
                        color: "#000000"
                        width: 64
                        height: 64
                        x: restartMouseArea.pressed ? 2 : 0
                        y: restartMouseArea.pressed ? 2 : 0

                        Behavior on x {
                            NumberAnimation {
                                duration: 80
                                easing.type: Easing.OutQuad
                            }
                        }
                        Behavior on y {
                            NumberAnimation {
                                duration: 80
                                easing.type: Easing.OutQuad
                            }
                        }

                        Text {
                            text: "󰜉"
                            color: "#ffffff"
                            font.family: "JetBrainsMono Nerd Font"
                            font.pixelSize: 30
                            font.weight: 900
                            anchors.centerIn: parent
                        }
                    }

                    MouseArea {
                        id: restartMouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            noticePopup.text = "Reboot?";
                            noticePopup.open = true;
                            noticePopup.command = "systemctl reboot";
                        }
                    }
                }

                Item {
                    Layout.preferredWidth: 64
                    Layout.preferredHeight: 64

                    BarShadow {
                        shadowOffsetX: exitMouseArea.pressed ? 2 : 4
                        shadowOffsetY: exitMouseArea.pressed ? 2 : 4
                        barColor: "#000000"
                        width: exitBg.width
                        height: exitBg.height

                        Behavior on shadowOffsetX {
                            NumberAnimation {
                                duration: 80
                                easing.type: Easing.OutQuad
                            }
                        }
                        Behavior on shadowOffsetY {
                            NumberAnimation {
                                duration: 80
                                easing.type: Easing.OutQuad
                            }
                        }
                    }

                    Rectangle {
                        id: exitBg
                        color: "#000000"
                        width: 64
                        height: 64
                        x: exitMouseArea.pressed ? 2 : 0
                        y: exitMouseArea.pressed ? 2 : 0

                        Behavior on x {
                            NumberAnimation {
                                duration: 80
                                easing.type: Easing.OutQuad
                            }
                        }
                        Behavior on y {
                            NumberAnimation {
                                duration: 80
                                easing.type: Easing.OutQuad
                            }
                        }

                        Text {
                            text: "󰩈"
                            color: "#ffffff"
                            font.family: "JetBrainsMono Nerd Font"
                            font.pixelSize: 25
                            font.weight: 900
                            anchors.centerIn: parent
                        }
                    }

                    MouseArea {
                        id: exitMouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            noticePopup.text = "Exit?";
                            noticePopup.open = true;
                            noticePopup.command = "openbox --exit";
                        }
                    }
                }
            }
        }

        ParallelAnimation {
            id: popupOpen

            NumberAnimation {
                target: popupContent
                property: "scale"
                to: 1
                duration: 150
                easing.type: Easing.OutBack
            }

            NumberAnimation {
                target: popupContent
                property: "y"
                to: 0
                duration: 150
                easing.type: Easing.OutCubic
            }
        }

        ParallelAnimation {
            id: popupClose

            NumberAnimation {
                target: popupContent
                property: "scale"
                to: 0.85
                duration: 150
                easing.type: Easing.InCubic
            }

            NumberAnimation {
                target: popupContent
                property: "y"
                to: -10
                duration: 150
                easing.type: Easing.InCubic
            }

            onFinished: powerPopup.visible = false
        }
    }

    NoticePopup {
        id: noticePopup
        shadowSize: powerWidget.shadowSize
        barColor: powerWidget.barColor
        targetItem: powerWidget
    }
}
