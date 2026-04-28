import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Dialogs

import xyz.bitcrack.encryption_practice

ApplicationWindow {
    id: root
    title: qsTr("Encryption Practice")
    width: 800
    height: 480
    visible: true
    color: palette.window

    property QtState state: QtState {
        cipher: "aes128"
    }

    property QtEncryption encryption: QtEncryption {
        input_type: 0
        input_text: ""
        input_filepath: ""

        output_type: 0
        output_text: ""
        output_filepath: ""

        output_error: ""

        // AES-x specific
        aes_key_type: 0
        aes_key_text: ""
        aes_key_filepath: ""

        aes_iv_type: 0
        aes_iv_text: ""
        aes_iv_filepath: ""
    }

    property QtDecryption decryption: QtDecryption {
        input_type: 0
        input_text: ""
        input_filepath: ""

        output_type: 0
        output_text: ""
        output_filepath: ""

        output_error: ""

        // AES-x specific
        aes_key_type: 0
        aes_key_text: ""
        aes_key_filepath: ""

        aes_iv_type: 0
        aes_iv_text: ""
        aes_iv_filepath: ""
    }

    ButtonGroup { id: cipher }

    FileDialog {
        id: fileDialog
        currentFolder: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
        onAccepted: image.source = selectedFile
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        TabBar {
            id: bar
            Layout.fillWidth: true
            TabButton {
                text: qsTr("Encrypt")
            }
            TabButton {
                text: qsTr("Decrypt")
            }
            TabButton {
                text: qsTr("Settings")
            }
        }

        StackLayout {
            currentIndex: bar.currentIndex
            EncryptMenu {}
            DecryptMenu {}
            SettingsMenu {}
        }
    }
}