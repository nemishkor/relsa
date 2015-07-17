import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import QtQuick.Controls 1.1
import "pageLogic.js" as PageLogic

Rectangle {
    id: mainWindow
    width: PageLogic.pageWidth
    height: PageLogic.pageHeight

    property bool authoriseted: false

    Component.onCompleted: {
        if(authoriseted){
            var newPage = "auth.qml"
            PageLogic.push("", newPage)
        }
        else{
            var newPage = "extensions.qml"
            PageLogic.push("Extensions", newPage)
        }
    }

    Column{
        width: parent.width
        spacing: 0
        z: 2
        ToolBar{
            id: toolBar
            ToolButton{
                id: backBtn
                anchors.left: parent.left
                text: "<-"
                onClicked: PageLogic.pop()
            }
            Label{
                id: header
                anchors.left: backBtn.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                text: "API demo"
            }
            ToolButton{
                id: loginBtn
                anchors.right: quitBtn.left
                anchors.rightMargin: 5
                text: "login"
                onClicked: PageLogic.push("auth.qml")
            }
            ToolButton{
                id: quitBtn
                anchors.right: parent.right
                text: "X"
                onClicked: Qt.quit()
            }
        }
    }
    Loader{
        id: loader
        z: 0
        height: parent.height - toolBar.height
        width: parent.width
        anchors.bottom: parent.bottom
    }



    // Info Block
    Rectangle{
        id: infoBlock
        opacity: 0.0
        visible: opacity!==0.0 ? true : false
        anchors.fill: parent
        color: Qt.rgba(0,0,0,0.2)
        z: 1
        state: "CLOSED"
        states: [
            State {
                name: "CLOSED"
                PropertyChanges {
                    target: infoBlock
                    opacity: 0.0
                }
            },
            State{
                name: "OPENED"
                PropertyChanges {
                    target: infoBlock
                    opacity: 1.0
                }
            }
        ]
        transitions: [
            Transition {
                from: "CLOSED"
                to: "OPENED"
                NumberAnimation{property: "opacity"; duration: 600;}
            },
            Transition {
                from: "OPENED"
                to: "CLOSED"
                NumberAnimation{property: "opacity"; duration: 200;}
            }
        ]

        Rectangle {
            width: parent.width * 0.8
            height: parent.height * 0.6
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.2
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.1
            radius: 7
            z: 2
            scale: infoBlock.opacity !== 0.0 ? 1 : 0

            Behavior on scale{
                NumberAnimation{
                    duration: 400
                    easing.type: Easing.OutCubic
                }
            }

            gradient: Gradient {
                GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0.9) }
                GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.8) }
            }

            Flickable{
                z: 0
                width: parent.width
                height: parent.height
                contentHeight: itemId.height * 3 + itemDescription.height + 10 + itemName.height + itemImage.height
                contentWidth: parent.width
                boundsBehavior: Flickable.DragOverBounds
                clip: true
                Column{
                    id: colInfo
                    width: parent.width * 0.9
                    x: parent.width * 0.05
                    y: x
                    Text{
                        id: itemId
                        color: "#fff"
                    }
                    Text{
                        id: itemName
                        color: "#fff"
                    }
                    Text{
                        id: itemDescription
                        color: "#fff"
                    }
                    Image{
                        id: itemImage
                        width: parent.width
                        anchors.margins: 5
                        fillMode: Image.PreserveAspectFit
                    }
                    Text{
                        id: itemLanguage
                    }
                    Text{
                        id: itemParent
                    }
                }
            }

            Button{
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 7
                anchors.rightMargin: 7
                text: "x"
                width: 30
                height: 30
                z:1
                onClicked: infoBlock.state = "CLOSED"
            }
        }
    }
    // END Info Block



}
