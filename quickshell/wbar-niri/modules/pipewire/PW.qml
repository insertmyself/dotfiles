pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: pwRoot

    property PwNode defaultSink: Pipewire.defaultAudioSink
    property real pwVolume: (defaultSink && defaultSink.audio) ? Math.round(defaultSink.audio.volume * 100) : 0
    property bool isMuted: (defaultSink && defaultSink.audio) ? defaultSink.audio.muted : false
    property string pwPercentage: {
        if (!defaultSink || !defaultSink.audio) {
            return " Null";
        } else if (pwRoot.isMuted === true) {
            return " Muted";
        } else if (pwRoot.pwVolume <= 0) {
            return " Null";
        } else if (pwRoot.pwVolume > 50) {
            return " " + pwRoot.pwVolume + "%";
        } else {
            return " " + pwRoot.pwVolume + "%";
        }
    }

    PwObjectTracker {
        id: pwSinkTracker
        objects: [pwRoot.defaultSink]
    }
}
