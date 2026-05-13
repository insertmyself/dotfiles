import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: notificationWidgetRoot

    property string notificationSummary: ""
    property string notificationBody: ""
    property var notificationActions: []
    property var notificationCurrent: null
    property bool isShowing: false
    property int notificationContentHeight: 48

    implicitWidth: notificationWidgetBodyText.width + 120
    implicitHeight: isShowing ? notificationWidgetRoot.notificationContentHeight : 0
    anchors.right: true
    anchors.bottom: true
    margins.bottom: 26
    margins.right: 25
    visible: isShowing
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore

    function showNotification(notificationData) {
        if (!notificationData) {
            return;
        }

        notificationCurrent = notificationData;
        notificationSummary = notificationData.summary || "";
        notificationBody = notificationData.body || "";
        notificationActions = notificationData.actions || [];

        if (notificationBody !== "") {
            notificationContentHeight = 71;
        } else {
            notificationContentHeight = 51;
        }

        isShowing = true;
        notificationWidgetWindow.scale = 1.0;
        notificationTimer.restart();
    }

    function hideNotification() {
        notificationWidgetWindow.scale = 0.0;
        notificationDelayTimer.restart();
    }

    Timer {
        id: notificationTimer
        interval: 3000
        repeat: false
        onTriggered: notificationWidgetRoot.hideNotification()
    }

    Timer {
        id: notificationDelayTimer
        interval: 500
        repeat: false
        onTriggered: {
            notificationWidgetRoot.isShowing = false;

            if (notificationWidgetRoot.notificationCurrent) {
                notificationWidgetRoot.notificationCurrent.close();
                notificationWidgetRoot.notificationCurrent = null;
            }

            notificationWidgetRoot.notificationSummary = "";
            notificationWidgetRoot.notificationBody = "";
            notificationWidgetRoot.notificationActions = [];
            notificationWidgetRoot.notificationIconImage = "";
        }
    }

    Rectangle {
        id: notificationWidgetWindow
        color: notificationWidgetWindowMouseArea.containsMouse ? "#101010" : "#000000"
        height: notificationWidgetRoot.notificationContentHeight
        width: notificationWidgetRoot.implicitWidth
        border.width: 2
        border.color: "#ffffff"
        scale: 0.0
        transformOrigin: Item.BottomRight

        Behavior on color {
            ColorAnimation {
                duration: 180
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 600
                easing.type: Easing.InOutExpo
            }
        }

        MouseArea {
            id: notificationWidgetWindowMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onEntered: notificationTimer.stop()

            onExited: notificationTimer.restart()

            onClicked: {
                notificationTimer.stop();
                notificationWidgetRoot.hideNotification();
            }
        }

        Item {
            id: notificationWidgetWindowValue
            anchors.fill: parent
            anchors.margins: 11
            anchors.left: parent.left

            Column {
                id: notificationWidgetWindowColumn
                anchors.fill: parent
                anchors.margins: 2
                spacing: 2

                Text {
                    id: notificationWidgetSummaryText
                    text: notificationWidgetRoot.notificationSummary
                    font.family: "JetBrainsMono Nerd Font Propo"
                    font.pixelSize: 16
                    color: "#ffffff"
                    font.weight: 900
                    maximumLineCount: 2
                    wrapMode: Text.Wrap
                    elide: Text.ElideRight
                    renderType: Text.NativeRendering
                    font.hintingPreference: Font.PreferFullHinting
                }

                Text {
                    id: notificationWidgetBodyText
                    text: notificationWidgetRoot.notificationBody
                    font.family: "JetBrainsMono Nerd Font Propo"
                    font.pixelSize: 14
                    font.underline: true
                    color: "#ffffff"
                    font.weight: 900
                    maximumLineCount: 3
                    wrapMode: Text.Wrap
                    elide: Text.ElideRight
                    renderType: Text.NativeRendering
                    font.hintingPreference: Font.PreferFullHinting
                    visible: text !== ""
                }
            }
        }
    }

    NotificationServer {
        id: notificationServer
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyMarkupSupported: true
        bodySupported: true
        keepOnReload: false
        persistenceSupported: true

        onNotification: notificationStart => notificationWidgetRoot.showNotification(notificationStart)
    }
}
