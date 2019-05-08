import QtQuick 2.0
Item{
    id:r
    width: txtTit.width<r.parent.width-app.fs?txtTit.width+app.fs*0.5:parent.width-app.fs
    height: app.fs*0.5
    opacity:visible?1.0:0.0
    visible:false
    property alias tit: txtTit.text
    Behavior on opacity{NumberAnimation{duration:250}}
    Connections {target: unik;onUkStdChanged:r.setPb(''+unik.ukStd);}
    Connections {target: unik;onUkStdChanged:r.setPb(''+unik.ukStd); }
    onVisibleChanged: {
        if(visible){
            r.opacity=1.0
        }
    }
    onOpacityChanged: {
        if(opacity===0.0){
            txtPb.text='%0'
       }
    }
    Rectangle{
        width: r.width
        height: r.height
        color: app.c3
        radius: app.fs*0.25
        clip: true
        border.width: 1
        border.color: app.c2
        Item{
            width: r.width-app.fs*0.1
            height: r.height-app.fs*0.1
            anchors.centerIn: parent
            Rectangle{
                id:pb
                width: 0
                height: parent.height
                color: 'red'
                radius: parent.parent.radius
            }
        }
        Text {
            id: txtPb
            text:'%0'
            font.pixelSize: parent.height*0.8
            color: app.c2
            anchors.centerIn: parent
            onTextChanged: {
                if(text==='%100'){
                    toc.start()
                    tit='Descargando...'
                }
                if(text!=='%100'&&text!=='%0'){
                    r.visible=true
                    tShowS.restart()
                }
            }
        }
    }
    Text {
        id: txtTit
        text:'Descargando...'
        font.pixelSize: app.fs*0.5
        color: app.c2
        anchors.horizontalCenter: r.horizontalCenter
        anchors.bottom: r.top
        anchors.bottomMargin: app.fs*0.25
        Rectangle{
            width: txtTit.contentWidth+app.fs*0.5
            height:txtTit.contentHeight+app.fs*0.5
            color: app.c3
            anchors.centerIn: parent
            z:parent.z-1
            radius: app.fs*0.25
            border.width: 1
            border.color: app.c2
        }
    }
    Timer{
        id:toc
        running: false
        repeat: false
        interval: 1500
        onTriggered: {
            r.visible=false
        }
    }
    function setPb(t){
        var  d=(''+t).replace(/\n/g, ' ')
        var p=true
        if(d.indexOf('Socket')>=0){
            p=false
        }else if(d.indexOf('download git')>=0){
            var m0=''+d.replace('download git ','')
            var m1=m0.split(' ')
            if(m1.length>1){
                var m2=(''+m1[1]).replace('%','')
                //unik.setFile('/home/nextsigner/nnn', ''+m2)
                var m3=parseInt(m2.replace(/ /g,''))
                txtPb.text='%'+parseInt(m3)
                pb.width=pb.parent.width/100*m3
            }
        }
    }
}
