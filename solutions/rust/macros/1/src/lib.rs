#[macro_export]
macro_rules! hashmap {
    () => {
        ::std::collections::HashMap::new()
    };
    
    ( $( $key:expr => $value:expr ),+ $(,)? ) => {
    { 
        let mut temp_hash = ::std::collections::HashMap::new();
            $(
                temp_hash.insert(
                $key,
                $value,
                );
            )*
            temp_hash
    }
    };
}

/// This module contains doctests, which allows writing tests where a code
/// snippet is supposed to fail to compile. These tests also have "ignore"
/// attributes, makes sure to remove them when solving this exercise locally.
pub mod compile_fail_tests;
