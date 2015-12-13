:*.to_proc.call(3, 6)              # => 18
"a.b.c".split(".")                 # => ["a", "b", "c"]
:split.to_proc.call("a.b.c", ".")  # => ["a", "b", "c"]


sym = :+                        # => :+
proc = lambda do |this, *args|
  this.__send__(sym, *args)     # => 3
end                             # => #<Proc:0x007f8e73852880@/blocks_enumerable/reimplement_enumerable/symbol_to_proc.rb:7 (lambda)>

proc.call(1, 2)  # => 3
