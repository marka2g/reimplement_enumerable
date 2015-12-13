# a method is code thats waiting to be executed & it takes an argument
def a(b)
  b.upcase  # => "YO"
end
a "yo"      # => "YO"

# the equiv of this in terms of a block would be a local variable
# u can get an object that wraps the block using lambda
c = lambda {|d| d.upcase}  # => #<Proc:0x007fdc2405da40@/Users/marksadegi/dropbox/Education/ComputerScience/Ruby/blocks_enumerable/reimplement_enumerable/how_blocks_work.rb:9 (lambda)>
c.call "yo"                # => "YO"

# better
e = lambda do |f|
  f                # => "yo"
  .upcase          # => "YO"
end                # => #<Proc:0x007fdc2405d838@/Users/marksadegi/dropbox/Education/ComputerScience/Ruby/blocks_enumerable/reimplement_enumerable/how_blocks_work.rb:13 (lambda)>
e.call "yo"        # => "YO"

# second difference between a block and a method
  # a block is able to see vaiables in the environment around it

string = "meh"       # => "meh"
# this won't work
def g(h)
  h.upcase + string
end
g "blah"

string = " meh"      # => " meh"
i = lambda do |j|
  j.upcase + string  # => "BLAH meh"
end                  # => #<Proc:0x007fd82c023198@/Users/marksadegi/dropbox/Education/ComputerScience/Ruby/blocks_enumerable/reimplement_enumerable/how_blocks_work.rb:30 (lambda)>
i.call("blah")       # => "BLAH meh"


# another thing in blocks is they'll have a binding that executes inside of them. so...
  # they will have a local variable, they're gonna have a self, and
# block will retain its own self of the CALLING ENVIRONMENT
class K
  def call_method
    self             # => #<K:0x007f94d490a0b8>
    l "hello"        # => "HELLO"
  end
  def call_block(m)
    m.call("hello")  # => "HELLO"
  end
end

def l(m)
  self      # => #<K:0x007f94d490a0b8>
  m.upcase  # => "HELLO"
end

K.new.call_method  # => "HELLO"

l = lambda do |m|
  self               # => main - main is the DEFININING ENVIRONMENT
  m.upcase           # => "HELLO"
end                  # => #<Proc:0x007f94d4909b90@/Users/marksadegi/dropbox/Education/ComputerScience/Ruby/blocks_enumerable/reimplement_enumerable/how_blocks_work.rb:56 (lambda)>
K.new.call_block(l)  # => "HELLO"


# lambda is a method just like each
lambda do |element|
  element + 1
end

[1].each do |element|
  element + 1
end


# implement our own each
def my_each(ary, &block)
  ary.length.times do |i|  # => 5
    element = ary[i]       # => 9, 3, 5, 2, 8
    block.call(element)    # => 10, 4, 6, 3, 9
  end                      # => 5
end

# block = lambda do |element|
#   element + 1                # => 2, 3, 4, 5, 6
# end                          # => #<Proc:0x007f972a88e280@/Users/marksadegi/dropbox/Education/ComputerScience/Ruby/blocks_enumerable/reimplement_enumerable/how_blocks_work.rb:81 (lambda)>
my_each [9,3,5,2,8] do |element|
  element + 1                     # => 10, 4, 6, 3, 9
end                               # => 5
