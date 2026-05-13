import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: root

    property var currentNotification: null
    property bool isShowing: false

    property string summary: ""
    property string body: ""
    property var actions: []

    readonly property int contentHeight: body !== "" ? 71 : 51

    implicitWidth: bodyText.implicitWidth + 120
    implicitHeight: isShowing ? contentHeight : 0

    anchors.right: true
    anchors.bottom: true
    margins.bottom: 26
    margins.right: 25

    visible: isShowing
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore

    function showNotification(data) {
        if (!data)
            return;

        currentNotification = data;
        summary = data.summary ?? "";
        body = data.body ?? "";
        actions = data.actions ?? [];

        isShowing = true;
        popup.scale = 1.0;
        dismissTimer.restart();
    }

    function hideNotification() {
        popup.scale = 0.0;
        cleanupTimer.restart();
    }

    function clearState() {
        if (currentNotification) {
            currentNotification.close();
            currentNotification = null;
        }
        summary = "";
        body = "";
        actions = [];
        isShowing = false;
    }

    Timer {
        id: dismissTimer
        interval: 3000
        repeat: false
        onTriggered: root.hideNotification()
    }

    Timer {
        id: cleanupTimer
        interval: 500
        repeat: false
        onTriggered: root.clearState()
    }

    Rectangle {
        id: popup

        width: root.implicitWidth
        height: root.contentHeight
        color: hoverArea.containsMouse ? "#101010" : "#000000"
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
            id: hoverArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: dismissTimer.stop()
            onExited: dismissTimer.restart()
            onClicked: {
                dismissTimer.stop();
                root.hideNotification();
            }
        }

        Column {
            anchors {
                fill: parent
                margins: 13
            }
            spacing: 2

            Text {
                id: summaryText
                text: root.summary
                font.family: "JetBrainsMono Nerd Font Propo"
                font.pixelSize: 16
                font.weight: 900
                color: "#ffffff"
                maximumLineCount: 2
                wrapMode: Text.Wrap
                elide: Text.ElideRight
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
            }

            Text {
                id: bodyText
                text: root.body
                visible: text !== ""
                font.family: "JetBrainsMono Nerd Font Propo"
                font.pixelSize: 14
                font.weight: 900
                font.underline: true
                color: "#ffffff"
                maximumLineCount: 3
                wrapMode: Text.Wrap
                elide: Text.ElideRight
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
            }
        }
    }

    NotificationServer {
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyMarkupSupported: true
        bodySupported: true
        keepOnReload: false
        persistenceSupported: true
        onNotification: data => root.showNotification(data)
    }
}
