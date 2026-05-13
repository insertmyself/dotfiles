pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: ntRoot

    property string ntNetworkName: ""
    property string ntCurrentInterface: ""
    property double ntRxBytes: 0.0
    property double ntTxBytes: 0.0
    property string ntRxFormattedBytes: formatNtSpeed(ntRxBytes)
    property string ntTxFormattedBytes: formatNtSpeed(ntTxBytes)
    property string ntConSpeed: {
        if (ntNetworkName === "󰤮 Null") {
            return " Null  Null";
        } else {
            return " " + ntRxFormattedBytes + " " + " " + ntTxFormattedBytes;
        }
    }

    function formatNtSpeed(ntBytes) {
        if (ntBytes === undefined || ntBytes === null || isNaN(ntBytes)) {
            return " Null";
        } else if (ntBytes >= 1024 * 1024) {
            return (ntBytes / (1024 * 1024)).toFixed(2) + " MB/s";
        } else if (ntBytes >= 1024) {
            return (ntBytes / 1024).toFixed(1) + " KB/s";
        } else {
            return ntBytes + " B/s";
        }
    }

    Process {
        id: ntBytesProc
        command: ["sh", "-c", "cat /proc/net/dev"]
        stdout: StdioCollector {
            onStreamFinished: {
                let ntDatas = text.split("\n");
                let ntInterface = `${ntRoot.ntCurrentInterface}:`;
                let ntData = ntDatas.find(data => data.includes(ntInterface));

                if (!ntData) {
                    ntRoot.ntRxBytes = null;
                    ntRoot.ntTxBytes = null;
                    return;
                }

                ntData = ntData.replace(/:/, " ").trim();
                let ntDataExtracted = ntData.split(/\s+/);

                let ntRx = Number(ntDataExtracted[1]);
                let ntTx = Number(ntDataExtracted[9]);

                ntRoot.ntRxBytes = isNaN(ntRx) ? null : ntRx;
                ntRoot.ntTxBytes = isNaN(ntTx) ? null : ntTx;
            }
        }
    }

    Process {
        id: ntCurrentInterfaceProc
        command: ["sh", "-c", "nmcli -t -f DEVICE,STATE device | grep ':connected$' | cut -d: -f1"]
        stdout: StdioCollector {
            onStreamFinished: {
                ntRoot.ntCurrentInterface = this.text.trim();
            }
        }
    }

    Process {
        id: ntNetworkNameProc
        command: ["sh", "-c", "nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes:' | cut -d: -f2 | head -n 1"]
        stdout: StdioCollector {
            onStreamFinished: {
                if (this.text.trim() === "") {
                    return ntRoot.ntNetworkName = "󰤮 Null";
                } else {
                    return ntRoot.ntNetworkName = "󰤨 " + this.text.trim();
                }
            }
        }
    }

    Timer {
        id: ntProcsTimer
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            ntNetworkNameProc.running = true;
            ntCurrentInterfaceProc.running = true;
            ntBytesProc.running = true;
        }
    }
}
