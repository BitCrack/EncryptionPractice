import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import xyz.bitcrack.encryption_practice

ColumnLayout {
    Layout.alignment: Qt.AlignTop

    Label {
        text: qsTr("Cipher")
        font.pixelSize: 24
        Layout.fillWidth: true
    }
    RadioButton {
        text: qsTr("AES-128")
        checked: root.state.cipher === "aes128"
        onToggled: root.state.cipher = "aes128"
    }
    RadioButton {
        text: qsTr("AES-192")
        checked: root.state.cipher === "aes192"
        onToggled: root.state.cipher = "aes192"
    }
    RadioButton {
        text: qsTr("AES-256")
        checked: root.state.cipher === "aes256"
        onToggled: root.state.cipher = "aes256"
    }
    RadioButton {
        text: qsTr("ChaCha20")
        checked: root.state.cipher === "chacha20"
        onToggled: root.state.cipher = "chacha20"
    }
}