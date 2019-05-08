import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.0
Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c3
    anchors.centerIn: parent
    clip:true
    visible: false
    z:9999
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
                    RadioButton{
                        font.pixelSize: app.fs*0.5
                        checked: appSettings.tema===1
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tema=1
                                app.setTema()
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
                    RadioButton{
                        font.pixelSize: app.fs*0.5
                        checked: appSettings.tema===2
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tema=2
                                app.setTema()
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
                    RadioButton{
                        font.pixelSize: app.fs*0.5
                        checked: appSettings.tema===3
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tema=3
                                app.setTema()
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
                    RadioButton{
                        font.pixelSize: app.fs*0.5
                        checked: appSettings.tema===4
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tema=4
                                app.setTema()
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
                    RadioButton{
                        font.pixelSize: app.fs*0.5
                        checked: appSettings.tamlector===-1
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tamlector=-1
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
                    RadioButton{
                        font.pixelSize: app.fs*0.5
                        checked: appSettings.tamlector===0
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tamlector=0
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
                    RadioButton{
                        font.pixelSize: app.fs*0.5
                        checked: appSettings.tamlector===1
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tamlector=1
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
                    RadioButton{
                        font.pixelSize: app.fs*0.5
                        checked: appSettings.tamlector===2
                        onCheckedChanged: {
                            if(checked){
                                appSettings.tamlector=2
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
                    Text {
                        id:tb2
                        text: "Descargar"
                        font.pixelSize: app.fs*0.5
                        color: app.c3
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
        }
    }

    Component.onCompleted: {

    }
}
