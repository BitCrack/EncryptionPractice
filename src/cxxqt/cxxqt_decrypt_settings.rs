use cxx_qt_lib::QString;

/// The Rust struct for the QObject
#[derive(Default)]
pub struct RDecryptSettings {
    pub input_type: i32,
    pub input_text: QString,
    pub input_filepath: QString,

    pub key_type: i32,
    pub key_text: QString,
    pub key_filepath: QString,

    pub output_type: i32,
    pub output_text: QString,
    pub output_filepath: QString,
}

impl qobject::QtDecryptSettings {}

/// The bridge definition for our QObject
#[cxx_qt::bridge]
pub mod qobject {
    unsafe extern "C++" {
        include!("cxx-qt-lib/qstring.h");
        /// An alias to the QString type
        type QString = cxx_qt_lib::QString;
    }

    extern "RustQt" {
        // The QObject definition
        // We tell CXX-Qt that we want a QObject class with the name MyObject
        // based on the Rust struct MyObjectRust.
        #[qobject]
        #[qml_element]
        #[qproperty(i32, input_type)]
        #[qproperty(QString, input_text)]
        #[qproperty(QString, input_filepath)]
        #[qproperty(i32, key_type)]
        #[qproperty(QString, key_text)]
        #[qproperty(QString, key_filepath)]
        #[qproperty(i32, output_type)]
        #[qproperty(QString, output_text)]
        #[qproperty(QString, output_filepath)]
        #[namespace = "qt_decrypt_settings"]
        type QtDecryptSettings = super::RDecryptSettings;
    }
}