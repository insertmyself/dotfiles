import Quickshell
import QtQuick

Item {
    id: volumeWidgetRoot

    required property color widgetTextColor

    implicitWidth: volumeWidgetText.paintedWidth
    height: volumeWidgetText.height
    anchors.centerIn: parent

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 230
            easing.type: Easing.InOutQuad
        }
    }

    Text {
        id: volumeWidgetText
        text: PW.pwPercentage
        color: volumeWidgetRoot.widgetTextColor
        font.family: "JetBrainsMono Nerd Font Propo"
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        font.weight: 900
        font.pixelSize: 15
    }
}
