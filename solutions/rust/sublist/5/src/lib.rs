#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sub_or_super_check(first_list: &[i32], second_list: &[i32]) -> bool {
    if first_list.is_empty() {
        return true;
    }

    let first_element=first_list[0];
    
    for second_list_index in 0..second_list.len() {
        if second_list[second_list_index] == first_element && second_list[second_list_index..second_list_index+first_list.len()] == first_list[0..] {
            return true;            
        }
    }
     
    false
}

pub fn equal_list_check(first_list: &[i32], second_list: &[i32]) -> Comparison {
    if first_list == second_list {
     return Comparison::Equal;
    }
    
    Comparison::Unequal
}

pub fn sublist(first_list: &[i32], second_list: &[i32]) -> Comparison {
    if first_list.len() == second_list.len() {
        equal_list_check(first_list, second_list)
    }
    else if first_list.len() < second_list.len() && sub_or_super_check(first_list, second_list) {
        Comparison::Sublist
    }
    else if first_list.len() > second_list.len() && sub_or_super_check(second_list, first_list) {
        Comparison::Superlist
    }
    else {
        Comparison::Unequal
    }
}
