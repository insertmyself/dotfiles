pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "../components"

Item {
    id: workspacesWidget
    property real shadowSize
    property color barColor
    property var workspacesRef

    width: workspacesContent.implicitWidth + 16 + shadowSize
    height: workspacesContent.implicitHeight + 8 + shadowSize

    BarShadow {
        id: workspacesShadow
        shadowOffsetX: 4
        shadowOffsetY: 4
        barColor: workspacesWidget.barColor
        width: workspacesBg.width
        height: workspacesBg.height
    }

    Rectangle {
        id: workspacesBg
        width: parent.width - workspacesWidget.shadowSize
        height: parent.height - workspacesWidget.shadowSize
        color: workspacesWidget.barColor
    }

    RowLayout {
        id: workspacesContent
        anchors.centerIn: workspacesBg
        spacing: 6

        Row {
            spacing: 10

            Text {
                text: "["
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 16
                font.weight: 900
            }

            Row {
                spacing: 8
                anchors.verticalCenter: parent.verticalCenter

                Repeater {
                    model: workspacesWidget.workspacesRef.names
                    delegate: Rectangle {
                        id: model
                        required property int index
                        required property string modelData

                        width: index === workspacesWidget.workspacesRef.current ? 32 : 11
                        height: 11
                        color: index === workspacesWidget.workspacesRef.current ? "#ffffff" : "#000000"
                        border.color: "#000000"
                        border.width: index === workspacesWidget.workspacesRef.current ? 1 : 0

                        Behavior on width {
                            NumberAnimation {
                                duration: 150
                                easing: Easing.OutQuad
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: workspacesWidget.workspacesRef.switchTo(model.index)
                        }
                    }
                }
            }

            Text {
                text: "]"
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 16
                font.weight: 900
            }
        }
    }
}
