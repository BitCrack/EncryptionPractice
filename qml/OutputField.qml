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
            checked: settings.output_type === 0
            onClicked: settings.output_type = 0
        }
        RadioButton {
            text: qsTr("To file")
            checked: settings.output_type === 1
            onClicked: settings.output_type = 1
        }
    }
    StackLayout {
        id: outputTypeField
        currentIndex: settings.output_type

        TextField {
            text: settings.output_text
            placeholderText: "Output"
            readOnly: true
        }
        Button {
            text: qsTr("Choose a file...")
            onClicked: fileDialog.open()
        }
    }
}