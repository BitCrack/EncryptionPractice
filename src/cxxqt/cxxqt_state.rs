use core::pin::Pin;
use cxx_qt_lib::QString;

/// The Rust struct for the QObject
#[derive(Default)]
pub struct RState {
    lang: QString,
    cipher: QString,
    input_type: i32,
    key_type: i32,
    output_type: i32,
}

impl qobject::QtState {}

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
        #[qproperty(QString, lang)]
        #[qproperty(QString, cipher)]
        #[qproperty(i32, input_type)]
        #[qproperty(i32, key_type)]
        #[qproperty(i32, output_type)]
        #[namespace = "qt_state"]
        type QtState = super::RState;
    }
}