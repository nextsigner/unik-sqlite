/*
This code was created by @nextsigner
*/
import QtQuick 2.5
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import QtWebView 1.1

ApplicationWindow {
    id: app
    visible: true
    visibility: 'FullScreen'
    width: 720
    height: 480
    color: app.c3
    property string moduleName: 'qdm-sqlite'
    property real ffs: Qt.platform.os!=='android'?0.027:0.03
    property int fs: app.width>app.height?app.width*ffs:app.height*ffs//App Font Size Value
    property int an: app.width>app.height?app.width:app.height
    property int al: app.width>app.height?app.height:app.width

    property color c1: "#62DA06"
    property color c2: "#8DF73B"
    property color c3: "black"
    property color c4: "white"

    property int mod: 0
    property int cantmod//: mods.children.length
    property string gitfolder

    //Variables Globales
    property bool iniciada: false
    property bool gd: false //Git Downloaded
    property string qlandPath

    property int s: 0
    property int cants: 0
    property bool verAyuda: false
    property var pa
    property alias cp: controles

    property var mp:controles.mp

    onClosing: close.accepted = Qt.platform.os!=='android'

    Settings{
        id: appSettings
        category: 'conf-'+app.moduleName
        property int cantRun
        property bool fullScreen
        property real volume
        property int tamlector
        property bool cbs //Control Bar Section or Audio
        property bool logViewVisible

        //Variables de Actualizaciòn
        property string uRS
        property string ucs: ''

        //Variables de Estado
        property int usec
        property int umod
        property int pcs

        property int lvh

        property int tema
        //onTemaChanged: setTema()
    }
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}
    Rectangle{
        id:xApp
        color: app.c3
        width: app.an
        height: app.al
        anchors.centerIn: parent
        rotation: app.width>app.height?0:-90
        MouseArea{
            anchors.fill: parent
            onDoubleClicked: app.visibility="FullScreen"
        }
        Item{
            id:xS
            width: parent.width
            height: controles.visible?parent.height-app.fs*2:parent.height
            clip:true
        }
        Rectangle{
            anchors.fill: parent
            color:app.c3
            visible:xEstado.text!==''
            Text {
                id: xEstado
                text: app.moduleName
                font.pixelSize: app.fs
                anchors.centerIn: parent
                color:app.c2
                width: parent.width*0.6
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                onTextChanged: {
                    if(text!==''){
                        tShowS.restart()
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                onDoubleClicked: {
                    app.mod=0
                    app.s=0
                }
                onClicked: {
                    prepMod()
                }
            }
        }
        Xp{id:xP}
        Xt{id:xT;visible:appSettings.tamlector!==-1&&at!==''}
        ControlesPrincipales{id:controles;anchors.bottom: xApp.bottom;}
        Xc{id:xC}
        Xu{id:xU}
        LogView{
            width: parent.width
            height: appSettings.lvh
            fontSize: app.fs
            topHandlerHeight: Qt.platform.os!=='android'?app.fs*0.25:app.fs*0.75
            anchors.bottom: parent.bottom
            visible: appSettings.logViewVisible
        }
        Xb{
            id:xB
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: xT.top
        }
        Xm{id:xM;onPressed: xBM.opacity=0.3;}
        Item{
            id:xBM
            width: xM.botSize
            height: width
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.1
            anchors.left: parent.left
            anchors.leftMargin: xM.botSize*0.1
            opacity: 0.3
            Behavior on opacity{NumberAnimation{duration:750}}
            Timer{
                running: xBM.opacity<1.0
                repeat: false
                interval: 5000
                onTriggered: xBM.opacity=0.3
            }
            Boton{
                w:xM.botSize
                h:w
                tp:3
                d:'Menu'
                c:app.c3
                b:app.c2
                t:'\uf142'
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered:{
                    xBM.opacity=1.0
                    xM.opacity=xM.opacity===0.0?1.0:0.0
                }
                onExited: xBM.opacity=0.3
                onClicked: {
                    xBM.opacity=1.0
                    xM.opacity=xM.opacity===0.0?1.0:0.0
                }
            }
        }
        focus: true
        property bool shift: false
        Shortcut {
            sequence: "Shift+Right"
            onActivated: {
                if(!appSettings.cbs){
                    app.mp.seek(app.mp.position+1000)
                }else{
                    controles.next()
                }
            }
        }
        Shortcut {
            sequence: "Shift+Left"
            onActivated: {
                if(!appSettings.cbs){
                    app.mp.seek(app.mp.position-1000)
                }else{
                    controles.back()
                }
            }
        }
        Keys.onSpacePressed:  {
            if(!app.mp.p){
                app.mp.play()
            }else{
                app.mp.pause()
            }
        }
        Keys.onRightPressed: {
            if(appSettings.cbs){
                app.mp.seek(app.mp.position+1000)
            }else{
                controles.next()
            }
        }
        Keys.onLeftPressed:  {
            if(appSettings.cbs){
                app.mp.seek(app.mp.position-1000)
            }else{
                controles.back()
            }
        }
        Keys.onEscapePressed: {
            if(app.visibility===ApplicationWindow.FullScreen){
                app.visibility="Windowed"
            }else{
                Qt.quit()
            }
        }
    }
    Timer{
        id:tu
        running: true
        repeat: false
        interval: 1000*5
        property int v: 0
        onTriggered: {
            tu.v++
            var d = new Date(Date.now())
            unik.setDebugLog(false)
            var ur0 = ''+unik.getHttpFile('https://github.com/nextsigner/qdm-sqlite/commits/master?r='+d.getTime())
            var m0=ur0.split("commit-title")
            var m1=(''+m0[1]).split('</p>')
            var m2=(''+m1[0]).split('\">')
            var m3=(''+m2[2]).split('<')
            var ur = ''+m3[0]
            if(appSettings.uRS===''){
                appSettings.uRS=ur
            }
            if(appSettings.uRS!==ur&&appSettings.cantRun>0){
                appSettings.uRS = ur
                xU.visible=true
                if(ur.indexOf('[')>-1){
                    xU.commit=ur
                }
                app.mp.pause()
            }
            unik.setDebugLog(true)
            tu.interval=1000*60*5
            tu.repeat=true
            tu.start()
        }
    }

    Timer{
        id:tinit
        running: false
        repeat: true
        interval: 10
        onTriggered: {
            if(xP.cm){
                console.log('Modulos Listados...')
                console.log('Modulo a cargar: '+app.mod)
                console.log('Seccion a cargar: '+app.s)
                app.iniciada=true
                tinit.stop()
                prepMod()
            }
        }
    }
    Timer{
        id:tShowS
        running: false
        repeat: false
        interval: 25000
        onTriggered: {
            xEstado.text='La carga de la secciòn\nha tenido problemas para cargarse\ncorrentamente.\n\nTocar la pantalla para reintentar.'
        }
    }
    onVerAyudaChanged: {
        if(pa){
            pa.visible=verAyuda
            pa.y=verAyuda?app.height-pa.height-app.fs*6:app.height+pa.height+app.fs*4
        }
    }
    onSChanged:{
        if(xP.cm){
            prepMod()
            appSettings.ucs=s
        }
    }
    onModChanged: appSettings.umod=mod

    Component.onCompleted: {
        var ukldata='-folder='+appsDir+'/'+app.moduleName+' -cfg'
        var ukl=appsDir+'/link_'+app.moduleName+'.ukl'
        unik.setFile(ukl, ukldata)

        console.log('Ejecuciòn nùmero: '+appSettings.cantRun)
        appSettings.cantRun++

        if(Qt.platform.os==='linux'){
            qlandPath=unik.getPath(5)
        }else if(Qt.platform.os==='android'){
            qlandPath=appsDir+'/'+app.moduleName
        }else{
            qlandPath=unik.getPath(5)
            console.log('Windows qlandPath: '+app.qlandPath)
        }

        //Volume
        if(appSettings.cantRun===1){
            appSettings.volume=0.8
        }
        //appSettings.umod=0
        //appSettings.ucs=0
        app.mod=appSettings.umod
        app.s=appSettings.ucs

        if(appSettings.tema<=0){
            appSettings.tema=1
        }
        if(appSettings.lvh<=0){
            appSettings.lvh=100
        }
        tinit.start()
        console.log('appSettings.cbs='+appSettings.cbs)
    }
    function prepMod(){
        xT.at=''
        xT.ex=0
        controles.asec=[]
        appSettings.cbs=true
        controles.mp.stop()
        var mod=''+xP.am[app.mod]
        if(xP.am.length===0){
            xEstado.text='Error al leer carpetas del sistema...'
            return
        }
        if(mod==='undefined'){
            xEstado.text='Restaurando modulo...'
            app.mod=0
        }
        xEstado.text='Preparando Modulo: '+parseInt(app.mod+1)+'\nCarpeta: '+app.qlandPath+'/'+xP.am[app.mod]
        for(var i=0;i<xS.children.length;i++){
            xS.children[i].destroy(1)
        }
        var code='import QtQuick 2.0\n'
        code+='import Qt.labs.folderlistmodel 2.2\n'
        code+='Item{\n'
        code+='         FolderListModel{\n'
        if(Qt.platform.os==='android'){
            code+='         folder: \'file://\'+app.qlandPath+\'/\'+xP.am[app.mod]\n'
        }else if(Qt.platform.os==='android'){
            code+='         folder: \'file://\'+app.qlandPath+\'/\'+xP.am[app.mod]\n'
        }else if(Qt.platform.os==='windows'){
            code+='         folder: \'file:///\'+app.qlandPath+\'/\'+xP.am[app.mod]\n'
        }else{
            code+='         folder: \'file://\'+app.qlandPath+\'/\'+xP.am[app.mod]\n'
        }
        code+='                 id:fl2\n'
        code+='                 showFiles: false\n'
        code+='                 sortField: FolderListModel.Name\n'
        code+='                 onCountChanged: {\n'
        code+='                     tfl2.restart()\n'
        code+='                 }\n'
        code+='             }\n'

        code+='             Timer{\n'
        code+='                     id:tfl2\n'
        code+='                     running: false\n'
        code+='                     repeat: false\n'
        code+='                     interval: 1000\n'
        code+='                     onTriggered: {\n'
        code+='                                 var v=0\n'
        code+='                                 xP.ars=[]\n'
        code+='                                 for(var i=0;i<fl2.count;i++){\n'
        code+='                                         xP.ars.push(fl2.get(i, \'fileName\'))\n'
        code+='                                         console.log(\'NXP.ars=\'+fl2.get(i, \'fileName\'))\n'
        code+='                                         console.log(\'fl2.folder=\'+fl2.folder)\n'
        code+='                                         console.log(\'appsDir.folder=\'+app.qlandPath)\n'
        code+='                                         v++\n'
        code+='                                 } \n'
        code+='                                 app.cants=v\n'
        code+='                                 //console.log("El modulo "+app.mod+" tiene "+v+" secciones.")\n'
        code+='                                 prepShowS()\n'
        code+='                      }\n'
        code+='               }\n'


        code+='}\n'

        var obj = Qt.createQmlObject(code, xS, 'xm2')
        controles.visible=true
    }
    function prepShowS(){
        app.gd=false
        app.gitfolder=''
        var f=''+xP.am[app.mod]+'/'+xP.ars[app.s]
        if(f.indexOf('undefined')>=0){
            return
        }
        var uf=app.qlandPath+'/'+xP.am[app.mod]+'/'+xP.ars[app.s]+'/url'
        var url=(''+unik.getFile(uf)).replace(/\n/g, '')
        console.log('app.gitfolder from: '+uf)
        console.log('Git url: '+url+' en '+uf)

        var eg=unik.fileExist(uf)
        if(eg){
            console.log('Preparando Url Git...')
            var m0=url.split('/')
            var m1=''+m0[m0.length-1]
            var m2=m1.replace('.git', '')
            app.gitfolder=m2
            console.log('app.gitfolder='+app.gitfolder)
            f+='/'+m2
            var sf=app.qlandPath+'/'+xP.am[app.mod]+'/'+xP.ars[app.s]+'/'+app.gitfolder+'/S.qml'
            console.log('Descargando Mòdulo desde '+url)
            var folder=app.qlandPath+'/'+xP.am[app.mod]+'/'+xP.ars[app.s]
            console.log('Descargando Mòdulo en '+folder)
            var uf2=f+'/S.qml'
            var fe=unik.fileExist(sf)
            if(!fe){
                console.log('app.gitfolder: '+app.gitfolder)
                xEstado.text='Descargando '+url+'\nen '+folder
                xB.tit='Descargando '+url
                xB.visible=true
                app.gd = unik.downloadGit(url, folder)
                showS()
            }else{
                var msg1='Revisando '+folder+'...'
                console.log(msg1)
                xEstado.text+=msg1
                if(!unik.fileExist(uf)){
                    xEstado.text+='\nNo se detecta url... '
                    showS()
                }else{
                    xEstado.text+='\nChequeando Actualizacion desde '+url
                    checkCommit(url)
                }
            }
        }else{
            msg1='Mostrando secciòn presente en '+folder
            console.log(msg1)
            xEstado.text+='\n'+msg1
            showS()
        }
    }
    function checkCommit(url){
        var folder=app.qlandPath+'/'+xP.am[app.mod]+'/'+xP.ars[app.s]
        var d = new Date(Date.now())
        var ms=d.getTime()
        //var pp=app.qlandPath+'/'+xP.am[app.mod]+'/'+xP.ars[app.s]
        var uf=folder+'/commit'
        console.log('uf:'+uf)
        var fms=folder+'/fms'
        var afms=(''+unik.getFile(fms)).replace(/\n/g,'')
        console.log('afms: '+afms+' fms: '+fms)
        unik.setFile(fms, ''+ms)
        if(afms!=='error'&&(parseInt(afms)-ms)<1000*60*60*4){
            console.log('afms activo: '+afms)
            showS()
            return
        }
        var u1=url.replace('.git', '')
        var u2=u1+'/commits/master?r='+ms
        var xhr = new XMLHttpRequest();
        xhr.open('GET', u2);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var ur0 = ''+xhr.responseText
                //console.log('checkCommit response '+ur0)
                var m0=ur0.split("commit-title")
                if(m0.length===1){
                    return
                }
                var m1=(''+m0[1]).split('</p>')
                var m2=(''+m1[0]).split('\">')
                if(m2.length<=2){
                    return
                }
                var m3=(''+m2[2]).split('<')
                var ur = ''+m3[0]
                console.log(ur)

                if(!unik.fileExist(uf)){
                    unik.setFile(uf, ur)
                    showS()
                }else{
                    var aur=''+unik.getFile(uf)
                    if(aur===ur){
                        console.log('Section Commit Equal')
                        showS()
                    }else{
                        console.log('Section Commit NO Equal')
                        console.log('app.gitfolder: '+app.gitfolder)
                        xEstado.text='Actualizando desde '+url
                        xB.tit='Descargando '+url
                        xB.visible=true
                        app.gd= unik.downloadGit(url, folder)
                        unik.setFile(uf, ur)
                        showS()
                    }
                }
            }
        }
        xhr.send(null);
    }
    function showS(){
        for(var i=0;i<xS.children.length;i++){
            xS.children[i].destroy(1)
        }
        var f=''+xP.am[app.mod]+'/'+xP.ars[app.s]
        if(app.gitfolder!==''){
            f+='/'+app.gitfolder
        }
        xEstado.text='Renderizando...  '+f
        var d = new Date(Date.now())
        var nid=d.getTime()
        var code='import QtQuick 2.0\n'
        code+='import "'+f+'" as SX'+nid+'\n'
        code+='Item{\n'
        code+='anchors.fill:parent\n'
        code+='     SX'+nid+'.S{}\n'
        code+='}\n'
        app.mp.source=''+f+'/a1.m4a'
        app.mp.play()
        console.log('Code: '+code)
        var obj = Qt.createQmlObject(code, xS, 'xm2'+nid)
        xC.z=xS.z+1
        xEstado.text=''
        tShowS.stop()       
    }
    function showCab(){
        app.cb.tit="Modulo "+parseInt(app.mod+1)+" de "+app.cantmod+" Secciòn "+parseInt(app.s+1)+" de "+app.cants
    }
    function addA(t1, t2, s){
        var componente = Qt.createComponent('A.qml')
        var objeto = componente.createObject(app, {"t1":t1, "t2": t2, "source": s})
    }
    function lnl(d, h){
        return app.mp.position>d*1000&&app.mp.position<h*1000? 'activo':'inactivo'
    }
    function p(d, h){
        return app.mp.position>d*1000&&app.mp.position<h*1000 ? true : false
    }
    function runQml(c){
        var obj = Qt.createQmlObject(c, xS, 'xm4')
    }
    function setTema(){
        if(appSettings.tema===1){
            c1='#000'
            c2='#333'
            c3= 'white'
            c4= 'black'
        }
        if(appSettings.tema===2){
            c1='#333'//"#62DA06"
            c2='white'//"#8DF73B"
            c3= 'black'//"black"
            c4= '#ccc'//"white"
        }
        if(appSettings.tema===3){
            c1="#EB761D"
            c2="#ff8833"
            c3="black"
            c4="white"
        }
        if(appSettings.tema===4){
            c1="#62DA06"
            c2="#8DF73B"
            c3="black"
            c4="white"
        }
    }
}
