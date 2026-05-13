pragma Singleton

import Quickshell

Singleton {
    id: cadRoot

    property string time: "󰥔 " + Qt.formatTime(clockProc.date, "hh:mm AP")
    property string timeSec: Qt.formatTime(clockProc.date, "hh:mm:ss AP")
    property string date: Qt.formatDate(clockProc.date, "ddd, dd MMM yyyy")

    SystemClock {
        id: clockProc
        precision: SystemClock.Seconds
    }
}
