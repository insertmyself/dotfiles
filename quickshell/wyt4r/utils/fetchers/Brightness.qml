pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property int level: 0

    function refresh() {
        get.running = true;
    }

    Process {
        id: get
        command: ["bash", "-c", "brightnessctl -m | cut -d, -f4 | tr -d '%'"]
        stdout: SplitParser {
            onRead: data => root.level = parseInt(data.trim())
        }
    }

    Process {
        id: watch
        command: ["udevadm", "monitor", "--udev", "--subsystem-match=backlight"]
        running: true
        stdout: SplitParser {
            onRead: data => root.refresh()
        }
    }

    Component.onCompleted: refresh()
}
