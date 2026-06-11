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
            id: xlabel_item
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
            id: graph_item
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
                    startX: slider_1.x
                    startY: slider_1.visualPosition * graph_item.height

                    strokeWidth: 10

                    fillColor: "#470932"

                    PathCubic {
                        relativeControl1X: Math.abs(slider_1.x-slider_2.x)/2
                        relativeControl1Y: 0
                        control2X: slider_1.x + Math.abs(slider_1.x-slider_2.x)/2
                        control2Y: slider_2.visualPosition * graph_item.height
                        x: slider_2.x
                        y: slider_2.visualPosition * graph_item.height
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
            id: placeholder_item
        }

        Item {
            id: yaxis_item
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
