import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import xyz.bitcrack.encryption_practice

RowLayout {
    spacing: 16

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
                checked: settings.aes_key_type === 0
                onClicked: settings.aes_key_type = 0
            }
            RadioButton {
                text: qsTr("From file")
                checked: settings.aes_key_type === 1
                onClicked: settings.aes_key_type = 1
            }
        }
        StackLayout {
            id: keyTypeField
            currentIndex: settings.aes_key_type

            RowLayout {
                Layout.fillHeight: true

                TextField {
                    placeholderText: "Input key"
                    text: settings.aes_key_text
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.horizontalStretchFactor: 2
                    onTextChanged: settings.aes_key_text = text
                }
                Button {
                    text: "Random"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    onClicked: settings.aes_random_key(root.state)
                }
            }
            Button {
                text: qsTr("Choose a file...")
                onClicked: fileDialog.open()
            }
        }
    }

    ColumnLayout {
        visible: root.state.cipher === "aes128" ||
            root.state.cipher === "aes192" ||
            root.state.cipher === "aes256"
        
        Label {
            text: qsTr("IV")
            font.pixelSize: 24
            Layout.fillWidth: true
            Layout.topMargin: 8
        }
        RowLayout {
            RadioButton {
                text: qsTr("From text")
                checked: settings.aes_key_type === 0
                onClicked: settings.aes_key_type = 0
            }
            RadioButton {
                text: qsTr("From file")
                checked: settings.aes_key_type === 1
                onClicked: settings.aes_key_type = 1
            }
        }
        StackLayout {
            id: ivTypeField
            // currentIndex: settings.aes_key_type
            currentIndex: 0

            RowLayout {
                Layout.fillHeight: true

                TextField {
                    placeholderText: "Input IV"
                    text: settings.aes_iv_text
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.horizontalStretchFactor: 2
                    onTextChanged: settings.aes_iv_text = text
                }
                Button {
                    text: "Random"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    onClicked: settings.aes_random_iv(root.state)
                }
            }
            Button {
                text: qsTr("Choose a file...")
                onClicked: fileDialog.open()
            }
        }
    }
}