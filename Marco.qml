import QtQuick 2.0
Rectangle {
    id: r
    property int padding: app.fs
    property color bc: app.c2
    property int bw: 2
    color: "transparent"
    radius: app.fs*0.1
    border.width: r.bw
    border.color: r.bc
    z:parent.parent.z-1

    width: parent.width+r.padding
    height: parent.height+r.padding
    anchors.centerIn: parent
}
