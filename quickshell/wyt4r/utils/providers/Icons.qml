pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    function getBatteryIcon(batteryRef) {
        if (!batteryRef.battery.ready) {
            return "";
        }

        let battery = Math.round(batteryRef.battery.percentage * 100);

        if (batteryRef.isCharging) {
            return "󰂄";
        } else if (battery > 80) {
            return "󰁹";
        } else if (battery > 60) {
            return "󰂁";
        } else if (battery > 40) {
            return "󰁾";
        } else if (battery > 20) {
            return "󰁼";
        } else {
            return "󰂎";
        }
    }

    function getVolumeIcon(volumeRef) {
        let volume = Math.round(volumeRef.level * 100);

        if (volume > 80) {
            return "";
        } else if (volume > 40) {
            return "";
        } else {
            return "";
        }
    }

    function getBrightnessIcon(brightnessRef) {
        let brightness = brightnessRef.level;

        if (brightness > 80) {
            return "󰃠";
        } else if (brightness > 60) {
            return "󰃟";
        } else if (brightness > 40) {
            return "󰃞";
        } else if (brightness > 20) {
            return "󰃜";
        } else {
            return "󰃚";
        }
    }
}
