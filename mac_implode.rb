#!/usr/bin/env ruby

require 'pathname'

puts "Are you sure??? (y/n)"
answer = gets.chomp
abort unless answer == 'y'

def home_filepath(file)
  Pathname(File.join(Dir.home, file))
end

def code_filepath(file)
  Pathname(File.join(Dir.home, 'code', file))
end

`rm -rf #{home_filepath('.ssh')}`
`rm -rf #{code_filepath('dotfiles')}`

