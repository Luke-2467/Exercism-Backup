use std::collections::BTreeMap;
pub struct School {
    grades: BTreeMap<u32, Vec<String>>,
    students: Vec<String>,
}

impl School {
    pub fn new() -> School {
        School {
            students: Vec::new(),
            grades: BTreeMap::new(),
        }
    }

    pub fn add(&mut self, grade: u32, student: &str) {
        if self.students.contains(&student.to_string()) {
            println!("{} is already a student here.", student);
        }
        else {
            let students = self.grades.entry(grade).or_default();
            students.push(student.to_string());
            students.sort();
            self.students.push(student.to_string());
        }
    }

    pub fn grades(&self) -> Vec<u32> {
        self.grades.keys().cloned().collect()
    }

    pub fn grade(&self, grade: u32) -> Vec<String> {
        self.grades
        .get(&grade)
        .cloned()
        .unwrap_or_else(Vec::new)
    }
}
