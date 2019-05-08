import QtQuick 2.0
import QtMultimedia 5.0
import Qt.labs.folderlistmodel 2.2
Rectangle {
    id: r
    color: "transparent"
    width: app.an
    height: app.fs*2
    clip:rb.opacity!==1.0
    property url source: mediaPlayer.source
    property alias mp: mediaPlayer
    property alias rb: rb
    property bool cpvisible: rb.opacity===1.0
    property var asec: [] //Array Seconds
    property int  nasec: 0
    property int botSize: Qt.platform.os==='android'?app.fs*2:app.fs
    MediaPlayer {
        id: mediaPlayer
        property bool p
        property bool paused
        volume: appSettings.volume
        source: ''
        onPlaying: {
            p=true
            paused=false
            app.verAyuda=false
            //setAsecs()
        }
        onPaused: {
            p=false
            paused=true
        }
        onStopped: {
            p=false
            paused=false
        }
        onStatusChanged: {
            if(status===MediaPlayer.EndOfMedia){
                app.verAyuda=true
            }
        }
        onPositionChanged: {
            seekSlider.playPosition=position
            xT.setPx()
            if(r.nasec!==r.asec.length-1){
                setAsec(position)
            }
        }
        onDurationChanged: {
            seekSlider.duration = duration
            setAsecs()
        }
        Component.onCompleted: app.mp=mediaPlayer
        function setAsec(p){
            if(p>parseInt(r.asec[r.nasec+1]*1000)){
                r.nasec++
            }
        }
    }

    Timer{
        id:trb
        running: false
        repeat: true
        interval: 3500
        onRunningChanged: {
            if(running){
                rb.opacity=1.0
            }
        }
        onTriggered: {
            rb.opacity=0.0
        }
    }
    Text {
        id: txtInfo
        font.pixelSize: app.fs*0.5
        anchors.bottom: r.bottom
        anchors.bottomMargin: app.fs*0.1
        anchors.horizontalCenter: seekSlider.horizontalCenter
        color: app.c4
        text: 'Modulo '+parseInt(app.mod+1)+' de '+app.cantmod+' Secciòn '+parseInt(app.s+1)+' de '+app.cants
        visible:rb.opacity===1.0&&rb.visible
    }
    Rectangle{
        width: rb.width+app.fs
        height: rb.height+app.fs
        anchors.centerIn: rb
        color: app.c3
        radius: app.fs*0.5
        border.width: 2
        border.color: app.c2
        opacity: 0.5
        visible: rb.opacity===1.0 && rb.visible
        enabled: rb.opacity===1.0
    }
    Row{
        id:rb
        anchors.horizontalCenter: r.horizontalCenter
        anchors.bottom: r.top
        anchors.bottomMargin: app.fs*2
        spacing: app.fs
        opacity: 0.0
        onOpacityChanged: {
            if(opacity===1.0){
                trb.restart()
            }
        }
        Boton{
            w:app.fs*1.5
            h:w
            tp:3
            d:'Ir al Modulo Anterior'
            c:app.c3
            b:app.c2
            t:'\uf049'
            onClicking: {
                trb.restart()
                toBackMod()
            }
            enabled: app.mod!==0
            opacity: enabled?1.0:0.5
        }
        Boton{
            w:app.fs*1.5
            h:w
            tp:3
            d:!appSettings.cbs?'Ir a Secciòn Anterior':'Ir al Anterior Item de Secciòn'
            c:app.c3
            b:app.c2
            t:'\uf04a'
            onClicking: {
                trb.restart()
                back()
            }
            enabled: appSettings.cbs?app.s!==0||app.mod!==0:r.nasec>0
            opacity: enabled?1.0:0.5
        }
        Boton{
            w:app.fs*1.5
            h:w
            tp:3
            d:'Reproducir'
            c:app.c3
            b:app.c2
            t: !mediaPlayer.paused?app.mp.position===app.mp.duration?'\uf0e2':'\uf04c':'\uf04b'
            onClicking:{
                trb.restart()
                play()
            }
        }
        Boton{
            w:app.fs*1.5
            h:w
            tp:3
            d:!appSettings.cbs?'Ir a la Secciòn Siguiente':'Ir al Siguiente Item de Secciòn'
            c:app.c3
            b:app.c2
            t:'\uf04e'
            onClicking: {
                trb.restart()
                next()
            }
            enabled: appSettings.cbs?app.mod<app.cantmod-1||app.s<app.cants-1:r.nasec<r.asec.length
            opacity: enabled?1.0:0.5
        }
        Boton{
            w:app.fs*1.5
            h:w
            tp:3
            d:'Ir al Modulo Siguiente'
            c:app.c3
            b:app.c2
            t:'\uf050'
            onClicking: {
                trb.restart()
                toNextMod()
            }
            enabled: app.mod<app.cantmod-1
            opacity: enabled?1.0:0.5
        }
        Boton{
            w:app.fs*1.5
            h:w
            tp:3
            d:appSettings.cbs?'Modo Ver Segmentos de Audio':'Modo Normal'
            c:app.c3
            b:app.c2
            t:'\uf024'
            visible: controles.asec.length!==0
            onClicking: {

                appSettings.cbs=!appSettings.cbs
            }
            Text {
                text: '\uf05e'
                font.family: "FontAwesome"
                font.pixelSize:app.fs*1.5
                color:'red'
                visible:appSettings.cbs
                anchors.centerIn: parent
            }
        }
        Boton{
            w:app.fs*1.5
            h:w
            tp:3
            d:'Ayuda de esta secciòn'
            c:app.c3
            b:app.c2
            t:'\uf128'
            onClicking: {
                rb.opacity=0.0
                app.verAyuda=!app.verAyuda
            }
            opacity: app.verAyuda?1.0:0.5
        }
    }
    Rectangle{
        id:xAsecs
        anchors.fill: seekSlider
        color: 'transparent'
        visible: !appSettings.cbs
    }
    SeekControlFinal{
        id: seekSlider
        width: parent.width*0.8
        height: rb.opacity===1.0?app.fs:app.fs*0.5
        anchors.horizontalCenter: parent.horizontalCenter
        y:rb.opacity===1.0?0:r.height-app.fs
        verFondo: true
        visible: mediaPlayer.source!==''
        onClickSeek: {
            app.verAyuda=false
            trb.restart()
            mediaPlayer.seek(position);
            //r.p=false
        }
        onSeekingChanged: {
            app.verAyuda=false
            trb.restart()
            if(seeking){
                mediaPlayer.pause()
            }else{
                mediaPlayer.play()
            }
        }

        onSeekPositionChanged: {
            app.verAyuda=false
            trb.restart()
            mediaPlayer.seek(playPosition)
        }
    }
    MouseArea{
        anchors.fill: r
        enabled: rb.opacity!==1.0
        hoverEnabled: true
        onEntered: rb.opacity=1.0
        onPositionChanged: rb.opacity=1.0
        onClicked: {
            rb.opacity=1.0
        }
    }

    onAsecChanged: {
        if(asec.length>0){
            appSettings.cbs=false
        }
    }
    function setAsecs(){
        for(var i=0;i<xAsecs.children.length;i++){
            xAsecs.children[i].destroy(1)
        }

        var npx=0-r.botSize+1;
        var alt=0;
        var xan=0;
        for(var i=0;i<r.asec.length;i++){
            var d1=mediaPlayer.duration-(r.asec[i]*1000)
            var d2=d1/mediaPlayer.duration
            npx=seekSlider.width*(1.0-d2)
            if(npx<=xan&&i!==0){
                alt++
            }else{
                alt=1
            }
            var c='import QtQuick 2.0
                        Rectangle{
                                width: 4
                                height: r.rb.opacity===1.0?r.botSize*'+alt+':seekSlider.height
                                color:r.rb.opacity===0.0?"transparent":"red"
                                anchors.bottom:parent.verticalCenter
                                Behavior on height {NumberAnimation{duration:250}}
                                Text {
                                        text:"\uf024"
                                        font.family: "FontAwesome"
                                        font.pixelSize:parent.height
                                        color:"red"
                                        visible:r.rb.opacity==0.0
                                }
                                Rectangle{
                                    width: r.rb.opacity===1.0?r.botSize:0
                                    height: width
                                    color:"red"
                                    radius:width*0.5
                                    anchors.bottom:parent.top
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: rb.opacity===1.0
                                    Behavior on width {NumberAnimation{duration:250}}
                                    Text{
                                        text:""+parseInt('+i+'+1)
                                        font.pixelSize:r.botSize*0.6
                                        color: "white"
                                        anchors.centerIn: parent
                                    }
                                    MouseArea{
                                           anchors.fill: parent
                                            hoverEnabled: true
                                            onEntered: trb.stop()
                                            onExited: trb.restart()
                                           onClicked:{
                                                    r.nasec='+i+'
                                                    mediaPlayer.seek(r.asec[r.nasec]*1000)
                                            }
                                    }
                                }
                        }
        '
            var obj = Qt.createQmlObject(c, xAsecs, 'xasecs')
            obj.x=npx
            xan=obj.x+r.botSize
         }
    }
    function play(){
        if(mediaPlayer.p){
            mediaPlayer.pause()
        }else{
            mediaPlayer.play()
        }
    }
    function next(){
        if(appSettings.cbs){
            appSettings.pcs=app.cants
            mediaPlayer.stop()
            if(app.s===app.cants-1){
                app.s=0
                app.mod++
            }else{
                app.s++
            }
        }else{
            if(r.asec.length>r.nasec){
                r.nasec++
            }else{
                r.nasec=0
            }
            mediaPlayer.seek(r.asec[r.nasec]*1000)
        }
    }
    function back(){
        if(appSettings.cbs){
            mediaPlayer.stop()
            if(app.s>0){
                app.s--
            }else{
                if(app.mod>0){
                    app.mod--
                }
                app.s=appSettings.pcs-1
            }
        }else{
            if(r.nasec>0){
                r.nasec--
            }else{
                r.nasec=0
            }
            mediaPlayer.seek(r.asec[r.nasec]*1000)
        }
    }
    function toBackMod(){
        if(appSettings.cbs){
            mediaPlayer.stop()
            app.mod--
            app.prepMod()
        }else{
            r.nasec-=2
            mediaPlayer.seek(r.asec[r.nasec]*1000)
        }
    }
    function toNextMod(){
        if(appSettings.cbs){
            appSettings.pcs=app.cants
            app.s=0
            app.mod++
            app.prepMod()
        }else{
            r.nasec+=2
            mediaPlayer.seek(r.asec[r.nasec]*1000)
        }
    }
}
