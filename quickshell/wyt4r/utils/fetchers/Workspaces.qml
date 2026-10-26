pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property var names: []
    property int current: 0

    function switchTo(index) {
        switchProc.exec(["bash", "-c", "wmctrl -s " + index]);
    }

    Process {
        id: initProc
        command: ["bash", "-c", "wmctrl -d"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                let parts = data.trim().split(/\s+/);

                if (parts[1] === "*") {
                    root.current = parseInt(parts[0]);
                }

                let name = parts.slice(9).join(" ") || String(parseInt(parts[0]) + 1).toString();
                let list = root.names.slice();

                list[parseInt(parts[0])] = name;
                root.names = list;
            }
        }
    }

    Process {
        id: watchProc
        command: ["xprop", "-spy", "-root", "_NET_CURRENT_DESKTOP"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                let match = data.match(/= (\d+)/);

                if (match) {
                    root.current = parseInt(match[1]);
                }
            }
        }
    }

    Process {
        id: switchProc
    }
}
