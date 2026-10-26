pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root
    property PwNode sink: Pipewire.defaultAudioSink
    property real level: sink?.audio?.volume ?? 0
    property bool muted: sink?.audio?.muted ?? false

    function toggleMute() {
        if (root?.sink?.audio) {
            root.sink.audio.muted = !root.sink.audio.muted;
        }
    }

    function changeVolume(delta) {
        if (root?.sink?.audio) {
            root.sink.audio.muted = false;
            root.sink.audio.volume = Math.max(0, Math.min(1, root.sink.audio.volume + delta));
        }
    }

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }
}
