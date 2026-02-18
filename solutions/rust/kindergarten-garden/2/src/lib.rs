use std::collections::HashMap;

fn letter_to_number(letter: char) -> Option<u8> {
    if letter.is_ascii_uppercase() {
        Some(letter as u8 - b'A' as u8)
    } else {
        None
    }
}

pub fn plants(diagram: &str, student: &str) -> Vec<&'static str> {
    let plants: HashMap<char, &str> = HashMap::from([
        ('G', "grass"),
        ('C', "clover"),
        ('R', "radishes"),
        ('V', "violets"),
    ]);
    
    let rows: Vec<&str> = diagram.split('\n').collect();
    
    let kid_number: Option<u8> = letter_to_number(student.chars().next().unwrap());

    let mut plants_result: Vec<&str> = Vec::new();

    for row in rows {
        let row_vec: Vec<char> = row.chars().collect();
        if let Some(kid_number_real) = kid_number {
            let kid_number_real_usize=usize::from(kid_number_real);
            for plant_num in (kid_number_real_usize*2)..=(kid_number_real_usize*2+1) {
                plants_result.push(plants.get(&row_vec[plant_num]).expect("No plant match, add plant to plants hashtable"));
            }
        }
    }

    plants_result
}
