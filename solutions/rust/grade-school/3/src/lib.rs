use std::collections::{BTreeMap, HashSet};

pub struct School {
    grades: BTreeMap<u32, Vec<String>>,
    students: HashSet<String>,
}

impl School {
    pub fn new() -> School {
        School {
            students: HashSet::new(),
            grades: BTreeMap::new(),
        }
    }

    pub fn add(&mut self, grade: u32, student: &str) {
        let student_string = student.clone().to_string();
        
        if self.students.contains(&student_string) {
            println!("{} is already a student here.", student);
        }
        else {
            let students = self.grades.entry(grade).or_default();
            students.push(student_string.clone());
            self.students.insert(student_string.clone());
        }
    }

    pub fn grades(&self) -> Vec<u32> {
        self.grades.keys().cloned().collect()
    }

    pub fn grade(&self, grade: u32) -> Vec<String> {
        let mut grade_list = self.grades
        .get(&grade)
        .cloned()
        .unwrap_or_else(Vec::new);

        grade_list.sort();

        grade_list
    }
}
