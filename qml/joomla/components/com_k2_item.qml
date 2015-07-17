import QtQuick 2.0
import "../JSONListModel"
import "../pageLogic.js" as Logic
import QtQuick.Controls 1.1

Rectangle {
    width: Logic.pageWidth
    height: Logic.pageHeight - 50
    anchors.top: parent.top
    anchors.topMargin: 0

    JSONListModel {
        id: jsonModel
        source: "http://" + Logic.domain + "/index.php?option=com_hoicoiapi&task=k2_single_item&id=" + 0
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
            onClicked: Logic.loadK2Item(--idSpin.value)
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
                value: 0
                maximumValue: 999
                minimumValue: 0
            }
            Button{
                id: loadBtn
                anchors.left: idSpin.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                text: "Load item"
                onClicked: Logic.loadK2Item(idSpin.value)
            }
        }
        Button{
            id: nextBtn
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text: "->"
            onClicked: Logic.loadK2Item(++idSpin.value)
        }
      }
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: jsonModel.model

        property int itemId: 2

        header: listHeaderComponent

        delegate: Rectangle{
            height: Logic.pageHeight - 80
            width: Logic.pageWidth
            z:3
            Column {
                width: parent.width
                Text {
                    width: parent.width
                    horizontalAlignment: Text.AlignLeft
                    text: model.title
                }
                Image{
                    width: parent.width
                    fillMode: Image.PreserveAspectFit
                    source: Logic.domain + model.image
                }
                Text{
                    width: parent.width
                    text: model.introtext
                    wrapMode: Text.Wrap
                }
            }
        }
    }

}
