pragma ComponentBehavior: Bound

import Quickshell

ShellRoot {
    id: root
    property bool lockActive: false

    Variants {
        model: Quickshell.screens
        delegate: Bar {
            required property var modelData

            screen: modelData
        }
    }
}
