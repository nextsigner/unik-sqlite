import QtQuick 2.0
Rectangle{
    id:r
    border.width: app.fs*0.1
    border.color: app.c2
    radius: app.fs*0.15
    color: 'transparent'
    clip:true
    property alias tvh: tv.height
    Rectangle{
        id:tv
        width: r.width
        height: app.fs*0.5
        color: app.c2
        radius: parent.radius
        Text {
            id: title
            text: 'Ventana de Aplicaciòn'
            font.pixelSize: parent.width*0.035
            anchors.centerIn: parent
            color:app.c3
        }
        Row{
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.1
            spacing: app.fs*0.1
            Rectangle{
                width: parent.parent.height*0.9
                height: width
                color: app.c3
                radius: app.fs*0.1
               Rectangle {
                   width: parent.width*0.8
                   height: app.fs*0.05
                   anchors.bottom: parent.bottom
                   anchors.bottomMargin: app.fs*0.05
                    color:app.c2
                }
            }
            Rectangle{
                width: parent.parent.height*0.9
                height: width
                color: app.c3
                radius: app.fs*0.1
                Rectangle{
                    color: 'transparent'
                    border.width: app.fs*0.025
                    border.color: app.c2
                    width: parent.height*0.7
                    height: width
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                width: parent.parent.height*0.9
                height: width
                color: app.c3
                radius: app.fs*0.1
                Text {
                    text: 'X'
                    font.pixelSize: parent.height*0.8
                    anchors.centerIn: parent
                    color:app.c2
                }
            }
        }
    }
}
