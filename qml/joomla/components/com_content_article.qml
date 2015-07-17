import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Rectangle{
    width: PageLogic.pageWidth
    height: parent.height - 50
    anchors.top: parent.top
    anchors.topMargin: 50
    XmlListModel{
        id: listModel
        query: path
        XmlRole {name: "id"; query: "id/string()"}
        XmlRole {name: "title"; query: "title/string()"}
        XmlRole {name: "userName"; query: "userName/string()"}
        XmlRole {name: "numViews"; query: "numViews/string()"}
        XmlRole {name: "numVotes"; query: "numVotes/string()"}
        XmlRole {name: "numComments"; query: "numComments/string()"}
        XmlRole {name: "numHearts"; query: "numHearts/string()"}
        XmlRole {name: "rank"; query: "rank/string()"}
        XmlRole {name: "dateCreated"; query: "dateCreated/string()"}
        XmlRole {name: "hex"; query: "hex/string()"}
        XmlRole {name: "red"; query: "rgb/red/string()"}
        XmlRole {name: "blue"; query: "rgb/blue/string()"}
        XmlRole {name: "green"; query: "rgb/blue/string()"}
        XmlRole {name: "hue"; query: "hsv/hue/string()"}
        XmlRole {name: "saturation"; query: "hsv/saturation/string()"}
        XmlRole {name: "value"; query: "hsv/value/string()"}
        XmlRole {name: "description"; query: "description/string()"}
        XmlRole {name: "url"; query: "url/string()"}
        XmlRole {name: "imageUrl"; query: "imageUrl/string()"}
        XmlRole {name: "badgeUrl"; query: "badgeUrl/string()"}
        XmlRole {name: "apiUrl"; query: "apiUrl/string()"}
    }

    property string type: "colors";
    property string category: "top";
    property string path: "/colors/color";
    property int heightDelegate: 120;
    property int resultOffset: 0;
    property string dataURI;

    function loadXml(){
        dataURI = "http://www.colourlovers.com/api/" + type + "/" + category + "?numResults=20" + "&resultOffset=" + resultOffset
        console.log(dataURI);
        var req = new XMLHttpRequest();
        req.open("get", dataURI);
        req.send();
        req.onreadystatechange = function () {
            if (req.readyState === XMLHttpRequest.DONE) {
                if (req.status === 200) {
                    listModel.xml = req.responseText;
                    listModel.reload();
                    console.log(listModel.xml)
                    if(listModel.count == 1){
                        heightDelegate = page.height
                    }
                    list.visible = true;
                } else {
                    console.log("HTTP request failed", req.status)
                    loadLbl.text = "HTTP request failed\nRequest status " + req.status + "\nCheck your Internet connection"
                }
            }
        }
    }

    Component.onCompleted: {
        loadXml()
    }

    ListView
    {
        width: parent.width
        height: parent.height
        id : list
        model : listModel
        delegate: Item {
            width: parent.width
            height: heightDelegate
            Image{
                id: image
                fillMode: Image.Tile
                source: imageUrl
                anchors.fill: parent
            }
            Rectangle{
                width: parent.width
                height: parent.height
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#cc000000" }
                    GradientStop { position: 0.7; color: "#00000000" }
                }
                Column{
                    Text{
                        x: 20
                        y: 10
                        color: "#ffffff"
                        text: title
                    }
                    Text{
                        x: 20
                        font.pixelSize: 14
                        color: "#eeeeee"
                        text: (numViews == 1) ? "VIEW " + numViews : "VIEWS " + numViews
                    }
                    Text{
                        x: 20
                        font.pixelSize: 14
                        color: "#eeeeee"
                        text: (numHearts == 1) ? "LOVE " + numHearts : "LOVES " + numHearts
                    }
                }
            }
        }
    }
}
