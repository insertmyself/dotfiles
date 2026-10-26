pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

PanelWindow {
    id: bar
    property real shadowSize: 6
    property color barColor: "#ffffff"

    aboveWindows: false
    anchors.top: true
    margins.top: 14
    implicitHeight: 32 + shadowSize
    implicitWidth: 1350 + shadowSize
    color: "transparent"
    mask: Region {
        Region {
            item: clockWidget
        }

        Region {
            item: workspacesWidget
        }

        Region {
            item: cavaWidget
        }

        Region {
            item: systemWidget
        }

        Region {
            item: powerWidget
        }
    }

    SystemClock {
        id: clockSource
        precision: SystemClock.Minutes
    }

    ClockWidget {
        id: clockWidget
        barColor: bar.barColor
        shadowSize: bar.shadowSize
        clockRef: clockSource

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
    }

    WorkspacesWidget {
        id: workspacesWidget
        barColor: bar.barColor
        shadowSize: bar.shadowSize
        workspacesRef: Workspaces

        anchors.left: clockWidget.right
        anchors.verticalCenter: clockWidget.verticalCenter
        anchors.leftMargin: 6
    }

    CavaWidget {
        id: cavaWidget
        barColor: bar.barColor
        shadowSize: bar.shadowSize
        cavaRef: Cava

        anchors.right: systemWidget.left
        anchors.verticalCenter: workspacesWidget.verticalCenter
        anchors.rightMargin: 6
    }

    SystemWidget {
        id: systemWidget
        barColor: bar.barColor
        shadowSize: bar.shadowSize
        volumeRef: Volume
        batteryRef: Power
        brightnessRef: Brightness
        networkRef: Network

        anchors.right: powerWidget.left
        anchors.verticalCenter: powerWidget.verticalCenter
        anchors.rightMargin: 6
    }

    PowerWidget {
        id: powerWidget
        barColor: bar.barColor
        shadowSize: bar.shadowSize

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10
    }
}
