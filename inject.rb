['a', 'b'].inject '' do |str, char|  # => ["a", "b"]
  str                                # => "", "a"
  char                               # => "a", "b"
  str + char                         # => "a", "ab"
end                                  # => "ab"


['blah', 'meh', 'futz'].inject '' do |memo, element|  # => ["blah", "meh", "futz"]
  memo                                                # => "", "blah", "blahmeh"
  element                                             # => "blah", "meh", "futz"
  memo + element                                      # => "blah", "blahmeh", "blahmehfutz"
end                                                   # => "blahmehfutz"



 # give it a symbol
[1, 2, 3].inject 0, :+ do |memo, element|  # => [1, 2, 3]
  memo
  element
  memo + element
end                                        # => 6
