use rand::Rng;
use std::collections::HashSet;
use std::{cell::RefCell, rc::Rc};

pub struct RobotFactory {
    used_names: Rc<RefCell<HashSet<String>>>,
}

pub struct Robot {
    name: String,
    used_names: Rc<RefCell<HashSet<String>>>,
}

impl RobotFactory {
    pub fn new() -> Self {
        Self {
            used_names: Rc::new(RefCell::new(HashSet::new())),
        }
    }

    pub fn new_robot<R: Rng>(&mut self, rng: &mut R) -> Robot {
        let mut name = random_name(rng);

        while self.used_names.borrow_mut().contains(&name) {
            name = random_name(rng);
        }

        self.used_names.borrow_mut().insert(name.clone());
            
        Robot {
            name,
            used_names: self.used_names.clone(),
        }
    }

}

impl Robot{
    /// Return a reference to the robot's name.
    pub fn name(&self) -> &str {
        &self.name
    }

    /// Assign a new unique name to the robot (different from the previous one).
    pub fn reset<R: Rng>(&mut self, rng: &mut R) {
        let old_name = self.name.clone();
        let mut new_name = random_name(rng);
        
        while self.used_names.borrow_mut().contains(&new_name) {
            new_name = random_name(rng);
        }
        
        self.used_names.borrow_mut().remove(&old_name);
        
        self.used_names.borrow_mut().insert(new_name.clone());

        self.name=new_name;
    }
}

/// Generate two uppercase ASCII letters followed by three digits.
fn random_name<R: Rng>(rng: &mut R) -> String {
    let mut name = String::with_capacity(5);
    name.push(rng.random_range(b'A'..=b'Z') as char);
    name.push(rng.random_range(b'A'..=b'Z') as char);

    let number: u16 = rng.random_range(0..=999);
    name.push_str(&format!("{:03}", number));
    name
}