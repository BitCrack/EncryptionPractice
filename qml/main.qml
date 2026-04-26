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

    readonly property QtState state: QtState {
        lang: "en"
        cipher: "aes128"
        input_type: 0
        key_type: 0
        output_type: 0
    }

    ButtonGroup { id: cipher }
    ButtonGroup { id: inputType }
    ButtonGroup { id: keyType }
    ButtonGroup { id: outputType }

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