// Task:
// Develop a function that is going to calculate Pedersen hash of an array of felts.
// Cairo's built in hash2 can calculate Pedersen hash on two field elements.
// To calculate hash of an array use hash chain algorith where hash of [1, 2, 3, 4] is is H(H(H(1, 2), 3), 4).

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.hash import hash2

func hash_recur{hash_ptr: HashBuiltin*}(items_left: felt, curr_item_ptr: felt*) -> (res: felt) {
  let curr_item = [curr_item_ptr];
  if (items_left == 2) {
    let last_item = [curr_item_ptr - 1];
    let (hash) = hash2{hash_ptr=hash_ptr}(last_item, curr_item);
    return (res=hash);
  }

  let (next_item_hash) = hash_recur(items_left=items_left-1, curr_item_ptr=curr_item_ptr - 1);
  let (hash) = hash2{hash_ptr=hash_ptr}(next_item_hash, curr_item);

  return (res=hash);
}

// Computes the Pedersen hash chain on an array of size `arr_len` starting from `arr_ptr`.
func hash_chain{hash_ptr: HashBuiltin*}(arr_ptr: felt*, arr_len: felt) -> (result: felt) {
    let (res) = hash_recur{hash_ptr=hash_ptr}(items_left=arr_len, curr_item_ptr=arr_ptr + arr_len - 1);
    return (result=res);
}
