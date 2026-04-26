import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import xyz.bitcrack.encryption_practice

RowLayout {
    id: decryptMenu
    spacing: 10

    CipherSelection {}

    ColumnLayout {
        Layout.alignment: Qt.AlignTop

        InputField {}
        KeyField {}

        Button {
            text: qsTr("Decrypt!")
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignBottom | Qt.AlignRight
            Layout.topMargin: 8
        }

        OutputField {}
    }
}