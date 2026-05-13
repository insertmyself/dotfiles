import Quickshell
import QtQuick

Item {
    id: brightnessWidgetRoot

    required property color widgetTextColor

    implicitWidth: brightnessWidgetText.paintedWidth
    implicitHeight: brightnessWidgetText.height
    anchors.centerIn: parent

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 230
            easing.type: Easing.InOutQuad
        }
    }

    Text {
        id: brightnessWidgetText
        text: BR.brPercentage
        color: brightnessWidgetRoot.widgetTextColor
        font.family: "JetBrainsMono Nerd Font Propo"
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        font.weight: 900
        font.pixelSize: 15
    }
}
