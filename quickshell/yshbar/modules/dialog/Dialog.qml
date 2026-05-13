import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls

PanelWindow {
    id: dialogWindowRoot

    signal accepted
    signal denied

    required property int dialogWidth
    required property int dialogHeight
    required property string dialTitle

    property string body: "Are you sure?"
    property bool isVisible: false

    implicitWidth: dialogWindowRoot.dialogWidth
    implicitHeight: dialogWindowRoot.dialogHeight
    color: "transparent"
    visible: isVisible
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Top

    function showDialog() {
        isVisible = true;
        dialogWindowContainer.scale = 1.0;
        dialogWindowTimer.restart();
    }

    function hideDialog() {
        dialogWindowContainer.scale = 0.0;
        dialogWindowDelayTimer.restart();
    }

    Timer {
        id: dialogWindowTimer
        interval: 3000
        repeat: false
        onTriggered: dialogWindowRoot.hideDialog()
    }

    Timer {
        id: dialogWindowDelayTimer
        interval: 800
        repeat: false
        onTriggered: {
            dialogWindowRoot.isVisible = false;
        }
    }

    Rectangle {
        id: dialogWindowContainer
        anchors.fill: parent
        color: "#000000"
        border.color: "#ffffff"
        border.width: 2
        scale: 0.0
        transformOrigin: Item.Center

        Behavior on scale {
            NumberAnimation {
                duration: 550
                easing.type: Easing.InOutExpo
            }
        }

        Rectangle {
            id: dialogWindowItems
            width: parent.width
            height: 30
            color: "#ffffff"
            border.color: "#ffffff"
            border.width: 2

            Text {
                id: dialogWindowTitle
                text: dialogWindowRoot.dialTitle
                anchors.centerIn: parent
                color: "#000000"
                font.pixelSize: 18
                font.family: "JetBrainsMono Nerd Font Propo"
                font.weight: 900
                renderType: Text.NativeRendering
            }
        }

        Text {
            id: dialogWindowBody
            text: dialogWindowRoot.body
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -5
            color: "#ffffff"
            font.pixelSize: 15
            font.family: "JetBrainsMono Nerd Font Propo"
            font.weight: 900
            renderType: Text.NativeRendering
            wrapMode: Text.Wrap
        }

        Row {
            id: dialogWindowButtons
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 40
            spacing: 12

            Button {
                id: falseButton
                hoverEnabled: true
                leftPadding: 20
                rightPadding: 20

                contentItem: Text {
                    text: "No"
                    font.pixelSize: falseButton.hovered ? 17 : 15
                    color: falseButton.hovered ? "#444444" : "#000000"
                    font.family: "JetBrainsMono Nerd Font Propo"
                    font.weight: 900
                    renderType: Text.NativeRendering

                    Behavior on font.pixelSize {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                background: Rectangle {
                    color: "#ffffff"
                    border.color: "#ffffff"
                    border.width: 2
                }

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                    onHoveredChanged: {
                        if (hovered === true) {
                            dialogWindowTimer.stop();
                        } else {
                            dialogWindowTimer.restart();
                        }
                    }
                }

                onClicked: {
                    dialogWindowRoot.denied();
                    dialogWindowRoot.hideDialog();
                }
            }

            Button {
                id: trueButton
                leftPadding: 20
                rightPadding: 20
                hoverEnabled: true

                contentItem: Text {
                    text: "Yes"
                    font.pixelSize: trueButton.hovered ? 17 : 15
                    color: trueButton.hovered ? "#444444" : "#000000"
                    font.family: "JetBrainsMono Nerd Font Propo"
                    font.weight: 900
                    renderType: Text.NativeRendering

                    Behavior on font.pixelSize {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                background: Rectangle {
                    color: "#ffffff"
                    border.color: "#ffffff"
                    border.width: 2
                }

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                    onHoveredChanged: {
                        if (hovered === true) {
                            dialogWindowTimer.stop();
                        } else {
                            dialogWindowTimer.restart();
                        }
                    }
                }

                onClicked: {
                    dialogWindowRoot.accepted();
                    dialogWindowRoot.hideDialog();
                }
            }
        }
    }
}
