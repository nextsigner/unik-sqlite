import QtQuick 2.0
Item{
    id:r
    anchors.fill: parent
    property string consulta: ''
    property string code: ''
    Rectangle{
        anchors.fill: r
        opacity: 0.65
        color:app.c3
        visible:false
    }
    Rectangle{
        anchors.centerIn: parent
        width: app.fs*20
        height: msg.contentHeight+app.fs*5
        color: app.c2
        radius: app.fs
        Text{
            id:msg
            width: parent.width*0.9
            wrapMode: Text.WordWrap
            anchors.centerIn: parent
            font.pixelSize: app.fs
            color:app.c3
            text:r.consulta
        }
        Row{
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: app.fs*0.5
            spacing: app.fs*0.5
            Rectangle{
                id:bot1
                width: app.fs*3
                height: app.fs*1.2
                color: app.c3
                radius: app.fs*0.25
                Behavior on width{NumberAnimation{duration:150}}
                Text{
                    anchors.centerIn: parent
                    font.pixelSize: app.fs
                    color:app.c2
                    text:'<b>Si</b> '
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                            runCode(r.code)
                    }
                }
            }
            Rectangle{
                width: app.fs*3
                height: app.fs*1.2
                color: app.c3
                radius: app.fs*0.25
                Text{
                    anchors.centerIn: parent
                    font.pixelSize: app.fs
                    color:app.c2
                    text:'<b>No</b> '
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        r.visible=false
                    }
                }
            }
        }
    }
    function runCode(c){
        var obj = Qt.createQmlObject(c, xS, 'xdc2')
    }
}
