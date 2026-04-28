use cxx_qt_lib::QString;

/// The Rust struct for the QObject
#[derive(Default)]
pub struct RState {
    pub lang: QString,
    pub cipher: QString,
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
        #[namespace = "qt_state"]
        type QtState = super::RState;
    }
}