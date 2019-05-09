import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.0
import Qt.labs.folderlistmodel 2.1
Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c3
    anchors.centerIn: parent
    clip:true
    visible: false
    z:9999
    property bool abierto: false
    property bool aplicar: false
    property string prevAppfontFamily
    property string selectedfontFamily
    onVisibleChanged: {
        if(visible){
            abierto=true
            prevAppfontFamily=appSettings.fontFamily
            cbFF.currentText=appSettings.fontFamily
        }
        if(!visible&&aplicar){
            appSettings.fontFamily=r.selectedfontFamily
        }else{
            appSettings.fontFamily=r.prevAppfontFamily
        }
        if(!visible){
            aplicar=false
        }
    }
    Flickable{
        id:xS
        width: colCentral.width
        height: r.height
        contentWidth: colCentral.width
        contentHeight: colCentral.height
        anchors.horizontalCenter: r.horizontalCenter
        Column{
            id:colCentral
            spacing: app.fs*2
            Text {
                text: '<b>Confuguracion</b>'
                font.pixelSize: app.fs*0.5*1.5
                color: app.c2
            }
            Row{
                height: app.fs*0.5
                Text {
                    text: "Volume: "
                    font.pixelSize: app.fs*0.5
                    color: app.c2
                    anchors.verticalCenter: parent.verticalCenter
                }
                Slider{
                    id:sv
                    width: app.fs*8
                    height: app.fs
                    from: 0
                    to:100
                    anchors.verticalCenter: parent.verticalCenter
                    onValueChanged: {
                        var v=parseFloat(value*0.01)
                        appSettings.volume=v.toFixed(2)
                    }
                    Component.onCompleted: value=parseInt(appSettings.volume*100)
                }
                Item{
                    width: app.fs*6
                    height: app.fs
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        text: "%"+parseInt(sv.value)
                        font.pixelSize: app.fs*0.5
                        color: app.c2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            Row{
                spacing: app.fs
                height: app.fs*0.5
                Text {
                    text: "Colores: "
                    font.pixelSize: app.fs*0.5
                    color: app.c2
                    anchors.verticalCenter: parent.verticalCenter
                }
                Row{
                    spacing: app.fs*0.5
                    height: app.fs*0.5
                    Text {
                        text: "Claro"
                        color: app.c2
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    URadioButton{
                        id: rbt1
                        checked: appSettings.tema===1
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tema=1
                                app.setTema()
                                rbt2.checked=false
                                rbt3.checked=false
                                rbt4.checked=false
                            }
                        }
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                Row{
                    spacing: app.fs*0.1
                    height: app.fs*0.5
                    Text {
                        text: "Oscuro"
                        color: app.c2
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    URadioButton{
                        id: rbt2
                        checked: appSettings.tema===2
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tema=2
                                app.setTema()
                                rbt1.checked=false
                                rbt3.checked=false
                                rbt4.checked=false
                            }
                        }
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                Row{
                    spacing: app.fs*0.1
                    height: app.fs*0.5
                    Text {
                        text: "Orange"
                        color: app.c2
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    URadioButton{
                        id: rbt3
                        checked: appSettings.tema===3
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tema=3
                                app.setTema()
                                rbt1.checked=false
                                rbt2.checked=false
                                rbt4.checked=false
                            }
                        }
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                Row{
                    spacing: app.fs*0.1
                    height: app.fs*0.5
                    Text {
                        text: "Unik"
                        color: app.c2
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    URadioButton{
                        id: rbt4
                        checked: appSettings.tema===4
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tema=4
                                app.setTema()
                                rbt1.checked=false
                                rbt2.checked=false
                                rbt3.checked=false
                            }
                        }
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            Row{
                spacing: app.fs
                Text {
                    text: "Tamaño<br>de Lector: "
                    font.pixelSize: app.fs*0.5
                    color: app.c2
                }
                Row{
                    spacing: app.fs*0.5
                    Text {
                        text: "Ocultar"
                        color: app.c2
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    URadioButton{
                        id: rbxt1
                        checked: appSettings.tamlector===-1
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tamlector=-1
                                rbxt2.checked=false
                                rbxt3.checked=false
                                rbxt4.checked=false
                            }
                        }
                    }
                }

                Row{
                    spacing: app.fs*0.5
                    Text {
                        text: "Pequeño"
                        color: app.c2
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    URadioButton{
                        id: rbxt2
                        checked: appSettings.tamlector===0
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tamlector=0
                                rbxt1.checked=false
                                rbxt3.checked=false
                                rbxt4.checked=false
                            }
                        }
                    }
                }
                Row{
                    spacing: app.fs*0.5
                    Text {
                        text: "Mediano"
                        color: app.c2
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    URadioButton{
                        id: rbxt3
                        checked: appSettings.tamlector===1
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tamlector=1
                                rbxt1.checked=false
                                rbxt2.checked=false
                                rbxt4.checked=false
                            }
                        }
                    }
                }
                Row{
                    spacing: app.fs*0.5
                    Text {
                        text: "Grande"
                        color: app.c2
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    URadioButton{
                        id: rbxt4
                        checked: appSettings.tamlector===2
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tamlector=2
                                rbxt1.checked=false
                                rbxt2.checked=false
                                rbxt3.checked=false
                            }
                        }
                    }
                }


            }
            Row{
                spacing: app.fs*0.5
                height: app.fs
                Text {
                    text: "Hacer que Unik inicie simpre con: "
                    font.pixelSize: app.fs*0.5
                    color: app.c2
                    anchors.verticalCenter: parent.verticalCenter
                }
                BotonUX{
                    anchors.verticalCenter: parent.verticalCenter
                    text:'Unik Launcher'
                    fs: app.fs*0.5
                    property bool su: false
                    onClicked: {
                        var j=appsDir+'/cfg.json'
                        unik.deleteFile(j)
                    }
                }
                BotonUX{
                    anchors.verticalCenter: parent.verticalCenter
                    text:app.moduleName
                    fs: app.fs*0.5
                    property bool su: false
                    onClicked: {
                        var j=appsDir+'/cfg.json'
                        var c='{"arg0":"-folder='+appsDir+'/'+app.moduleName+'", "arg1":"-dir='+appsDir+'/'+app.moduleName+'"}'
                        unik.setFile(j, c)
                        var ncode='"import QtQuick 2.0\\nItem{\\nComponent.onCompleted:unik.restartApp(\\"\\")\\n}"'
                        var code='import QtQuick 2.0\n'
                        code+='Item{\n'
                        code+='     id:xdc111\n'
                        code+='     anchors.fill:parent\n'
                        code+='     Xdc{\n'
                        code+='     consulta: "A partir de ahora Unik iniciarà como  '+app.moduleName+'\\nPara deshacer esto tiene que eliminar el archivo cfg.json de la carpeta principal de Unik."\n'
                        code+='     code: '+ncode+'\n'
                        code+='}\n'
                        code+='}\n'
                        var obj = Qt.createQmlObject(code, r, 'xm2222')

                    }
                }
            }
            Row{
                height: app.fs*0.5
                spacing: app.fs*0.5
                Text {
                    text: "Actualizar : "+app.moduleName
                    font.pixelSize: app.fs*0.5
                    color: app.c2
                    anchors.verticalCenter: parent.verticalCenter
                }
                BotonUX{
                    anchors.verticalCenter: parent.verticalCenter
                    text:'Actualizar'
                    fs: app.fs*0.5
                    property bool su: false
                    onClicked: {
                        var j=appsDir+'/cfg.json'
                        var c='{"arg0":"-git=https://github.com/nextsigner/'+app.moduleName+'.git", "arg1":"-dir='+appsDir+'/'+app.moduleName+'"}'
                        unik.setFile(j, c)
                        unik.restartApp("")
                    }
                }
            }
            Row{
                spacing: app.fs
                UText{
                    id: labelEstiloLetra
                    text: "Estilo de Letra: "
                    font.pixelSize: app.fs*0.5
                    font.family: appSettings.fontFamily
                    color: app.c1
                    anchors.verticalCenter: parent.verticalCenter
                }
                ComboBoxFromFolder{
                    id:cbFF
                    width: app.fs*10
                    height: app.fs
                    nameFilters: '*.ttf'
                    showDirs: false
                    onCurrentTextChanged: {
                        if(!r.abierto){
                            return
                        }
                        r.selectedfontFamily=currentText
                        labelEstiloLetra.update()
                    }
                    property int v: 0
                    onPreSelected:  {
                        if(!r.abierto){
                            return
                        }
                        tpreselected.text=text
                        tpreselected.restart()
                        v++
                    }
                    Timer{
                        id: tpreselected
                        running: false
                        repeat: true
                        interval: 250
                        property string text
                        onTriggered: {
                            if(!r.abierto){
                                return
                            }
                            appSettings.fontFamily=text
                            xPrevText.update()
                            app.setFontFamily()
                        }
                    }
                    onAccepted: droping=false
                    Rectangle{
                        id:xPrevText
                        width: app.fs*12
                        height: r.height
                        color: app.c3
                        border.width: 2
                        border.color: app.c1
                        anchors.left: parent.right
                        anchors.leftMargin: app.fs
                        anchors.top: parent.top
                        anchors.topMargin: 0-parent.parent.y
                        visible:parent.droping
                        Column{
                            anchors.centerIn: parent
                            spacing: app.fs
                            UText{
                                text: 'Texto de Ejemplo '+app.ff
                                font.pixelSize: app.fs*0.5
                                width: xPrevText.width-app.fs
                                wrapMode: Text.WordWrap
                                color: app.c2
                            }
                            UText{
                                text: 'Texto de Ejemplo '+app.ff
                                font.pixelSize: app.fs*0.75
                                width: xPrevText.width-app.fs
                                wrapMode: Text.WordWrap
                                color: app.c2
                            }
                            UText{
                                text: 'Texto de Ejemplo '+app.ff
                                font.pixelSize: app.fs
                                width: xPrevText.width-app.fs
                                wrapMode: Text.WordWrap
                                color: app.c2
                            }
                            UText{
                                text: 'Texto de Ejemplo '+app.ff
                                font.pixelSize: app.fs*1.25
                                width: xPrevText.width-app.fs
                                wrapMode: Text.WordWrap
                                color: app.c2
                            }
                        }
                        BotonUX{
                            text: 'X'
                            fs: app.fs*0.5
                            anchors.right: parent.right
                            anchors.rightMargin: app.fs*0.1
                            anchors.top: parent.top
                            anchors.topMargin: app.fs*0.1
                            onClicked: parent.parent.droping=false
                        }
                    }
                }
                BotonUX{
                    text: !r.aplicar?'Aplicar':'Deshacer'
                    onClicked: r.aplicar=!r.aplicar
                    fs: app.fs*0.5
                    z:cbFF.z-1
                }
            }
        }
    }
    Boton{
        w:app.fs
        h:w
        tp:1
        d:'Cerrar'
        c:app.c3
        b:app.c2
        t:'X'
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.5
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.5
        onClicking: {
            r.visible=false
        }
        visible:!xPrevText.visible
    }
}
