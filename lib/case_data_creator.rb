#!/usr/bin/env ruby
require 'open-uri'

#downloads the latest UnicodeData.txt file, and then spits out
#codepoint, lowercase, uppercase
#for codepoiunts that have lowercase or uppercase versions
out = File.open("case_data.dat", "w")
open('http://unicode.org/Public/UNIDATA/UnicodeData.txt') do |f|
  f.each_line do |line|
    parts = line.chomp!.split(';')
    cp = parts[0]
    lc = parts[13]
    uc = parts[12]
    if lc || uc
      out.puts [cp, lc || "", uc || ""].join("\t")
    end
  end
end
out.close
