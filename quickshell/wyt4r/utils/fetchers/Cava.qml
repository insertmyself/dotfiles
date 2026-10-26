pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property var bars: []
    property int barCount: 8

    Process {
        id: cavaProc
        command: ["cava", "-p", Quickshell.env("HOME") + "/.config/cava/quickshell.conf"]
        running: true

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: line => {
                if (!line) {
                    return;
                }

                const values = line.trim().split(";").filter(data => data.length > 0).map(Number);

                if (values.length > 0) {
                    root.bars = values;
                }
            }
        }
    }
}
