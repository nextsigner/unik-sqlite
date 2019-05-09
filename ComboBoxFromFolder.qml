import QtQuick 2.9
import QtQuick.Controls 1.4
import Qt.labs.folderlistmodel 2.1
import QtQuick.Controls.Styles 1.4

ComboBox{
    id: r
    width: app.fs*6
    height: app.fs*1.2
    model:folderModel
    textRole: 'fileName'
    property int fontSize: r.height*0.5
    property alias folder: folderModel.folder
    property alias nameFilters: folderModel.nameFilters
    property alias showDirs: folderModel.showDirs
    property string fontFamlily: "Arial"
    property int menuItemHeight: r.height
    property bool menuItemTextAlignHCenter: true
    property bool textAlignHCenter: true
    property bool droping: false
    signal preSelected(string text)
    onCurrentTextChanged: {
        appSettings.fontFamily=currentText
        droping=false
    }
    FolderListModel{
        id: folderModel
        folder: './'
    }
    style: ComboBoxStyle{
        background: Rectangle{
            color: app.c3
            border.width: 2
            border.color: app.c2
            radius: app.fs*0.1
            height: r.height
        }
        property Component __dropDownStyle: MenuStyle {
            __maxPopupHeight: 600
            __menuItemType: "comboboxitem"
            frame: Rectangle {              // background
                color: app.c3
                border.width: 2
                radius: 5
            }
            itemDelegate.label: Rectangle{

                width: r.width
                height: r.menuItemHeight
                color: 'transparent'
                Text {
                    width: r.width
                    anchors.centerIn: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: r.menuItemTextAlignHCenter?Text.AlignHCenter:Text.Normal
                    font.pointSize: r.fontSize
                    font.family: r.fontFamlily
                    color: styleData.selected ? app.c3 : app.c1
                    text: styleData.text
                    onColorChanged: {
                        if(color===app.c3){
                           r.droping=true
                            r.preSelected(text)
                        }
                    }
                }
            }
            itemDelegate.background: Rectangle {  // selection of an item
                onVisibleChanged: {
                    if(!visible){
                        r.droping=false
                    }else{
                        r.droping=true
                    }
                    tpreselected.stop()
                }
                radius: 2
                color: styleData.selected ? app.c1 : "transparent"
                border.width: 2
                border.color: app.c1
                height: r.height                
            }
            __scrollerStyle: ScrollViewStyle { }
        }
        label:  Text{
            color: app.c2
            text: r.currentText
            font.pixelSize: r.fontSize
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: r.textAlignHCenter?Text.AlignHCenter:Text.AlignLeft
        }
    }

}
