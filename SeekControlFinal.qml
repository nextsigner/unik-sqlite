import QtQuick 2.0

Item {
    id: seekControl
    width: parent.width
    property int duration: 0
    property int playPosition: 0
    property int seekPosition: 0
    property bool enabled: true
    property bool seeking: false
    property bool verFondo: false
    signal clickSeek(int position)

    onSeekPositionChanged: {
        seekControl.playPosition = seekPosition
    }
    Rectangle {
        id: background
        width: parent.width
        height: progressBar.height
        color: app.c1
        opacity: 0.5
        radius: parent.height / 15
        anchors.verticalCenter: progressHandle.verticalCenter
        MouseArea{
            width:  parent.width
            height: parent.height*4
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                var posActual = seekControl.seekPosition;
                var irA = mouseX * seekControl.duration / background.width
                clickSeek(irA)
            }
        }
    }

    Rectangle {
        id: progressBar
        anchors { left: parent.left;}
        width: seekControl.duration == 0 ? 0 : background.width * seekControl.playPosition / seekControl.duration
        color: app.c2
        opacity: 1.0
        height: seekControl.height/4
        anchors.verticalCenter: progressHandle.verticalCenter
    }

    Text {
        width: contentWidth
        anchors { right: parent.left; rightMargin: 10 }
        anchors.verticalCenter: progressBar.verticalCenter
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        color: app.c2
        smooth: true
        text: formatTime(playPosition)
        font.pixelSize: app.fs*0.5
    }

    Text {
        width: contentWidth
        anchors { left: parent.right; leftMargin: 10 }
        anchors.verticalCenter: progressBar.verticalCenter
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        color: app.c2
        smooth: true
        text: formatTime(duration)
        font.pixelSize: app.fs*0.5
    }

    Rectangle {
        id: progressHandle
        height: parent.height*0.65
        width: parent.height*0.65
        radius: width*0.5
        color: app.c2
        anchors.verticalCenter: seekControl.verticalCenter
        x: seekControl.duration == 0 ? 0 : seekControl.playPosition / seekControl.duration * background.width
        MouseArea {
            id: mouseArea
            anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom }
            height: parent.height*2
            width: parent.height* 2
            enabled: seekControl.enabled
            drag {
                target: progressHandle
                axis: Drag.XAxis
                minimumX: 0
                maximumX: background.width
            }
            onPressed: {
                seekControl.seeking = true;
            }
            onCanceled: {
                seekControl.seekPosition = progressHandle.x * seekControl.duration / background.width
                seekControl.seeking = false
            }
            onReleased: {
                seekControl.seekPosition = progressHandle.x * seekControl.duration / background.width
                clickSeek(seekControl.seekPosition)
                seekControl.seeking = false
                mouse.accepted = true
            }
        }
    }

    Timer { // Update position also while user is dragging the progress handle
        id: seekTimer
        repeat: true
        interval: 300
        running: seekControl.seeking
        onTriggered: {
            seekControl.seekPosition = progressHandle.x*seekControl.duration / background.width
        }
    }

    function formatTime(timeInMs) {
        if (!timeInMs || timeInMs <= 0) return "0:00"
        var seconds = timeInMs / 1000;
        var minutes = Math.floor(seconds / 60)
        seconds = Math.floor(seconds % 60)
        if (seconds < 10) seconds = "0" + seconds;
        return minutes + ":" + seconds
    }
}
