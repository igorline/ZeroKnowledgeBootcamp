from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.cairo.common.math import unsigned_div_rem


func get_num_to_sum{bitwise_ptr: BitwiseBuiltin*}(item: felt) -> (res: felt) {
  let (bit) = bitwise_and(item, 1);
  if (bit == 0) {
    return (res = item);
  }
  return (res = 0);
}

func next_item{bitwise_ptr: BitwiseBuiltin*}(len_left: felt, pos: felt*) -> (sum: felt) {
  alloc_locals;
  let item = [pos];
  let (to_add) = get_num_to_sum(item);
  if (len_left == 1) {
    return (sum = to_add);
  } else {
    let (sum) = next_item(len_left = len_left - 1, pos = pos + 1);
    return (sum = to_add + sum);
  }
}

// Implement a function that sums even numbers from the provided array
func sum_even{bitwise_ptr: BitwiseBuiltin*}(arr_len: felt, arr: felt*, run: felt, idx: felt) -> (
    sum: felt
) {
    let (sum) = next_item(len_left=arr_len, pos=arr);
    return (sum,);
}
