pragma ComponentBehavior: Bound

import QtQuick

Item {
    id: dateWidgetRoot

    property bool dateWidgetShow

    implicitWidth: dateWidgetText.paintedWidth
    height: dateWidgetText.height
    anchors.centerIn: parent

    Text {
        id: dateWidgetText
        text: CAD.date
        font.family: "JetBrainsMono Nerd Font Propo"
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        font.pixelSize: 12
        font.weight: 900
        color: "#000000"
        visible: dateWidgetRoot.dateWidgetShow ? true : false
        opacity: dateWidgetRoot.dateWidgetShow ? 1 : 0
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: dateWidgetRoot.dateWidgetShow ? 8 : 80
        anchors.horizontalCenterOffset: 16

        Behavior on opacity {
            NumberAnimation {
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on visible {
            NumberAnimation {
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on anchors.verticalCenterOffset {
            NumberAnimation {
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }
    }
}
