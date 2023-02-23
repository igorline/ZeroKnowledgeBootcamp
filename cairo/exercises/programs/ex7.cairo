%lang starknet
from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import unsigned_div_rem

// Using binary operations return:
// - 1 when pattern of bits is 01010101 from LSB up to MSB 1, but accounts for trailing zeros
// - 0 otherwise

// 000000101010101 PASS
// 010101010101011 FAIL

func pattern{bitwise_ptr: BitwiseBuiltin*, range_check_ptr}(
    n: felt, idx: felt, exp: felt, broken_chain: felt
) -> (true: felt) {
    // 1. find floor n div 2
    let (half, q) = unsigned_div_rem(value=n, div=2);
    // 2. res + n
    let sum = half + n;
    // 3. res + n + 1
    let next = sum + 1;
    // 4. xor (res + n + 1, res + n)
    let (xor) = bitwise_and(sum, next);
    if (xor == 0) {
      return (1,);
    }
    return (0,);
}
