import QtQuick 2.0
import QtQuick.Controls 1.1
import "pageLogic.js" as PageLogic

Component{
    id: listDelegate
    Rectangle{
        height: 30
        width: parent.width
        Label{
            height: 30
            text: name
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 10
            width: parent.width
            anchors.left: parent.left
            font.pixelSize: 14
            MouseArea{
                id: ma
                anchors.fill: parent
                onActiveFocusChanged: {
                    console.log("!")
                }
                onClicked: PageLogic.push(name, source)
            }
        }
        Rectangle{
            anchors.bottom: parent.bottom
            height: 1; width: parent.width
            color: "#e0e0e0"
        }
    }
}
