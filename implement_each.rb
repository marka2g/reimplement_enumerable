require 'seeing_is_believing'  # => true
# * Every Enumerable makes only one assumption on the collection being operated on, that is:
#  The collection MUST implement the each method
# iow - if i have a class and i want to include Enumerable, that class much implement the each method
# class Blab
#   include Enumerable           # => Blab
# end
#
# Blab.new.map {|i| i + 1} #no good, there is no each on Blab ~> undefined method `each' for #<Blab:0x007fd775389830>

class Blab
  include Enumerable  # => Blab
  def each(&block)
    block.call(5)     # => nil
    block.call(476)   # => nil
  end
end

Blab.new.map {|i| i + 1}  # => [6, 477]
