import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import xyz.bitcrack.encryption_practice

RowLayout {
    spacing: 10

    ColumnLayout {
        id: settingsTab
        Layout.alignment: Qt.AlignTop
        Layout.fillWidth: false
        Layout.preferredWidth: parent.width / 3
        spacing: 12

        Button {
            text: qsTr("Language")
            Layout.fillWidth: true
            onClicked: settingsPage.currentIndex = 0
        }

        Button {
            text: qsTr("Credits")
            Layout.fillWidth: true
            onClicked: settingsPage.currentIndex = 1
        }

        Button {
            text: qsTr("About")
            Layout.fillWidth: true
            onClicked: settingsPage.currentIndex = 2
        }
    }
    StackLayout {
        id: settingsPage
        currentIndex: 0

        ColumnLayout {
            Label {
                text: qsTr("Language")
                font.pixelSize: 24
                Layout.fillWidth: true
            }
            RadioButton {
                checked: true
                text: qsTr("English")
                onToggled: root.state.lang = "en"
            }
            RadioButton {
                text: qsTr("Polski")
                onToggled: root.state.lang = "pl"
            }
        }
        ColumnLayout {
            Label {
                text: qsTr("Credits")
                font.pixelSize: 24
                Layout.fillWidth: true
            }
            Label {
                text: qsTr("Program written by <a href=\"bitcrack.xyz\">BitCrack</a> as part of a weekly task for Dragons SKN's CTF division.")
                wrapMode: Text.Wrap
                Layout.fillWidth: true
                MouseArea {
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onClicked: if(parent.hoveredLink !== "") Qt.openUrlExternally(parent.hoveredLink)
                    cursorShape: (parent.hoveredLink !== "") ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
            }
            RowLayout {
                Layout.alignment: Qt.AlignCenter
                Layout.topMargin: 8
                spacing: 18
                Image {
                    source: "qrc:/assets/bitcrack_avatar.png"
                    fillMode: Image.PreserveAspectFit
                    Layout.preferredWidth: 128
                    Layout.preferredHeight: 128
                }
                Image {
                    source: "qrc:/assets/dragons_avatar.png"
                    fillMode: Image.PreserveAspectFit
                    Layout.preferredWidth: 128
                    Layout.preferredHeight: 128
                }
            }
        }
        ColumnLayout {
            Label {
                text: qsTr("About")
                font.pixelSize: 24
                Layout.fillWidth: true
            }
            Label {
                text: qsTr("Built using:<br>" +
                    "- <a href=\"https://rust-lang.org/\">Rust</a><br>" +
                    "- <a href=\"https://github.com/KDAB/cxx-qt\">cxx-qt</a><br>" +
                    "- <a href=\"https://www.jetbrains.com/rust/\">JetBrains RustRover</a>")
                wrapMode: Text.Wrap
                Layout.fillWidth: true
                MouseArea {
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onClicked: if(parent.hoveredLink !== "") Qt.openUrlExternally(parent.hoveredLink)
                    cursorShape: (parent.hoveredLink !== "") ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
            }
        }
    }
}