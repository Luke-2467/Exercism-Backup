use rand::Rng;
use std::cell::RefCell;
use std::collections::HashSet;
use std::rc::Rc;

/// Total size of the name space: 26 letters * 26 letters * 1000 numbers.
const NAME_SPACE: usize = 26 * 26 * 1000;

/// A `RobotFactory` is responsible for ensuring that all robots produced by
/// it have a unique name. Robots from different factories can have the same
/// name.
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

    /// Create a new robot with a unique name.
    pub fn new_robot<R: Rng>(&mut self, rng: &mut R) -> Robot {
        let name = Self::next_unique_name(&self.used_names, rng);
        Robot {
            name,
            used_names: Rc::clone(&self.used_names),
        }
    }

    /// Generates and reserves a unique name in `used_names`.
    fn next_unique_name<R: Rng>(used_names: &Rc<RefCell<HashSet<String>>>, rng: &mut R) -> String {
        let mut used = used_names.borrow_mut();

        if used.len() == NAME_SPACE {
            // If this triggers, the factory exhausted the entire namespace.
            panic!("RobotFactory name space exhausted");
        }

        loop {
            let candidate = random_name(rng);
            if used.insert(candidate.clone()) {
                return candidate;
            }
            // Collision: try again.
        }
    }
}

impl Robot {
    /// Return a reference to the robot's name.
    pub fn name(&self) -> &str {
        &self.name
    }

    /// Assign a new unique name to the robot (different from the previous one).
    pub fn reset<R: Rng>(&mut self, rng: &mut R) {
        let old_name = self.name.clone();
        let mut used = self.used_names.borrow_mut();

        // Free the current name so it can be used by other robots later.
        used.remove(&old_name);

        // There must be at least one available name now (since we removed one),
        // but we still loop until we pick a name that's unique and != old_name.
        loop {
            let candidate = random_name(rng);
            if candidate != old_name && used.insert(candidate.clone()) {
                self.name = candidate;
                break;
            }
        }
    }
}

/// Generate two uppercase ASCII letters followed by three digits.
fn random_name<R: Rng>(rng: &mut R) -> String {
    let mut name = String::with_capacity(5);
    name.push(rng.gen_range(b'A'..=b'Z') as char);
    name.push(rng.gen_range(b'A'..=b'Z') as char);

    let number: u16 = rng.gen_range(0..=999);
    name.push_str(&format!("{:03}", number));
    name
}