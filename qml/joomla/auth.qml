import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "JSONListModel"
import "pageLogic.js" as PageLogic

Rectangle {
    id: loginPanel
    anchors.fill: parent
    color: "cyan"

    function logi(){
        jsonModel.source = "http://" + domain.text + "/index.php?option=com_hoicoiapi&task=login&username=" + login.text + "&pass=" + password.text;
    }

    Timer {
        id: timer
        interval: 800; running: false; repeat: false
        onTriggered: PageLogic.push("extensions.qml")
    }

    Rectangle{
        width: parent.width * 0.8
        anchors.centerIn: parent
        height: parent.height
        color: "transparent"

        ListView {
            id: listView
            width: parent.width
            model: jsonModel.model
            delegate: Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: model.message
                Component.onCompleted: if(model.message == "success") {
                                           PageLogic.domain = domain.text
                                           PageLogic.user = login.text
                                           timer.start()
                                       }
            }
        }

        Column{
            spacing: 20
            y: 40
            width: parent.width

            TextField {
                id: domain
                text: "newpage.in.ua"
                width: parent.width
            }
            TextField {
                id: login
                text: "login"

                width: parent.width
            }
            TextField {
                id: password
                echoMode: TextInput.Password
                text: "pass"
                width: parent.width
                onAccepted: logi()
            }
            Button{
                id: loginBtn

                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.8
                text: "LOGIN"
                onClicked: {
                    logi();
                }
            }
            JSONListModel {
                id: jsonModel
                source: ""
                query: "$"
            }
        }
    }
}
