require "pry"

module MyEnumerable
  def to_a
    array = []
    each {|element| array << element}
    array
  end

  def count(&block)
    block ||= Proc.new {true}
    count = 0
    each {|element| count += 1 if block.call(element)}
    count
  end

  def find(&block)
    each {|element| return element if block.call element}
    nil
  end

  def find_all(&block)
    found = []
    each { |el| found << el if block.call el }
    found
  end

  def map(&block)
    mapped = []
    each { |el| mapped << block.call(el) }
    mapped
  end

  def inject(aggregate, symbol = nil, &block)
    block = (symbol || block).to_proc
    each { |el| aggregate = block.call(aggregate, el)}
    aggregate
  end

  def group_by(&block)
    grouped = {}
    each do |el|
      key = block.call(el)
      grouped[key] = [] unless grouped.key? key
      grouped[key] << el
    end
    grouped
  end

  def each_with_object(object, &block)
    each { |el| block.call el, object }
    object
  end
end

RSpec.describe "My Enumerable" do
  class MyArray

    include MyEnumerable
    # include Enumerable

    def initialize(array)
      @array = array
    end

    def each(&block)
      @array.each(&block)
    end
  end

  def assert_enum(array, method_name, *args, expected, &block)
    actual = MyArray.new(array).__send__(method_name, *args, &block)
    expect(actual).to eq(expected)
  end

  # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-to_a
  specify "#to_a returns an array of the items iterated over" do
    assert_enum [1, 2, 2], :to_a, [1,2,2]
  end

  # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-count
  describe "#count" do
    specify "returns how many items the block returns true for the enumerable" do
      assert_enum([],     :count, 0) {true}
      assert_enum([1, 2], :count, 2) {true}
      assert_enum([1, 2], :count, 1) {|el| el > 1}
    end
    specify "returns how many items in the array if there is no block" do
      assert_enum [],     :count, 0
      assert_enum [1],    :count, 1
      assert_enum [1, 2], :count, 2
    end
  end

  # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-find
  specify "#find|#detect returns the first item where the block returns true" do
    assert_enum([],                   :find,    nil) { true }
    assert_enum([1, 2],               :find,      1) { true }
    assert_enum(['a', 'bcd', 'a'],    :find,  'bcd') { |str| str.length == 3 }
    assert_enum([1, 2],               :find,    nil) { false }
  end

  # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-find_all
  specify "#find_all|#reject returns all items where the block returns true" do
    ary = [1,2,3,4,5,6]
    assert_enum(ary, :find_all, ary) { true }
    assert_enum(ary, :find_all, []) { false }
    assert_enum(ary, :find_all, [1, 2, 3]) { |element| element < 4 }
    assert_enum(ary, :find_all, [1, 3, 5]) { |element| element.odd? }
    assert_enum(ary, :find_all, [2, 4, 6]) { |element| element.even? }
  end

  # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-map
  specify "#map|#collect returns an array of els that have been operated on in the block" do
    assert_enum([],               :map, []) { 1 }
    assert_enum(['a', 'b'],       :map, [1, 1]) { 1 }
    assert_enum(['a', 'b', 'c'],  :map, ['A', 'B', 'C']) { |char| char.upcase }
  end

  # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-inject
  describe "#inject|#reduce" do
    it "passes an aggregate value through the block" do
      assert_enum([],               :inject, 0, 0)      { |sum, num| sum + num}
      assert_enum([5, 8],           :inject, 0, 13)     { |sum, num| sum + num}
      assert_enum([5, 8],           :inject, 1, 14)     { |sum, num| sum + num}
      assert_enum(['a', 'b'],       :inject, '', 'ab')  { |str, chr| str + chr}
    end

    it "can take a symbol and call method of that name in place of the block" do
      assert_enum([],               :inject, 0,   :+, 0)
      assert_enum([5, 8],           :inject, 0,   :+, 13)
      assert_enum([5, 8],           :inject, 1,   :+, 14)
      assert_enum(['a', 'b'],       :inject, '',  :+, 'ab')
    end

    it "prefers a symbol to a block" do
      assert_enum([5, 8],           :inject, 1,   :+, 14) {|product, num| product * num}
    end
  end

  # # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-group_by
  specify "#group_by returns a hash wh keys come from block and whos values are the elements passed to the block, in an array" do
    assert_enum([*1..5], :group_by, {true => [1,3,5], false => [2, 4]}) {|el| el.odd?}
    assert_enum(['abc', 'lo', 'lol', 'lkjs'], :group_by, {3 => ['abc', 'lol'], 2 => ['lo'], 4 => ['lkjs']}) {|el| el.length}
  end

  # # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-first
  # specify "#first returns the first item in the collection" do
  # end

  # # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-all-3F
  # specify "#all? returns true if the block returns true for each item in the array" do
  # end

  # # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-any-3F
  # specify "#any? returns true if the block returns true for any item in the array" do
  # end

  # # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-none-3F
  # specify "#none? returns false if the block returns true for each item in the array" do
  # end

  # # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-min
  # specify "#min returns the smallest item in the collection" do
  # end

  # # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-max
  # specify "#max returns the largest item in the collection" do
  # end

  # # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-min_by
  # specify "#min_by returns the smallest element, compared by the return values from block" do
  # end

  # # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-max_by
  # specify "#max_by returns the largest element, compared by the return values from block" do
  # end

  # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-include-3F
  # specify "#include? returns true if the item is in the collection" do
  # end

  # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-each_with_index
  # specify "#each_with_index hands the block each item from the collection, and also the index starting at zero" do
  # end

  # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-each_with_object
  # this one next because we may be able to refactor with it
    # evens = (1..10).each_with_object([]) { |i, a| a << i*2 }
    # => [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
  specify "#each_with_object hands the block each item of an object and it returns the object" do
    assert_enum([], :each_with_object, '', '') {}
    assert_enum(['a', 'b'], :each_with_object, '', 'ab') do |char, string|
      string << char
      nil
    end
  end

  # # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-take
  # specify "#take returns first n items" do
  # end

  # # http://Marks-MacBook-Pro.local:62485/Dash/eowyzggm/Enumerable.html#method-i-drop
  # specify "#drop returns whatever items wouldn\'t get taken by take" do
  # end
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
