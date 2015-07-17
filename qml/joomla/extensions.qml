import QtQuick 2.0
import QtQuick.Controls 1.1
import "pageLogic.js" as PageLogic

Rectangle{
    id: main
    width: PageLogic.pageWidth
    ListModel {
        id: menuModel

        ListElement {
            name: "Joomla content"
            type: "component"
            source: "components/com_content"
        }
        ListElement {
            name: "K2"
            type: "component"
            source: "components/com_k2.qml"
        }
        ListElement {
            name: "Banners"
            type: "component"
            source: "components/com_banners.qml"
        }
        ListElement {
            name: "Users"
            type: "component"
            source: "components/com_users.qml"
        }
        ListElement {
            name: "Cache"
            type: "plugin"
            source: "components/com_cache.qml"
        }
    }

    ListDelegate{
        id: delegate
    }

    ListView{
        id: menuView

        anchors.fill: parent

        model: menuModel
        delegate: delegate
        section.property: "type"
        section.delegate: Rectangle{
            width: parent.width
            height: 35
            color: "#009688"
            Text{
                color: "white"
                font.pixelSize: 14
                anchors.fill: parent
                text: section
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

}
