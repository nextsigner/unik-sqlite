import QtQuick 2.7
import QtQuick.Controls 2.0
import QtWebEngine 1.4

Item {
    id: raiz
    anchors.fill: parent
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


    WebEngineView{
        id: wv
        width: r.width
        height: r.height-xTiUrl.height
        anchors.top: xTiUrl.bottom
        url:raiz.url
        profile: defaultProfile
        focus: true
        property string linkContextRequested
        property QtObject defaultProfile: WebEngineProfile {
            storageName: "Default"
            onDownloadRequested: {
                app.onDLR(download)
            }
            onDownloadFinished: {

            }
        }
        settings.javascriptCanOpenWindows: true
        settings.allowRunningInsecureContent: false
        //settings.hyperlinkAuditingEnabled:  true
        settings.javascriptCanAccessClipboard: true
        settings.localStorageEnabled: true
        settings.javascriptEnabled: true
        onNewViewRequested: {
            request.openIn(wv)
            request.accepted = true;
        }
        onLoadProgressChanged: {
            /*if(loadProgress!==100){
                wv.opacity = 0.0
            }else{
                wv.opacity = 1.0
            }*/
        }
        onContextMenuRequested: function(request) {
            var lurl = ''+request.linkUrl
            if(lurl!==''){
                wvf.linkContextRequested = lurl
                menuLink.visible = true
            }
            request.accepted = true;
            contextMenu.x = request.x;
            contextMenu.y = request.y;
            contextMenu.visible = true
        }
        property int previsibility: 1
        onFullScreenRequested: {
            if(request.toggleOn){
                wv.previsibility=app.visibility
                app.visibility = "FullScreen"
                wv.state = "FullScreen"
                xTools.width=0
            }else{
                app.visibility = wv.previsibility
                wv.state = ""
                xTools.width=app.width*0.02
            }
            request.accept()
        }
        onUrlChanged: {
            //raiz.url = url
            tiUrl.text=url
        }
        Shortcut {
            sequence: "Ctrl+Tab"
            onActivated: {
                clipboard.setText("     ")
                wv.focus = true
                wv.triggerWebAction(WebEngineView.Paste)
            }
        }
        Shortcut {
            sequence: "Ctrl+R"
            onActivated: {

            }
        }



    }


    Menu {
        id: contextMenu
        onVisibleChanged: {
            if(!visible){
                menuLink.visible = false
                //ccs.visible = false
            }
        }
        MenuItem { id: menuLink; text: "Copiar Url"
            visible: false
            enabled: visible
            height: visible ? undefined : 0
            onTriggered:{
                clipboard.setText(wvinstagram.linkContextRequested)
            }
        }

        MenuItem { text: "Atras"
            onTriggered:{
                wvinstagram.goBack()
            }
        }
        MenuItem { text: "Adelante"
            onTriggered:{
                wvinstagram.goForward()
            }
        }
        MenuItem { text: "Cortar"
            onTriggered:{
                wvinstagram.triggerWebAction(WebEngineView.Cut)
            }
        }
        MenuItem { text: "Copiar"
            onTriggered:{
                wvinstagram.triggerWebAction(WebEngineView.Copy)
                var js='\'\'+window.getSelection()'
                wvinstagram.runJavaScript(js, function(result) {
                    logView.log(result);
                });

                //logView.log(wvyutun.ViewSource.toString())
            }
        }
        MenuItem {
            id: menuPegar
            text: "Pegar"
            onTriggered:{
                wvinstagram.triggerWebAction(WebEngineView.Paste)
            }
        }
        MenuItem {
            id: menuSalir
            text: "Apagar"
            onTriggered:{
                Qt.quit()
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
