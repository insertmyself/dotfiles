import Quickshell
import QtQuick

Item {
    id: batteryWidgetRoot

    required property color widgetTextColor

    implicitWidth: batteryWidgetText.paintedWidth
    implicitHeight: batteryWidgetText.height
    anchors.centerIn: parent

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 230
            easing.type: Easing.InOutQuad
        }
    }

    Text {
        id: batteryWidgetText
        text: BP.bpPercentage
        color: batteryWidgetRoot.widgetTextColor
        font.family: "JetBrainsMono Nerd Font Propo"
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        font.weight: 900
        font.pixelSize: 15
    }
}
