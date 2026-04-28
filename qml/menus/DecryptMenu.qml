import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import xyz.bitcrack.encryption_practice

RowLayout {
    id: encryptMenu
    property QtDecryption settings: root.decryption

    spacing: 10

    CipherSelection {
        Layout.preferredWidth: parent.width * 0.2
    }

    ColumnLayout {
        Layout.alignment: Qt.AlignTop
        Layout.preferredWidth: parent.width * 0.8

        InputField {}
        KeyField {}

        Button {
            text: qsTr("Decrypt!")
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignBottom | Qt.AlignRight
            Layout.topMargin: 8
            onClicked: settings.decrypt(root.state)
        }
        Label {
            text: settings.output_error
            color: "red"
            wrapMode: Text.Wrap
        }

        OutputField {}
    }
}