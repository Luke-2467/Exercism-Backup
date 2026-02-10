use std::collections::HashMap;

#[derive(Debug)]
pub enum Category {
    Ones,
    Twos,
    Threes,
    Fours,
    Fives,
    Sixes,
    FullHouse,
    FourOfAKind,
    LittleStraight,
    BigStraight,
    Choice,
    Yacht,
}

type Dice = [u8; 5];

pub fn full_house(frequencies: HashMap <u8,u8>) -> u8 {
    let mut freqs: Vec<u8> = frequencies.values().cloned().collect::<Vec<u8>>();
    freqs.sort();
    let mut result: u8 = 0;
    if freqs == [2, 3] {
        for num in frequencies.keys() {
            let Some(&freq) = frequencies.get(num) else { panic!{"Something has gone wrong"}; };
            result += num * freq;
        }
    }
    result
}

pub fn four_of_a_kind(frequencies: HashMap <u8,u8>) -> u8 {
    let mut freqs: Vec<u8> = frequencies.values().cloned().collect::<Vec<u8>>();
    freqs.sort();
    let mut result: u8 = 0;
    if freqs == [1, 4] || freqs == [5] {
        for num in frequencies.keys() {
            let Some(&freq) = frequencies.get(num) else { panic!{"Something has gone wrong"}; };
            if freq == 4 || freq == 5 {
                result += num * 4;
            }
        }
    }
    result
}

pub fn little_straight(frequencies: HashMap <u8,u8>) -> u8 {
    let mut rolls: Vec<u8> = frequencies.keys().cloned().collect::<Vec<u8>>();
    rolls.sort();
    let mut result: u8 = 0;
    if rolls == [1, 2, 3, 4, 5] {
        result = 30;
    }
    result
}

pub fn big_straight(frequencies: HashMap <u8,u8>) -> u8 {
    let mut rolls: Vec<u8> = frequencies.keys().cloned().collect::<Vec<u8>>();
    rolls.sort();
    let mut result: u8 = 0;
    if rolls == [2, 3, 4, 5, 6] {
        result = 30;
    }
    result
}

pub fn choice(frequencies: HashMap <u8,u8>) -> u8 {
    let mut result: u8 = 0;
    for num in frequencies.keys() {
        let Some(&freq) = frequencies.get(num) else { panic!{"Something has gone wrong"}; };
            result += num * freq;
    }
    result
}

pub fn yacht(frequencies: HashMap <u8,u8>) -> u8 {
    let freqs: Vec<u8> = frequencies.values().cloned().collect::<Vec<u8>>();
    let mut result: u8 = 0;
    if freqs == [5] {
        result = 50;
    }    
    result
}

pub fn score(dice: Dice, category: Category) -> u8 {
    let mut num_match: u8 = 0;
    let mut result: u8 = 0;
    match category {
        Category::Ones => num_match = 1,
        Category::Twos => num_match = 2, 
        Category::Threes => num_match = 3, 
        Category::Fours => num_match = 4, 
        Category::Fives => num_match = 5, 
        Category::Sixes => num_match = 6, 
        _ => (),
    }

    let frequencies = dice
          .iter()
          .copied()
          .fold(HashMap::new(), |mut map, val|{
              map.entry(val)
                 .and_modify(|frq|*frq+=1)
                 .or_insert(1);
              map
          });
    
    if let Some(&count) = frequencies.get(&num_match) {
        result += num_match * count;
    }
    match category {
        Category::FullHouse => result = full_house(frequencies),
        Category::FourOfAKind => result = four_of_a_kind(frequencies),
        Category::BigStraight => result = big_straight(frequencies),
        Category::LittleStraight => result = little_straight(frequencies),
        Category::Choice => result = choice(frequencies),
        Category::Yacht => result = yacht(frequencies),
        _ => (),
    }
    
    result
}
