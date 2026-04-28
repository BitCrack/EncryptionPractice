use std::pin::Pin;
use cxx_qt::CxxQtType;
use cxx_qt_lib::QString;
use crate::cxxqt::cxxqt_state::qobject::QtState;
use aes::cipher::{KeyIvInit, StreamCipher};
use crate::cxxqt::{generate_random_aes_iv, generate_random_aes_key, AES_128_KEY_LEN, AES_192_KEY_LEN, AES_256_KEY_LEN, AES_IV_LEN};

/// The Rust struct for the QObject
#[derive(Default)]
pub struct REncryption {
    pub input_type: i32,
    pub input_text: QString,
    pub input_filepath: QString,

    pub output_type: i32,
    pub output_text: QString,
    pub output_filepath: QString,

    pub output_error: QString,

    // AES-x specific
    pub aes_key_type: i32,
    pub aes_key_text: QString,
    pub aes_key_filepath: QString,

    pub aes_iv_type: i32,
    pub aes_iv_text: QString,
    pub aes_iv_filepath: QString,
}

impl qobject::QtEncryption {
    pub unsafe fn encrypt(mut self: Pin<&mut Self>, state: *const QtState) {
        let state_ref = unsafe { state.as_ref() }.expect("QtState pointer was null!");
        let cipher_name = state_ref.rust().cipher.to_string();

        // Get the input

        let mut data = if self.rust().input_type == 0 {
            self.rust().input_text.to_string().into_bytes()
        } else {
            let path = self.rust().input_filepath.to_string();
            match std::fs::read(&path) {
                Ok(bytes) => bytes,
                Err(e) => {
                    self.set_output_error(QString::from(
                        format!("Failed to read the input from file {path}: {e}")
                    ));
                    return;
                }
            }
        };

        // Get the key for AES

        let key_bytes = if self.rust().aes_key_type == 0 {
            self.rust().aes_key_text.to_string().into_bytes()
        } else {
            let path = self.rust().aes_key_filepath.to_string();
            match std::fs::read(&path) {
                Ok(bytes) => bytes,
                Err(e) => {
                    self.set_output_error(QString::from(
                        format!("Failed to read the key from file {path}: {e}")
                    ));
                    return;
                }
            }
        };
        let key_slice = &key_bytes;

        // Get the IV for AES

        let iv_bytes = if self.rust().aes_iv_type == 0 {
            self.rust().aes_iv_text.to_string().into_bytes()
        } else {
            let path = self.rust().aes_iv_filepath.to_string();
            match std::fs::read(&path) {
                Ok(bytes) => bytes,
                Err(e) => {
                    self.set_output_error(QString::from(
                        format!("Failed to read the IV from file {path}: {e}")
                    ));
                    return;
                }
            }
        };
        let iv_slice = &iv_bytes;
        if iv_slice.len() != AES_IV_LEN {
            self.as_mut().set_output_error(QString::from(
                format!("Error! IV for AES has to be {AES_IV_LEN} bytes / {AES_IV_LEN} characters long!")
            ));
            return;
        }

        // Encrypt...

        match cipher_name.as_str() {
            "aes128" => {
                if key_slice.len() != AES_128_KEY_LEN {
                    self.as_mut().set_output_error(QString::from(
                        format!("Error! Key for AES-128 needs to be {AES_128_KEY_LEN} bytes / {AES_128_KEY_LEN} characters long!")
                    ));
                    return;
                }
                type Aes128Ctr = ctr::Ctr128BE<aes::Aes128>;
                let mut cipher = Aes128Ctr::new_from_slices(key_slice, iv_slice)
                    .expect("AES128 key/nonce length mismatch");
                cipher.apply_keystream(&mut data);
                println!("AES-128");
            }
            "aes192" => {
                if key_slice.len() != AES_192_KEY_LEN {
                    self.as_mut().set_output_error(QString::from(
                        format!("Error! Key for AES-192 needs to be {AES_192_KEY_LEN} bytes / {AES_192_KEY_LEN} characters long!")
                    ));
                    return;
                }
                type Aes192Ctr = ctr::Ctr128BE<aes::Aes192>;
                let mut cipher = Aes192Ctr::new_from_slices(key_slice, iv_slice)
                    .expect("AES192 key/nonce length mismatch");
                cipher.apply_keystream(&mut data);
                println!("AES-192");
            }
            "aes256" => {
                if key_slice.len() != AES_256_KEY_LEN {
                    self.as_mut().set_output_error(QString::from(
                        format!("Error! Key for AES-256 needs to be {AES_256_KEY_LEN} bytes / {AES_256_KEY_LEN} characters long!")
                    ));
                    return;
                }
                type Aes256Ctr = ctr::Ctr128BE<aes::Aes256>;
                let mut cipher = Aes256Ctr::new_from_slices(key_slice, iv_slice)
                    .expect("AES256 key/nonce length mismatch");
                cipher.apply_keystream(&mut data);
                println!("AES-256");
            }
            _ => {
                self.as_mut().set_output_error(QString::from(
                    format!("Error! Incorrect cipher: {cipher_name}!")
                ));
                return;
            }
        }

        // Output

        if self.rust().output_type == 0 {
            let hex_output = data.iter()
                .map(|b| format!("{:02x}", b))
                .collect::<String>();

            self.as_mut().set_output_text(QString::from(&hex_output));
            println!("{:?}", hex_output);
        } else {
            let output_filepath = self.rust().output_filepath.to_string();
            if let Err(e) = std::fs::write(&output_filepath, &data) {
                self.as_mut().set_output_error(QString::from(
                    format!("Failed to write output file {output_filepath}: {e}")
                ));
                return;
            }
        }

        self.as_mut().set_output_error(QString::from(""));
    }

    pub unsafe fn aes_random_key(self: Pin<&mut Self>, state: *const QtState) {
        let state_ref = unsafe { state.as_ref() }.expect("QtState pointer was null!");
        self.set_aes_key_text(generate_random_aes_key(state_ref));
    }

    pub unsafe fn aes_random_iv(self: Pin<&mut Self>, _state: *const QtState) {
        self.set_aes_iv_text(generate_random_aes_iv());
    }
}

/// The bridge definition for our QObject
#[cxx_qt::bridge]
pub mod qobject {
    unsafe extern "C++" {
        include!("cxx-qt-lib/qstring.h");
        /// An alias to the QString type
        type QString = cxx_qt_lib::QString;

        include!("src/cxxqt/cxxqt_state.cxxqt.h");
        #[namespace = "qt_state"] // Use the namespace defined in QtState
        type QtState = crate::cxxqt::cxxqt_state::qobject::QtState;
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
        #[qproperty(i32, output_type)]
        #[qproperty(QString, output_text)]
        #[qproperty(QString, output_filepath)]
        #[qproperty(QString, output_error)]
        // AES-x specific
        #[qproperty(i32, aes_key_type)]
        #[qproperty(QString, aes_key_text)]
        #[qproperty(QString, aes_key_filepath)]
        #[qproperty(i32, aes_iv_type)]
        #[qproperty(QString, aes_iv_text)]
        #[qproperty(QString, aes_iv_filepath)]
        #[namespace = "qt_encryption"]
        type QtEncryption = super::REncryption;

        #[qinvokable]
        #[cxx_name = "encrypt"]
        unsafe fn encrypt(self: Pin<&mut QtEncryption>, state: *const QtState);

        #[qinvokable]
        #[cxx_name = "aes_random_key"]
        unsafe fn aes_random_key(self: Pin<&mut QtEncryption>, state: *const QtState);

        #[qinvokable]
        #[cxx_name = "aes_random_iv"]
        unsafe fn aes_random_iv(self: Pin<&mut QtEncryption>, state: *const QtState);
    }
}