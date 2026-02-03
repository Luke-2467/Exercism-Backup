use std::cmp;

#[derive(Debug)]
pub struct HighScores {
    scores: Vec<u32>,
}

impl HighScores {
    pub fn new(scores: &[u32]) -> Self {
        Self {
            scores: scores.to_vec(),
        }
    }

    pub fn scores(&self) -> &[u32] {
        &self.scores
    }

    pub fn latest(&self) -> Option<u32> {
        self.scores.last().copied()
    }

    pub fn personal_best(&self) -> Option<u32> {
        self.scores.iter().max().copied()
    }

    pub fn personal_top_three(&self) -> Vec<u32> {
        let mut result: Vec<u32> = vec![0; 3];
        for score in self.scores.iter() {
            if score >= &result[0] {
                result[2]=result[1];
                result[1]=result[0];
                result[0]= *score;
            }
            else if score >= &result[1] {
                result[2]=result[1];
                result[1]= *score;
            }
            else if score >= &result[2] {
                result[2]= *score;
            }
    }
    (result[0..cmp::min(self.scores.len(),3)]).to_vec()
}
}
