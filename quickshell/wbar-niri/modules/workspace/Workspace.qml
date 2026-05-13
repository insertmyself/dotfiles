import Quickshell
import Niri
import QtQuick

Item {
    id: workspaceWidgetRoot

    required property int workspaceSpacing
    required property int workspaceBoxWidthBefore
    required property int workspaceBoxWidthAfter
    required property int workspaceBoxHeight

    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    implicitWidth: workspaceRow.implicitWidth + 10
    height: workspaceRow.height

    Niri {
        id: niriIntegration
        Component.onCompleted: connect()

        onConnected: console.log("Connected to niri")
        onErrorOccurred: function (error) {
            console.log("Failed to connect", error);
        }
    }

    Component.onCompleted: niriIntegration.workspaces.maxCount = 4

    Rectangle {
        id: workspaceWidget
        color: "transparent"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        implicitWidth: workspaceRow.implicitWidth + 10
        height: workspaceRow.height

        Row {
            id: workspaceRow
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: workspaceWidgetRoot.workspaceSpacing

            Repeater {
                id: workspaceRepeater
                model: niriIntegration.workspaces

                delegate: Rectangle {
                    id: workspaceContainer
                    implicitWidth: model.isActive ? workspaceWidgetRoot.workspaceBoxWidthAfter : workspaceWidgetRoot.workspaceBoxWidthBefore
                    implicitHeight: workspaceWidgetRoot.workspaceBoxHeight
                    radius: 0
                    color: workspaceMouseArea.containsMouse ? "#959595" : "#000000"
                    border.width: 0

                    Behavior on color {
                        ColorAnimation {
                            duration: 230
                        }
                    }

                    Behavior on implicitWidth {
                        NumberAnimation {
                            duration: 240
                            easing.type: Easing.InOutQuad
                        }
                    }

                    MouseArea {
                        id: workspaceMouseArea
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: niriIntegration.focusWorkspaceById(model.id)
                    }
                }
            }

            Text {
                visible: niriIntegration.workspaces.length === 0
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                text: "No workspaces"
                color: "#ffffff"
                font.pixelSize: 14
                font.family: "JetBrainsMono Nerd Font Propo"
                font.weight: 900
            }
        }
    }
}
