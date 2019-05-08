import QtQuick 2.0
Rectangle{
    anchors.fill: parent
    color: 'black'
    opacity: 0.5
    visible: app.verAyuda
    MouseArea{
        anchors.fill: parent
        onClicked: app.verAyuda=false
    }
}
