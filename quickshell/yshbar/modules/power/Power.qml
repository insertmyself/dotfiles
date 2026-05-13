pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.modules.dialog

PanelWindow {
    id: powerWidgetRoot

    required property int powerWidgetHeight
    required property int powerWidgetWidth
    required property int iconSize

    property bool isVisible: false

    implicitWidth: powerWidgetRoot.powerWidgetWidth
    implicitHeight: powerWidgetRoot.powerWidgetHeight
    anchors.right: true
    margins.right: 10
    visible: isVisible
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay

    function showWidget() {
        isVisible = true;
        powerWidgetWindow.scale = 1.0;
        powerWidgetTimer.restart();
    }

    function hideWidget() {
        powerWidgetWindow.scale = 0.0;
        powerWidgetDelayTimer.restart();
    }

    Timer {
        id: powerWidgetTimer
        interval: 3500
        repeat: false
        onTriggered: powerWidgetRoot.hideWidget()
    }

    Timer {
        id: powerWidgetDelayTimer
        interval: 800
        repeat: false
        onTriggered: {
            powerWidgetRoot.isShowing = false;
        }
    }

    Rectangle {
        id: powerWidgetWindow
        color: "#000000"
        anchors.fill: parent
        border.width: 2
        border.color: "#ffffff"
        scale: 0.0
        transformOrigin: Item.Right

        Behavior on scale {
            NumberAnimation {
                duration: 600
                easing.type: Easing.InOutExpo
            }
        }

        Rectangle {
            id: powerWidgetWindowTitle
            color: "#ffffff"
            width: 50
            height: 50

            Text {
                id: powerWidgetWindowTitleText
                text: "PWR"
                color: "#000000"
                font.pixelSize: 18
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                anchors.centerIn: parent
                font.family: "JetBrainsMono Nerd Font Propo"
                font.weight: 900
            }
        }

        Text {
            text: ""
            color: powerIconMouseArea.containsMouse ? "#959595" : "#ffffff"
            font.pixelSize: powerIconMouseArea.containsMouse ? powerWidgetRoot.iconSize + 4 : powerWidgetRoot.iconSize
            renderType: Text.NativeRendering
            font.hintingPreference: Font.PreferFullHinting
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -20
            font.family: "JetBrainsMono Nerd Font Propo"
            font.weight: 900

            MouseArea {
                id: powerIconMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onClicked: shutdownDialog.showDialog()
                onEntered: powerWidgetTimer.stop()
                onExited: powerWidgetTimer.restart()
            }

            Behavior on color {
                ColorAnimation {
                    duration: 220
                }
            }

            Behavior on font.pixelSize {
                NumberAnimation {
                    duration: 240
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Text {
            text: ""
            color: rebootIconMouseArea.containsMouse ? "#959595" : "#ffffff"
            font.pixelSize: rebootIconMouseArea.containsMouse ? powerWidgetRoot.iconSize + 8 : powerWidgetRoot.iconSize + 4
            renderType: Text.NativeRendering
            font.hintingPreference: Font.PreferFullHinting
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 22
            font.family: "JetBrainsMono Nerd Font Propo"
            font.weight: 900

            MouseArea {
                id: rebootIconMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onClicked: rebootDialog.showDialog()
                onEntered: powerWidgetTimer.stop()
                onExited: powerWidgetTimer.restart()
            }

            Behavior on color {
                ColorAnimation {
                    duration: 220
                }
            }

            Behavior on font.pixelSize {
                NumberAnimation {
                    duration: 240
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Text {
            text: "󰈆"
            color: exitIconMouseArea.containsMouse ? "#959595" : "#ffffff"
            font.pixelSize: exitIconMouseArea.containsMouse ? powerWidgetRoot.iconSize + 4 : powerWidgetRoot.iconSize + 2
            renderType: Text.NativeRendering
            font.hintingPreference: Font.PreferFullHinting
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 66
            font.family: "JetBrainsMono Nerd Font Propo"
            font.weight: 900

            MouseArea {
                id: exitIconMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onClicked: exitDialog.showDialog()
                onEntered: powerWidgetTimer.stop()
                onExited: powerWidgetTimer.restart()
            }

            Behavior on color {
                ColorAnimation {
                    duration: 220
                }
            }

            Behavior on font.pixelSize {
                NumberAnimation {
                    duration: 240
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Dialog {
            id: shutdownDialog
            dialogHeight: 150
            dialogWidth: 200
            body: "Shutdown?"
            dialTitle: "Power"

            onAccepted: shutdownConfirmationDialog.showDialog()

            onDenied: shutdownDialog.hideDialog()
        }

        Dialog {
            id: rebootDialog
            dialogHeight: 150
            dialogWidth: 200
            body: "Reboot?"
            dialTitle: "Power"

            onAccepted: rebootConfirmationDialog.showDialog()

            onDenied: rebootDialog.hideDialog()
        }

        Dialog {
            id: exitDialog
            dialogHeight: 150
            dialogWidth: 200
            body: "Exit?"
            dialTitle: "Session"

            onAccepted: exitConfirmationDialog.showDialog()

            onDenied: exitDialog.hideDialog()
        }

        Dialog {
            id: rebootConfirmationDialog
            dialogHeight: 150
            dialogWidth: 200
            body: "Are you sure?"
            dialTitle: "Confirmation"

            onAccepted: Quickshell.execDetached(["sh", "-c", "reboot"])

            onDenied: rebootConfirmationDialog.hideDialog()
        }

        Dialog {
            id: shutdownConfirmationDialog
            dialogHeight: 150
            dialogWidth: 200
            body: "Are you sure?"
            dialTitle: "Confirmation"

            onAccepted: Quickshell.execDetached(["sh", "-c", "poweroff"])

            onDenied: shutdownConfirmationDialog.hideDialog()
        }

        Dialog {
            id: exitConfirmationDialog
            dialogHeight: 150
            dialogWidth: 200
            body: "Are you sure?"
            dialTitle: "Confirmation"

            onAccepted: Quickshell.execDetached(["sh", "-c", "niri msg action quit --skip-confirmation"])

            onDenied: exitConfirmationDialog.hideDialog()
        }
    }
}
