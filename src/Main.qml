import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Shapes


Window {
    width: 640
    height: 480
    minimumWidth: 640
    minimumHeight: 480
    visible: true
    color: "#5c4b4b"
    title: qsTr("Soothe")

    GridLayout {
        anchors.fill: parent

        columns: 2
        rows: 2
        Item {
            Layout.minimumWidth: 40
            Layout.fillHeight: true

            Text {
                anchors.top: parent.top
                anchors.right: parent.right
                text: "+15.0"
                font.pixelSize: 14
                font.bold: true
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                text: "0.0"
                font.pixelSize: 14
                font.bold: true
            }

            Text {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                text: "-15.0"
                font.pixelSize: 14
                font.bold: true
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle{
                anchors.fill: parent
                color: "#332a4c"
            }
            Shape {
                id: shape
                ShapePath {
                    id: path
                    startX: 20
                    startY: 20

                    strokeWidth: 10

                    fillColor: "#470932"

                    PathCubic {
                        relativeControl1X: 200
                        relativeControl1Y: 0
                        relativeControl2X: 200
                        relativeControl2Y: 400
                        x: 420
                        y: 420
                    }
                }
            }
            Slider {
                id: slider_1
                height: parent.height

                x: parent.width * 0.333
                orientation: Qt.Vertical
            }
            Slider {
                id: slider_2
                height: parent.height

                x: parent.width * 0.8888
                orientation: Qt.Vertical
            }
        }

        Item {

        }

        Item {
            Layout.fillWidth: true
            height: 20

            Text {
                anchors.top: parent.top
                anchors.left: parent.left
                text: "100"
                font.pixelSize: 14
                font.bold: true
            }

            Text {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                text: "1000"
                font.pixelSize: 14
                font.bold: true
            }

            Text {
                anchors.top: parent.top
                anchors.right: parent.right
                text: "10k"
                font.pixelSize: 14
                font.bold: true
            }
        }

    }
}
