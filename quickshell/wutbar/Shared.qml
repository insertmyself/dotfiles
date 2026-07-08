pragma Singleton
import QtQuick

QtObject {
    property string titleText: "Nothing"
    property string titleIcon: " "
    property string artistText: "Nothing"
    property string artistIcon: " "
    property string artUrl: ""
    property string wifiText: " Disconnect ]"
    property string wifiIcon: "[ "
    property string githubUsername: "insert.myself"
    property string username: ""
    property string distro: ""
    property string windowManager: ""
    property int brightness: 0
    property bool isPlaying: false
    property var levels: []
    property var allApps: []
}
