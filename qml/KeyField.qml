import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import xyz.bitcrack.encryption_practice

ColumnLayout {
    Label {
        text: qsTr("Key")
        font.pixelSize: 24
        Layout.fillWidth: true
        Layout.topMargin: 8
    }
    RowLayout {
        RadioButton {
            text: qsTr("From text")
            checked: root.state.key_type === 0
            onClicked: root.state.key_type = 0
        }
        RadioButton {
            text: qsTr("From file")
            checked: root.state.key_type === 1
            onClicked: root.state.key_type = 1
        }
    }
    StackLayout {
        id: keyTypeField
        currentIndex: 0

        TextField {
            placeholderText: qsTr("Enter key")
        }
        Button {
            text: qsTr("Choose a file...")
            onClicked: fileDialog.open()
        }
    }
}