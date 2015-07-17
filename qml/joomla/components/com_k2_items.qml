import QtQuick 2.0
import QtQuick.Controls 1.1
import "../JSONListModel"
import "../pageLogic.js" as Logic

Rectangle {
    width: Logic.pageWidth
    height: parent.height
    anchors.top: parent.top

    Column {
        spacing: 0
        anchors.fill: parent
        anchors.margins: 0
        anchors.bottomMargin: 0

        JSONListModel {
            id: jsonModel
            source: "http://" + Logic.domain + "/index.php?option=com_hoicoiapi&task=k2_items&id=" + Logic.catId
            query: "$"
        }

        // Navigation
        Component {
          id: listHeaderComponent
          Rectangle {
            id: headerItem
            z: 3
            color: "#8bc34a"
            width: parent.width; height: 35
            Button{
                id: prevBtn
                anchors.leftMargin: 10
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: "<-"
                onClicked: Logic.loadK2Items(--idSpin.value)
            }
            Rectangle{
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                width: idLabel.width + idSpin.width + loadBtn.width + 10
                height: parent.height
                Label{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    id: idLabel
                    text: "id:"
                }
                SpinBox{
                    id: idSpin
                    anchors.left: idLabel.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    value: Logic.catId ? Logic.catId : 0
                    maximumValue: 999
                    minimumValue: 0
                }
                Button{
                    id: loadBtn
                    anchors.left: idSpin.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Load items"
                    onClicked: Logic.loadK2Items(idSpin.value)
                }
            }
            Button{
                id: nextBtn
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                text: "->"
                onClicked: Logic.loadK2Items(++idSpin.value)
            }
          }
        }



        ListView {
            id: listView
            width: parent.width
            height: parent.height

            model: jsonModel.model
            header: listHeaderComponent
            delegate: Rectangle {
                clip: true
                width: parent.width
                height: 100
                Rectangle{
                    width: parent.width - 20
                    height: 80
                    y: 10
                    color: "transparent"
                    x: 10
                    Text {
                        id: title
                        width: parent.width
                        horizontalAlignment: Text.AlignLeft
                        text: model.title
                        height: 20
                        font.pixelSize: 16
                    }
                    Text{
                        id: itemIntro
                        anchors.left: parent.left
                        anchors.top: title.bottom
                        anchors.topMargin: 5
                        height: parent.height - 24
                        width: parent.width * 0.6 - 5
                        wrapMode: Text.WrapAnywhere
                        text: model.introtext
                        font.pixelSize: 10
                    }
                    Image{
                        id: itemImage
                        width: parent.width * 0.4
                        fillMode: Image.PreserveAspectFit
                        height: parent.height
                        anchors.top: title.bottom
                        anchors.left: itemIntro.right
                        enabled: (model.image == "media/k2/items/cache/") ? false : true
                        source: (model.image == "media/k2/items/cache/") ? ("qrc:/qml/joomla/Camera_icon.gif") : ("http://" + Logic.domain + "/" + model.image)
                        opacity: status === Image.Ready ? 1.0 : 0.0
                        Behavior on opacity{
                            NumberAnimation{
                                property: "opacity"
                                duration: 400
                                easing.type: Easing.InOutCirc
                            }
                        }
                    }
                }
                Rectangle{
                    width: parent.width
                    height: parent.height * 0.2
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.rgba(255,255,255,0.0) }
                        GradientStop { position: 1.0; color: Qt.rgba(255,255,255,1.0) }
                    }

                }

                MouseArea{
                    z: 0
                    anchors.fill: parent
                    onClicked: Logic.loadK2Item(model.id)
                }
                Rectangle{
                    anchors.bottom: parent.bottom
                    height: 1; width: parent.width
                    color: "#e0e0e0"
                }
            }
        }
    }
}
