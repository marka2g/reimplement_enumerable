RSpec.describe "My Enumerable" do
  specify "#to_a returns an array of the items iterated over"
  specify "#count returns how many items are in the enumerable"
  specify "#find|#detect returns the first item where the block returns true"
  specify "#find_all returns all items where the block returns true"
  specify "#map|#collect returns an array of elements that have been operated on in the block"
  specify "#inject|#reduce passes an aggregate value through the block"
  specify "#group_by returns a hash whos keys come from the block and whos values are the elements we passed to the block, in an array"
  specify "#first returns the first item in the collection"
  specify "#all? returns true if the block returns true for each item in the array"
  specify "#any? returns true if the block returns true for any item in the array"
  specify "#none? returns false if the block returns true for each item in the array"
  specify "#min returns the smallest item in the collection"
  specify "#max returns the largest item in the collection"
  specify "#min_by returns the smallest element, compared by the return values from block"
  specify "#max_by returns the largest element, compared by the return values from block"
  specify "#include? returns true if the item is in the collection"
  specify "#each_with_index hands the block each item from the collection, and also the index starting at zero"
  specify "#each_with_object hands the block each item and an object and it returns the object"
  specify "#take returns first n items"
  specify "#drop returns whatever items wouldn\'t get taken by take"
end



__END__
# maybes
#=> :to_h,
#=> :zip",
#=> :sort,
#=> :sort_by,
#=> :grep,
#=> :entries,
#=> :flat_map,
#=> :collect_concat,
#=> :select,
#=> :reject,
#=> :partition,
#=> :one?,
#=> :reverse_each,
#=> :minmax,
#=> :minmax_by,
#=> :member?,
#=> :cycle,
#=> :chunk,
#=> :slice_before,
#=> :slice_after,
#=> :slice_when,
#=> :lazy
#=> :drop_while,
#=> :take_while,
#=> :each_entry,
#=> :each_slice,
#=> :each_cons,
