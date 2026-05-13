pragma ComponentBehavior: Bound

import QtQuick

Item {
    id: clockWidgetRoot

    property bool timeSec

    implicitWidth: clockWidgetText.paintedWidth
    implicitHeight: clockWidgetText.height
    anchors.centerIn: parent

    Text {
        id: clockWidgetText
        font.family: "JetBrainsMono Nerd Font Propo"
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        font.pixelSize: 15
        font.weight: 900
        color: "#000000"
        text: CAD.time
        visible: clockWidgetRoot.timeSec ? false : true
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: clockWidgetRoot.timeSec ? 80 : 1

        Behavior on visible {
            NumberAnimation {
                duration: 320
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 320
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on font.pixelSize {
            NumberAnimation {
                duration: 320
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on anchors.horizontalCenterOffset {
            NumberAnimation {
                duration: 320
                easing.type: Easing.InOutQuad
            }
        }
    }

    Text {
        font.family: "JetBrainsMono Nerd Font Propo"
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        font.pixelSize: 12
        font.weight: 900
        color: "#000000"
        text: CAD.timeSec
        visible: clockWidgetRoot.timeSec ? true : false
        opacity: clockWidgetRoot.timeSec ? 1 : 0
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 33
        anchors.verticalCenterOffset: clockWidgetRoot.timeSec ? -7 : -80

        Behavior on visible {
            NumberAnimation {
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on font.pixelSize {
            NumberAnimation {
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on anchors.verticalCenterOffset {
            NumberAnimation {
                duration: 280
                easing.type: Easing.InOutQuad
            }
        }
    }
}
