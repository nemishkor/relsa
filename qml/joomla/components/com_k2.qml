import QtQuick 2.0
import QtQuick.Controls 1.1
import "../pageLogic.js" as PageLogic
import "../"

Rectangle{
    id: main
    anchors.fill: parent
    ListModel {
        id: menuModel

        ListElement {
            name: "Categories"
            source: "components/com_k2_categoris.qml"
        }
        ListElement {
            name: "Items"
            source: "components/com_k2_items.qml"
        }
        ListElement {
            name: "Item"
            source: "components/com_k2_item.qml"
        }
    }

    ListDelegate{
        id: del
    }

    ListView{
        id: menuView

        anchors.fill: parent

        model: menuModel
        delegate: del
    }

}
