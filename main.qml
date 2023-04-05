import QtQuick 2.15
import QtQuick.Window 2.15


Window {
    visible: true
    width: 1000
    height: 400
    title: "ArmSat satellite coordinates"

    ListModel {
        id: numberModel
    }

    ListView {
        id: numberListView
        anchors.fill: parent
        model: numberModel

        delegate: Text {
            text: latitude + longitude
            font.pixelSize: 20
            padding: 5
        }

    }


    Timer {
        id: numberGenerator
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            function request() {
                   const xhr = new XMLHttpRequest()
                   xhr.onreadystatechange = function() {
                       if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                       } else if(xhr.readyState === XMLHttpRequest.DONE) {
                           let response = JSON.parse(xhr.responseText)
                           let latitude = JSON.stringify(response.positions[0].satlatitude);
                           let longitude = JSON.stringify(response.positions[0].satlongitude);

                           numberModel.append({latitude: latitude});
                           numberModel.append({longitude: longitude});

                       }
                   }
                   xhr.open("GET", "https://api.n2yo.com/rest/v1/satellite/positions/52765/Lat/Lon/0/2/&apiKey=KH55JV-UHAGAF-RWUG63-50JB")
                   xhr.send()
               }
            request();

        }
    }
}



