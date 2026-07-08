import QtQuick
import Quickshell
import Quickshell.Io
import "."

Scope {
    EssentialsWidget {}
    ProfileWidget {}
    PlayerWidget {}
    VisualizerWidget {}
    AppLauncher {}
    ControllerWidget {}

    Process {
        command: ["sh", "-c", "udevadm monitor --subsystem-match=backlight --udev"]
        running: true
        stdout: SplitParser {
            onRead: updateBrightness.running = true
        }
    }

    Process {
        id: updateBrightness
        command: ["sh", "-c", "brightnessctl -m"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                Shared.brightness = this.text.split(",")[3].replace("%", "");
            }
        }
    }

    Process {
        id: usernameProc
        command: ["bash", "-c", "whoami"]
        running: true
        stdout: SplitParser {
            onRead: data => Shared.username = data.trim().charAt(0).toUpperCase() + data.trim().slice(1)
        }
    }

    Process {
        id: distroProc
        command: ["bash", "-c", "grep -oP '(?<=^PRETTY_NAME=\").*(?=\")' /etc/os-release"]
        running: true
        stdout: SplitParser {
            onRead: data => Shared.distro = data.trim()
        }
    }

    Process {
        id: windowManagerProc
        command: ["bash", "-c", "echo $XDG_CURRENT_DESKTOP"]
        running: true
        stdout: SplitParser {
            onRead: data => Shared.windowManager = data.trim().charAt(0).toUpperCase() + data.trim().slice(1)
        }
    }

    Process {
        id: cavaProc
        command: ["bash", "-c", 'cava -p "$HOME/.config/cava/quickshell.conf"']
        running: true
        stdout: SplitParser {
            onRead: data => {
                const vals = data.trim().split(";").filter(v => v.length > 0).map(Number);
                while (vals.length < 20)
                    vals.push(0);

                Shared.levels = vals.slice(0, 20).map(v => Math.max((v / 100) * 12, 2));
            }
        }
    }

    Process {
        id: playerProc
        property string result: ""

        command: ["bash", "-c", "playerctl -p spotify metadata --format '{{ title }}|{{ artist }}|{{ mpris:artUrl }}' --follow"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                const parts = data.trim().split("|");

                Shared.titleText = parts[0] || "Nothing";
                Shared.titleIcon = parts[0] ? " " : " ";
                Shared.artistText = parts[1] || "Nothing";
                Shared.artistIcon = parts[1] ? "󰀥 " : " ";
                Shared.artUrl = parts[2] || "";
            }
        }
    }

    Process {
        id: playerStatusProc
        property string result: ""

        command: ["bash", "-c", "playerctl -p spotify status --follow 2>/dev/null"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                const status = data.trim();

                if (status === "Playing") {
                    Shared.isPlaying = true;
                } else if (status === "Paused") {
                    Shared.isPlaying = false;
                } else if (status.length === 0 || status === "Stopped") {
                    Shared.titleText = "Nothing";
                    Shared.titleIcon = " ";
                    Shared.artistText = "Nothing";
                    Shared.artistIcon = " ";
                    Shared.artUrl = "";
                    Shared.isPlaying = false;
                }
            }
        }
    }

    Process {
        id: wifiProc
        property string result: ""

        command: ["bash", "-c", "iwctl station wlan0 show | grep 'Connected network' | tr -s ' ' | cut -d ' ' -f4-; echo DONE"]
        running: false
        stdout: SplitParser {
            onRead: data => {
                const ssid = data.trim();

                if (ssid === "DONE") {
                    if (wifiProc.result.length > 0) {
                        Shared.wifiText = " " + wifiProc.result + " ]";
                        Shared.wifiIcon = "[ ";
                    } else {
                        Shared.wifiText = " Disconnect ]";
                        Shared.wifiIcon = "[ ";
                    }

                    wifiProc.result = "";
                } else if (ssid.length > 0) {
                    wifiProc.result = ssid;
                }
            }
        }
    }

    Process {
        id: appListProc
        command: ["bash", "-c", "for f in /usr/share/applications/*.desktop $HOME/.local/share/applications/*.desktop; do " + "[ -f \"$f\" ] || continue; " + "n=$(grep -m1 '^Name=' \"$f\" | cut -d= -f2-); " + "e=$(grep -m1 '^Exec=' \"$f\" | cut -d= -f2- | sed 's/%[a-zA-Z]//g'); " + "i=$(grep -m1 '^Icon=' \"$f\" | cut -d= -f2-); " + "[ -n \"$n\" ] && [ -n \"$e\" ] && echo \"$n|$e|$i\"; " + "done"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                const parts = line.trim().split("|");

                if (parts[0] && parts[1]) {
                    const icon = parts[2] || "";

                    if (icon) {
                        Quickshell.iconPath(icon, "application-x-executable");
                    }

                    Shared.allApps = Shared.allApps.concat([
                        {
                            name: parts[0],
                            exec: parts[1],
                            icon: icon
                        }
                    ]);
                }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (!wifiProc.running) {
                wifiProc.running = true;
            }
        }
    }
}
