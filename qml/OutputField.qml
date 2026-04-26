import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import xyz.bitcrack.encryption_practice

ColumnLayout {
    Label {
        text: qsTr("Output")
        font.pixelSize: 24
        Layout.fillWidth: true
        Layout.topMargin: 16
    }
    RowLayout {
        RadioButton {
            text: qsTr("To text")
            checked: root.state.output_type === 0
            onClicked: root.state.output_type = 0
        }
        RadioButton {
            text: qsTr("To file")
            checked: root.state.output_type === 1
            onClicked: root.state.output_type = 1
        }
    }
    StackLayout {
        id: outputTypeField
        currentIndex: 0

        TextField {
            placeholderText: qsTr("Output")
            readOnly: true
        }
        Button {
            text: qsTr("Choose a file...")
            onClicked: fileDialog.open()
        }
    }
}