use std::ops::Rem;

pub struct Matcher<T> {
    pred: Box<dyn Fn(T) -> bool>,
    subs: String,
}

impl<T> Matcher<T> {
    pub fn new<F, S>(matcher: F, subs: S) -> Matcher<T>
    where
        F: Fn(T) -> bool + 'static,
        S: ToString,
    {
        Matcher { pred: Box::new(matcher), subs: subs.to_string() }
    }
}


/// A Fizzy is a set of matchers, which may be applied to an iterator.
pub struct Fizzy<T> {
    matchers: Vec<Matcher<T>>,
}

impl<T> Fizzy<T> {
    pub fn new() -> Self {
        Self {
            matchers: Vec::new(),
        }
    }

    // builder-style: consume self and return updated self
    #[must_use]
    pub fn add_matcher(mut self, _matcher: Matcher<T>) -> Self {
        self.matchers.push(_matcher);
        self
    }

    /// map this fizzy onto every element of an iterator, returning a new iterator
    pub fn apply<I>(self, _iter: I) -> impl Iterator<Item = String>
    where
        I: IntoIterator<Item = T>,
        T: Clone + ToString,
    {
        let matchers = self.matchers;
        _iter.into_iter().map(move |item| {
            let mut out = String::new();
            for m in &matchers {
                if (m.pred)(item.clone()) {
                    out.push_str(&m.subs);
                }
            }
            if out.is_empty() {
                item.to_string()
            } else {
                out
            }
            })
    }
}

/// convenience function: return a Fizzy which applies the standard fizz-buzz rules
pub fn fizz_buzz<T>() -> Fizzy<T>
where
    T: Clone + Rem<Output = T> + PartialEq + From<u8> + ToString + 'static,
{
    Fizzy::new()
        .add_matcher(Matcher::new(
            |x: T| x.clone() % T::from(3u8) == T::from(0u8),
            "fizz",
        ))
        .add_matcher(Matcher::new(
            |x: T| x.clone() % T::from(5u8) == T::from(0u8),
            "buzz",
        ))
}