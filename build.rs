use cxx_qt_build::{CxxQtBuilder, QmlModule};

fn main() {
    CxxQtBuilder::new_qml_module(QmlModule::new("xyz.bitcrack.encryption_practice")
        .qml_file("qml/main.qml")

        .qml_file("qml/CipherSelection.qml")
        .qml_file("qml/InputField.qml")
        .qml_file("qml/KeyField.qml")
        .qml_file("qml/OutputField.qml")

        .qml_file("qml/menus/EncryptMenu.qml")
        .qml_file("qml/menus/DecryptMenu.qml")
        .qml_file("qml/menus/SettingsMenu.qml")
    )
        // Link Qt's Network library
        // - Qt Core is always linked
        // - Qt Gui is linked by enabling the qt_gui Cargo feature of cxx-cxxqt-lib.
        // - Qt Qml is linked by enabling the qt_qml Cargo feature of cxx-cxxqt-lib.
        // - Qt Qml requires linking Qt Network on macOS
        .qt_module("Network")
        .qrc("resources.qrc")
        .files(["src/cxxqt/cxxqt_state.rs"])
        .build();
}