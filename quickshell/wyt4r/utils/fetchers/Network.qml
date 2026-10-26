pragma Singleton

import Quickshell
import Quickshell.Networking
import QtQuick

Singleton {
    id: root
    readonly property var activeDevice: Networking.devices.values.find(device => device.connected)
    readonly property string icon: {
        if (Networking.backend !== NetworkBackendType.NetworkManager) {
            return "󰤭";
        }

        if (!activeDevice) {
            return "󰤯";
        }

        return activeDevice.type === DeviceType.Wifi ? "󰤨" : "󰈀";
    }
}
