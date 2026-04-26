import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Dialogs

import xyz.bitcrack.encryption_practice

ApplicationWindow {
    id: root
    title: qsTr("Encryption Practice")
    width: 640
    height: 480
    visible: true
    color: palette.window

    property QtState state: QtState {
        lang: "en"
        cipher: "aes128"
    }

    property QtEncryptSettings encryptSettings: QtEncryptSettings {
        input_type: 0
        input_text: ""
        input_filepath: ""

        key_type: 0
        key_text: ""
        key_filepath: ""

        output_type: 0
        output_text: ""
        output_filepath: ""
    }

    property QtDecryptSettings decryptSettings: QtDecryptSettings {
        input_type: 0
        input_text: ""
        input_filepath: ""

        key_type: 0
        key_text: ""
        key_filepath: ""

        output_type: 0
        output_text: ""
        output_filepath: ""
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