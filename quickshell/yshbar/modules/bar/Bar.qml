import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.modules.cad
import qs.modules.workspace
import qs.modules.power
import qs.modules.battery
import qs.modules.brightness
import qs.modules.pipewire
import qs.modules.network

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: mainBar

            required property ShellScreen modelData
            readonly property int barWidth: Math.min(1440, modelData.width - 30)

            screen: modelData
            implicitWidth: barWidth
            implicitHeight: 45
            anchors.top: true
            margins.top: 10
            margins.bottom: 8
            WlrLayershell.layer: WlrLayer.Top

            Rectangle {
                anchors.fill: parent
                color: "#000000"
                border.width: 2
                border.color: "#ffffff"
                radius: 0

                Rectangle {
                    id: menuLogo
                    width: 50
                    height: mainBar.implicitHeight
                    color: "#ffffff"
                    anchors.left: parent.left

                    Text {
                        id: menuLogoText
                        text: ""
                        color: menuLogoMouseArea.containsMouse ? "#959595" : "#000000"
                        font.family: "JetBrainsMono Nerd Font Propo"
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        font.weight: 900
                        font.pixelSize: 25
                        anchors.centerIn: parent

                        Behavior on color {
                            ColorAnimation {
                                duration: 240
                            }
                        }
                    }

                    MouseArea {
                        id: menuLogoMouseArea
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onClicked: mouse => {
                            if (mouse.button === Qt.LeftButton) {
                                Quickshell.execDetached(["sh", "-c", "$HOME/.config/niri/scripts/menus/main.sh"]);
                            } else if (mouse.button === Qt.RightButton) {
                                Quickshell.execDetached(["sh", "-c", "$HOME/.config/quickshell/wbar-niri/scripts/wallpaper.sh --randomize"]);
                            }
                        }
                    }
                }

                Flow {
                    id: mainBarLeftSideWidgets
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 54
                    spacing: 4

                    Rectangle {
                        id: workspaceWidgetContainer
                        color: "#ffffff"
                        width: workspaceWidget.implicitWidth + 10
                        height: 33

                        Workspace {
                            id: workspaceWidget
                            workspaceSpacing: 6
                            workspaceBoxWidthBefore: 14
                            workspaceBoxWidthAfter: 50
                            workspaceBoxHeight: 14
                        }
                    }
                }

                Flow {
                    id: mainBarRightSideWidgets
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 54
                    spacing: 4

                    Rectangle {
                        id: musicWidgetContainer
                        color: "#ffffff"
                        height: 33
                        width: musicWidget.implicitWidth + 22
                        clip: true

                        Behavior on width {
                            NumberAnimation {
                                duration: 350
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }

                    Rectangle {
                        id: networkWidgetContainer
                        color: "#ffffff"
                        height: 33
                        width: networkWidget.implicitWidth + 20
                        visible: networkWidget.implicitWidth !== 0 ? true : false
                        clip: true

                        Behavior on width {
                            NumberAnimation {
                                duration: 350
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Network {
                            id: networkWidget
                            showSpeed: networkWidgetMouseArea.containsMouse ? true : false
                        }

                        MouseArea {
                            id: networkWidgetMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                        }
                    }

                    Rectangle {
                        id: volumeWidgetContainer
                        color: "#656565"
                        height: 33
                        width: volumeWidget.implicitWidth + 20
                        border.color: "#ffffff"
                        border.width: 2

                        Rectangle {
                            id: volumeWidgetSliderContainer
                            color: "#656565"
                            anchors.fill: parent
                            clip: true
                            border.color: "#ffffff"
                            border.width: 2

                            Rectangle {
                                id: volumeWidgetSlider
                                width: PW.isMuted ? 0 : parent.width * (PW.pwVolume / 100)
                                height: parent.height
                                color: "#ffffff"
                                border.color: "#ffffff"
                                border.width: 2

                                Behavior on width {
                                    NumberAnimation {
                                        duration: 420
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                            }
                        }

                        Pipewire {
                            id: volumeWidget
                            widgetTextColor: volumeWidgetMouseArea.containsMouse ? "#959595" : "#000000"

                            Behavior on widgetTextColor {
                                ColorAnimation {
                                    duration: 240
                                }
                            }
                        }

                        MouseArea {
                            id: volumeWidgetMouseArea
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                            onClicked: Quickshell.execDetached(["/home/wetar/.config/quickshell/wbar-niri/scripts/volume.sh", "--toggle"])

                            onWheel: mouse => {
                                if (mouse.angleDelta.y > 0) {
                                    Quickshell.execDetached(["sh", "-c", "$HOME/.config/quickshell/wbar-niri/scripts/volume.sh --inc"]);
                                } else if (mouse.angleDelta.y < 0) {
                                    Quickshell.execDetached(["sh", "-c", "$HOME/.config/quickshell/wbar-niri/scripts/volume.sh --dec"]);
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: brightnessWidgetContainer
                        color: "#656565"
                        height: 33
                        width: brightnessWidget.implicitWidth + 20
                        border.color: "#ffffff"
                        border.width: 2

                        Rectangle {
                            id: brightnessWidgetSliderContainer
                            color: "#656565"
                            anchors.fill: parent
                            clip: true
                            border.color: "#ffffff"
                            border.width: 2

                            Rectangle {
                                id: brightnessWidgetSlider
                                width: parent.width * (BR.brBrightness / 100)
                                height: parent.height
                                color: "#ffffff"
                                border.color: "#ffffff"
                                border.width: 2

                                Behavior on width {
                                    NumberAnimation {
                                        duration: 230
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                            }
                        }

                        Brightness {
                            id: brightnessWidget
                            widgetTextColor: brightnessWidgetMouseArea.containsMouse ? "#959595" : "#000000"

                            Behavior on widgetTextColor {
                                ColorAnimation {
                                    duration: 240
                                }
                            }
                        }

                        MouseArea {
                            id: brightnessWidgetMouseArea
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                            onClicked: Quickshell.execDetached(["sh", "-c", "$HOME/.config/quickshell/wbar-niri/scripts/brightness.sh --cycle"])

                            onWheel: mouse => {
                                if (mouse.angleDelta.y > 0) {
                                    Quickshell.execDetached(["sh", "-c", "$HOME/.config/quickshell/wbar-niri/scripts/brightness.sh --inc"]);
                                } else if (mouse.angleDelta.y < 0) {
                                    Quickshell.execDetached(["sh", "-c", "$HOME/.config/quickshell/wbar-niri/scripts/brightness.sh --dec"]);
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: batteryWidgetContainer
                        color: "#656565"
                        height: 33
                        width: batteryWidget.implicitWidth + 20
                        border.color: "#ffffff"
                        border.width: 2

                        Rectangle {
                            id: batteryWidgetSliderContainer
                            color: "#656565"
                            anchors.fill: parent
                            clip: true
                            border.color: "#ffffff"
                            border.width: 2

                            Rectangle {
                                id: batteryWidgetFiller
                                width: parent.width * (BP.bpCapacity / 100)
                                height: parent.height
                                color: "#ffffff"
                                visible: BP.isCharging !== true || BP.bpCapacity === 100
                                border.color: "#ffffff"
                                border.width: 2

                                Behavior on width {
                                    NumberAnimation {
                                        duration: 230
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                            }

                            Rectangle {
                                id: batteryWidgetSliderAnimation
                                width: parent.width
                                height: parent.height
                                color: "#ffffff"

                                SequentialAnimation on x {
                                    id: chargingAnimation
                                    running: BP.isCharging && !BP.bpCapacity <= 0 && BP.bpCapacity <= 99
                                    loops: Animation.Infinite

                                    NumberAnimation {
                                        from: -batteryWidgetSliderContainer.width
                                        to: 0
                                        duration: 1500
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                            }
                        }

                        Battery {
                            id: batteryWidget
                            widgetTextColor: "#000000"
                        }
                    }

                    Rectangle {
                        id: cadWidgets
                        color: "#ffffff"
                        height: 33
                        width: cadWidgetsMouseArea.containsMouse ? cadWidgetsContainer.implicitWidth + 160 : cadWidgetsContainer.implicitWidth + 110
                        clip: true

                        Behavior on width {
                            NumberAnimation {
                                duration: 350
                                easing.type: Easing.InOutQuad
                            }
                        }

                        MouseArea {
                            id: cadWidgetsMouseArea
                            hoverEnabled: true
                            anchors.fill: parent
                        }

                        Item {
                            id: cadWidgetsContainer
                            width: parent.width
                            height: parent.height
                            anchors.centerIn: parent
                            anchors.rightMargin: 6

                            Text {
                                id: cadWidgetsIcon
                                text: "󰃰 "
                                font.family: "JetBrainsMono Nerd Font Propo"
                                color: "#000000"
                                renderType: Text.NativeRendering
                                font.hintingPreference: Font.PreferFullHinting
                                font.pixelSize: 26
                                font.weight: 900
                                anchors.centerIn: parent
                                anchors.horizontalCenterOffset: cadWidgetsMouseArea.containsMouse ? -52 : -80
                                visible: cadWidgetsMouseArea.containsMouse ? true : false
                                opacity: cadWidgetsMouseArea.containsMouse ? 1 : 0

                                Behavior on visible {
                                    NumberAnimation {
                                        duration: 350
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                Behavior on opacity {
                                    NumberAnimation {
                                        duration: 350
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                Behavior on anchors.horizontalCenterOffset {
                                    NumberAnimation {
                                        duration: 350
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                            }

                            Clock {
                                id: clockWidget
                                timeSec: cadWidgetsMouseArea.containsMouse ? true : false
                            }

                            Date {
                                id: dateWidget
                                dateWidgetShow: cadWidgetsMouseArea.containsMouse ? true : false
                            }
                        }
                    }
                }

                Power {
                    id: powerWidget
                    powerWidgetHeight: 200
                    powerWidgetWidth: 50
                    iconSize: 24
                }

                Rectangle {
                    id: powerLogo
                    width: 50
                    height: mainBar.implicitHeight
                    color: "#ffffff"
                    anchors.right: parent.right

                    Text {
                        id: powerLogoText
                        text: ""
                        color: powerLogoMouseArea.containsMouse ? "#959595" : "#000000"
                        font.pixelSize: 22
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        font.family: "JetBrainsMono Nerd Font Propo"
                        font.weight: 900
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: 1

                        Behavior on color {
                            ColorAnimation {
                                duration: 240
                            }
                        }
                    }

                    MouseArea {
                        id: powerLogoMouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                        onClicked: powerWidget.showWidget()
                    }
                }
            }
        }
    }
}
