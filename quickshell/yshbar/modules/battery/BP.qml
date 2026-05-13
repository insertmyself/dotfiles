pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: bpRoot

    property real bpCapacity: Math.round(UPower.displayDevice.percentage * 100)
    property bool isCharging: {
        if (UPower.displayDevice.isLaptopBattery === true) {
            UPower.onBattery ? false : true;
        } else {
            return "No battery";
        }
    }
    property string bpPercentage: {
        if (bpRoot.bpCapacity <= 0) {
            return "󰂑 Null";
        } else if (bpRoot.isCharging === true) {
            return "󰂄 " + BP.bpCapacity + "%";
        } else if (bpRoot.isCharging === "No battery") {
            return "󱉝 Null";
        } else {
            return "󰁹 " + BP.bpCapacity + "%";
        }
    }
}
