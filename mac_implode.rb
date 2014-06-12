#!/usr/bin/env ruby

require 'pathname'

require './file_helpers'

puts "Are you sure??? (y/n)"
answer = gets.chomp
abort unless answer == 'y'

`rcdn`
`rm -rf #{ssh_dir}`
`rm -rf #{personal_code_path}`
`rm -rf #{thoughtbot_code_path}`
