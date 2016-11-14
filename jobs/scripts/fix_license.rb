#!/usr/bin/env ruby

require 'fileutils'
ltext = IO.readlines('license.txt')

Dir['./**/*.m'].each do |f|
  #new = File.open("#{f}.new",'w')
  #code = IO.readlines(f)
  #new.puts ltext.to_s
  #new.puts code.to_s
  #FileUtils.mv("#{f}.new", f)
  system("cat license.txt > #{f}.new")
  system("cat #{f} >> #{f}.new")
  system("mv #{f}.new #{f}")
end
