import QtQuick 2.0
Item{
    id:r
    width: r.parent.width
    height: app.al-app.fs*2
    visible: app.verAyuda&&r.parent.visible&&!controles.cpvisible
    onVisibleChanged: {
        var w=0;
        for(var i=0;i<pa.children.length;i++){
            if(pa.children[i].width>w){
                w=pa.children[i].width
            }
        }
        rxa.width=w+app.fs
        if(visible){
            app.verAyuda=true
        }
    }
    Tap{}
    Rectangle{
       id:rxa
       height: pa.height+app.fs
        color: app.c3
        border.color: app.c2
        border.width: 2
        radius: app.fs*0.5
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: xT.height
        Column{
            id:pa
            anchors.centerIn: parent
            spacing: app.fs*0.5
        }
    }
    function addBa(d1,d2,d3){
        var comp=Qt.createComponent('BotonA.qml')
        var obj=comp.createObject(pa,{"t1":d1, "t2":d2, "s":d3})
    }
}
