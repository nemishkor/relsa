import QtQuick 2.0
import QtQuick.Controls 1.1
import "../JSONListModel"
import "../pageLogic.js" as Logic

Rectangle {
    id: main
    width: Logic.pageWidth
    height: parent.height
    anchors.top: parent.top

    Column {
        spacing: 0
        anchors.fill: parent
        anchors.margins: 5
        anchors.bottomMargin: 0

        JSONListModel {
            id: jsonModel
            source: "http://" + Logic.domain + "/index.php?option=com_hoicoiapi&task=k2_categories"
            query: "$"
        }

        ListView {
            id: listView
            width: parent.width
            height: parent.height
            model: jsonModel.model

            delegate: Rectangle {
                width: parent.width
                height: 30
                Component.onCompleted: console.log("http://" + Logic.domain + model.image)
                Row{
                    width: parent.width - 20
                    height: 30
                    x: 10
                    Text {
                        width: parent.width - 50
                        horizontalAlignment: Text.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        text: model.name
                        font.pixelSize: 14
                    }
                }
                Image{
                    id: catImage
                    height: parent.height - 5
                    fillMode: Image.PreserveAspectFit
                    anchors.right: infoBtn.left
                    anchors.rightMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    opacity: 0.4
                    enabled: (model.image == "/media/k2/categories/") ? false : true
                    source: (model.image == "/media/k2/categories/") ? ("qrc:/qml/joomla/Camera_icon.gif") : ("http://" + Logic.domain + model.image)
                }
                Button{
                    id: infoBtn
                    width: 20
                    height: 20
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: "i"
                    z: 1
                    onClicked: Logic.catDetails(model.id, model.name, model.description, catImage.source, model.language, model.parent)
                }
                MouseArea{
                    z: 0
                    anchors.fill: parent
                    onClicked: {
                        Logic.catId = model.id
                        Logic.push(model.name, "components/com_k2_items.qml")
                    }
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
