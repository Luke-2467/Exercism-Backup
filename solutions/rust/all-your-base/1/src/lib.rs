#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit(u32),
}

pub fn convert(number: &[u32], from_base: u32, to_base: u32) -> Result<Vec<u32>, Error> {
    // Validate bases
    if from_base < 2 {
        return Err(Error::InvalidInputBase);
    }
    if to_base < 2 {
        return Err(Error::InvalidOutputBase);
    }

    // Trim leading zeros (but keep at least one zero if all digits are zero)
    let first_nonzero = number.iter().position(|&d| d != 0);
    let number = match first_nonzero {
        Some(idx) => &number[idx..],
        None => {
            // All zeros (or empty) -> represent zero in target base
            return Ok(vec![0]);
        }
    };

    // Validate digits
    for &d in number {
        if d >= from_base {
            return Err(Error::InvalidDigit(d));
        }
    }

    // Convert from base `from_base` to an integer (use u128 to avoid overflow for reasonable sizes)
    // value = (((d0)*from_base + d1)*from_base + d2)*... (Horner's method)
    let mut value: u128 = 0;
    let fb = from_base as u128;
    for &d in number {
        value = value
            .checked_mul(fb)
            .and_then(|v| v.checked_add(d as u128))
            .ok_or(Error::InvalidInputBase)?; // overflow safeguard; reuse an error variant
    }

    // Convert integer `value` to base `to_base`
    let tb = to_base as u128;
    let mut out: Vec<u32> = Vec::new();

    if value == 0 {
        return Ok(vec![0]);
    }

    let mut n = value;
    while n > 0 {
        let rem = (n % tb) as u32;
        out.push(rem);
        n /= tb;
    }

    // We collected least-significant digit first; reverse to get most-significant first
    out.reverse();
    Ok(out)
}