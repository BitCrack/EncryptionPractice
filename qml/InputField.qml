import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import xyz.bitcrack.encryption_practice

ColumnLayout {
    Label {
        text: qsTr("Input")
        font.pixelSize: 24
        Layout.fillWidth: true
    }
    RowLayout {
        RadioButton {
            text: qsTr("From text")
            checked: settings.input_type === 0
            onClicked: settings.input_type = 0
        }
        RadioButton {
            text: qsTr("From file")
            checked: settings.input_type === 1
            onClicked: settings.input_type = 1
        }
    }
    StackLayout {
        id: inputTypeField
        currentIndex: settings.input_type

        TextField {
            placeholderText: qsTr("Enter input")
        }
        Button {
            text: qsTr("Choose a file...")
            onClicked: fileDialog.open()
        }
    }
}