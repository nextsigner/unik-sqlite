import QtQuick 2.0
Rectangle {
    id: r
    color: app.c2
    radius: app.fs*0.1
    border.width: 2
    border.color: app.c1
    width: a.contentWidth+app.fs
    height: app.fs*2
    property alias t1: a.text
    property string t2
    property string s
    Text {
        id: a
        font.pixelSize: app.fs
        color:app.c3
        anchors.centerIn: parent
    }
    MouseArea{
        anchors.fill: r
        onClicked: {
            if(r.s==='inicio'){
                app.mod=0
                app.s=0
                app.prepMod()
            }else if(r.s==='1'){
                cp.next()
            }else if(s.indexOf('{')>-1){
                console.log('code:'+s)
                app.runQml(s)
            }else{
                app.addA(r.t1, r.t2, r.s)
            }
        }
    }
}
