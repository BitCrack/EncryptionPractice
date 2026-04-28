use std::pin::Pin;
use cxx_qt::CxxQtType;
use cxx_qt_lib::QString;
use rand::distr::Alphanumeric;
use rand::{rng, RngExt};
use crate::cxxqt::cxxqt_encryption::qobject;

pub mod cxxqt_state;
pub mod cxxqt_encryption;
pub mod cxxqt_decryption;

const AES_IV_LEN: usize = 16;
const AES_128_KEY_LEN: usize = 16;
const AES_192_KEY_LEN: usize = 24;
const AES_256_KEY_LEN: usize = 32;

fn generate_random_aes_key(state: &qobject::QtState) -> QString {
    let cipher_name = state.rust().cipher.to_string();

    let required_len = match cipher_name.as_str() {
        "aes128" => AES_128_KEY_LEN,
        "aes192" => AES_192_KEY_LEN,
        "aes256" => AES_256_KEY_LEN,
        _ => AES_128_KEY_LEN, // Fallback
    };

    let random_key: String = rng()
        .sample_iter(Alphanumeric)
        .take(required_len)
        .map(char::from)
        .collect();

    QString::from(&random_key)
}

fn generate_random_aes_iv() -> QString {
    let random_iv: String = rng()
        .sample_iter(Alphanumeric)
        .take(AES_IV_LEN)
        .map(char::from)
        .collect();

    QString::from(&random_iv)
}