import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic


Window {
    width: 640
    height: 480
    minimumWidth: 640
    minimumHeight: 480
    visible: true
    color: "#5c4b4b"
    title: qsTr("Soothe")

    RowLayout {
        id: main_rowlayout
        anchors.fill: parent
        Canvas {
            id: waveform_canvas
            Layout.fillWidth: true
            Layout.fillHeight: true
            onPaint: {
                var ctx = getContext("2d");
                ctx.fillStyle = "#599188";
                ctx.fillRect(0, 0, width, height);
            }
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Slider {
                    from: 0
                    to: 100
                    value: 33
                    orientation: Qt.Vertical
                }
                Slider {
                    from: 0
                    to: 100
                    value: 33
                    orientation: Qt.Vertical
                }
                Slider {
                    from: 0
                    to: 100
                    value: 33
                    orientation: Qt.Vertical
                }
            }
        }

        Slider {
            id: volume_slider
            from: 0
            to: 100
            value: 33
            orientation: Qt.Vertical
        }
    }
    
    Component {
        id: eq_slider
        Slider {
            from: 0
            to: 100
            value: 40
            orientation: Qt.Vertical
        }
    }
}
