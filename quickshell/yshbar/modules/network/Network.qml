import QtQuick

Item {
    id: networkWidgetRoot

    required property bool showSpeed

    implicitWidth: showSpeed ? networkSpeedText.paintedWidth : networkWidgetText.paintedWidth
    height: networkWidgetText.height
    anchors.centerIn: parent

    Text {
        id: networkWidgetText
        font.family: "JetBrainsMono Nerd Font Propo"
        text: NT.ntNetworkName
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        font.pixelSize: 15
        font.weight: 900
        color: "#000000"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: networkWidgetRoot.showSpeed ? -80 : 0
        visible: networkWidgetRoot.showSpeed ? false : true
        opacity: networkWidgetRoot.showSpeed ? 0 : 1

        Behavior on visible {
            NumberAnimation {
                duration: 430
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 430
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on anchors.verticalCenterOffset {
            NumberAnimation {
                duration: 430
                easing.type: Easing.InOutQuad
            }
        }
    }

    Text {
        id: networkSpeedText
        font.family: "JetBrainsMono Nerd Font Propo"
        text: NT.ntConSpeed
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        font.pixelSize: 15
        font.weight: 900
        color: "#000000"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: networkWidgetRoot.showSpeed ? 0 : 80
        anchors.horizontalCenterOffset: 1
        visible: networkWidgetRoot.showSpeed ? true : false
        opacity: networkWidgetRoot.showSpeed ? 1 : 0

        Behavior on visible {
            NumberAnimation {
                duration: 360
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 360
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on anchors.verticalCenterOffset {
            NumberAnimation {
                duration: 360
                easing.type: Easing.InOutQuad
            }
        }
    }
}
