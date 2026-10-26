pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: root
    property var battery: UPower.displayDevice
    property var isCharging: !UPower.onBattery
}
