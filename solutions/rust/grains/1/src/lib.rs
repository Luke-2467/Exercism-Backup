pub fn square(s: u32) -> u128 {
    if s > 64 {
        panic!("There are only 64 squares on a chess board.")
    }
    const MULTIPLY: u128 = 2;
    MULTIPLY.pow( s - 1 ) as u128
}

pub fn total() -> u128 {
    const SQUARES: u32 = 64;
    const MULTIPLY: u128 = 2;
    ( square( SQUARES ) * 2 - 1 )/( MULTIPLY - 1 )
}
