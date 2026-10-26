import Quickshell
import QtQuick
import QtQuick.Layouts

PopupWindow {
    id: noticePopup
    required property Item targetItem
    property real bottomMargin: 25
    property real shadowSize
    property color barColor
    property string command
    property string text: "Are you sure?"
    property string click
    property bool open: false

    anchor.window: noticePopup.targetItem.QsWindow.window
    anchor.rect.x: noticePopup.targetItem.QsWindow.window ? (noticePopup.targetItem.QsWindow.window.screen.width - implicitWidth) / 2 : 0
    anchor.rect.y: noticePopup.targetItem.QsWindow.window ? noticePopup.targetItem.QsWindow.window.screen.height - implicitHeight - noticePopup.bottomMargin : 0
    anchor.edges: Edges.Top | Edges.Left
    anchor.gravity: Edges.Bottom | Edges.Right
    implicitWidth: popupLayout.implicitWidth + 32 + noticePopup.shadowSize
    implicitHeight: popupLayout.implicitHeight + 32 + noticePopup.shadowSize
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
            barColor: noticePopup.barColor
            width: popupBg.width
            height: popupBg.height
        }

        Rectangle {
            id: popupBg
            width: parent.width - noticePopup.shadowSize
            height: parent.height - noticePopup.shadowSize
            color: noticePopup.barColor
        }

        ColumnLayout {
            id: popupLayout
            anchors.left: popupBg.left
            anchors.top: popupBg.top
            anchors.topMargin: 16
            anchors.leftMargin: 16
            spacing: 18

            Row {
                spacing: 8
                Layout.alignment: Qt.AlignHCenter

                Text {
                    text: "["
                    color: "#000000"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 16
                    font.weight: 900
                }

                Text {
                    text: noticePopup.text
                    color: "#000000"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 16
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

            Row {
                spacing: 20
                Layout.alignment: Qt.AlignHCenter

                Item {
                    width: 64
                    height: 32

                    BarShadow {
                        shadowOffsetX: agreedMouseArea.pressed ? 2 : 4
                        shadowOffsetY: agreedMouseArea.pressed ? 2 : 4
                        barColor: "#000000"
                        width: agreedBg.width
                        height: agreedBg.height

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
                        id: agreedBg
                        color: "#000000"
                        width: 64
                        height: 32
                        x: agreedMouseArea.pressed ? 2 : 0
                        y: agreedMouseArea.pressed ? 2 : 0

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
                            text: "󰄬"
                            color: "#ffffff"
                            font.family: "JetBrainsMono Nerd Font"
                            font.pixelSize: 24
                            font.weight: 900
                            anchors.centerIn: parent
                        }
                    }

                    MouseArea {
                        id: agreedMouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Quickshell.execDetached(["sh", "-c", noticePopup.command])
                    }
                }

                Item {
                    width: 64
                    height: 32

                    BarShadow {
                        shadowOffsetX: disagreeMouseArea.pressed ? 2 : 4
                        shadowOffsetY: disagreeMouseArea.pressed ? 2 : 4
                        barColor: "#000000"
                        width: disagreeBg.width
                        height: disagreeBg.height

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
                        id: disagreeBg
                        color: "#000000"
                        width: 64
                        height: 32
                        x: disagreeMouseArea.pressed ? 2 : 0
                        y: disagreeMouseArea.pressed ? 2 : 0

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
                            text: "󰜺"
                            color: "#ffffff"
                            font.family: "JetBrainsMono Nerd Font"
                            font.pixelSize: 20
                            font.weight: 900
                            anchors.centerIn: parent
                        }
                    }

                    MouseArea {
                        id: disagreeMouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: noticePopup.open = false
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

        onFinished: noticePopup.visible = false
    }
}
