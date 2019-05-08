import QtQuick 2.7
import QtQuick.Controls 2.0
import QtWebView 1.1

Rectangle {
    id: raiz
    anchors.fill: parent
    color: app.c3
    property int red
    property string url
    onUrlChanged: wv.url=url
    Rectangle{
        id: xTiUrl
        width: raiz.width
        height: app.fs*0.6
        z:height!==0?ma.z+100:0
        Row{
            anchors.centerIn: parent
            Text {
                id: labelUrl
                text: 'Url: '
                font.pixelSize: app.fs*0.5

            }
            Rectangle{
                width: xTiUrl.width-labelUrl.contentWidth
                height: xTiUrl.height
                border.width: 1
                clip: true
                TextInput{
                    id: tiUrl
                    width: parent.width*0.98
                    height: app.fs*0.5
                    text: wv.url
                    font.pixelSize: app.fs*0.5
                    anchors.centerIn: parent

                    Keys.onReturnPressed: wv.url=tiUrl.text
                }

            }
        }
    }


    WebView{
        id: wv
        width: r.width
        height: r.height-xTiUrl.height
        anchors.top: xTiUrl.bottom
        url:raiz.url
        focus: true        
        onUrlChanged: {
            tiUrl.text=url
        }
        Timer{
            running: true
            repeat: true
            interval: 250
            onTriggered: {
                raiz.visible=!controles.cpvisible
            }
        }
    }


    MouseArea{
        id: ma
        width: raiz.width
        height: app.fs*0.25
        hoverEnabled: true
        onEntered: {
            xTiUrl.height=app.fs*0.5
            ma.height=app.fs
        }
        onExited: {
            xTiUrl.height=0;
            ma.height=app.fs*0.5
        }
    }
}
