pub fn square_of_sum(n: u32) -> u32 {
    (n*(n+1)/2)*(n*(n+1)/2)
}

pub fn sum_of_squares(n: u32) -> u32 {
    n*(n+1)*(2*n+1)/6
}    

pub fn difference(n: i32) -> u32 {
    let result= (n*(n+1)/2)*(n*(n+1)/2) - n*(n+1)*(2*n+1)/6;
    result.unsigned_abs()
}
