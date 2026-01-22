pub fn square_of_sum(n: u32) -> u32 {
    let mut result=0;
    for number in 1..=n {
        result+=number;
    }
    result*result
}

pub fn sum_of_squares(n: u32) -> u32 {
    let mut result=0;
    for number in 1..=n {
        result+=number*number;
    }
    result
}    

pub fn difference(n: u32) -> u32 {
    let result=sum_of_squares(n) as i32 -square_of_sum(n) as i32;
    result.abs() as u32
}
