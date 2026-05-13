pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: brRoot

    property real brCapacity: brBrightnessFilePath.text()
    property real brMaxBrightness
    property int brBrightness: Math.round((brCapacity / brMaxBrightness) * 100)
    property string brPercentage: {
        if (brRoot.brBrightness <= 0) {
            return "󰳲 Null";
        } else if (brRoot.brBrightness > 80) {
            return "󰃠 " + brRoot.brBrightness + "%";
        } else if (brRoot.brBrightness > 75) {
            return "󰃟 " + brRoot.brBrightness + "%";
        } else if (brRoot.brBrightness > 60) {
            return "󰃞 " + brRoot.brBrightness + "%";
        } else if (brRoot.brBrightness > 50) {
            return "󰃝 " + brRoot.brBrightness + "%";
        } else if (brRoot.brBrightness > 30) {
            return "󰃜 " + brRoot.brBrightness + "%";
        } else if (brRoot.brBrightness > 15) {
            return "󰃛 " + brRoot.brBrightness + "%";
        } else {
            return "󰃚 " + brRoot.brBrightness + "%";
        }
    }

    Process {
        id: brMaxBrightnessProc
        command: ["sh", "-c", "cat /sys/class/backlight/*/max_brightness"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                brRoot.brMaxBrightness = this.text.trim().split("\n")[0];
            }
        }
    }

    Process {
        id: brBrightnessPathProc
        command: ["sh", "-c", "ls -1 /sys/class/backlight/*/brightness"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                brBrightnessFilePath.path = this.text.trim().split("\n")[0];
            }
        }
    }

    FileView {
        id: brBrightnessFilePath
        watchChanges: true
        onFileChanged: reload()
    }
}
