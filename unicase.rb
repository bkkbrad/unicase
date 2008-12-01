# encoding: utf-8
module Unicase
  Uppercase = Hash.new { |h,k| k}
  Lowercase = Hash.new { |h,k| k}
  def self.to_u(x)
    [x.to_i(16)].pack("U").freeze 
  end
  
  File.open(File.join(File.dirname(__FILE__), "case_data.dat")) do |f|
    f.each do |line|
      parts = line.chomp!.split("\t")
      cp = parts[0]
      lc = parts[1] || ""
      uc = parts[2] || "" 
      char = Unicase::to_u(cp)
      Lowercase[char] = Unicase::to_u(lc) if lc != ""
      Uppercase[char] = Unicase::to_u(uc) if uc != ""
    end
  end
end

class String
  def first_unicode_capitalize
    if self =~ /\A(.)/um
      Unicase::Uppercase[$1] + $'
    else
      self.dup
    end
  end
  
  def first_unicode_lowercase
    if self =~ /\A(.)/um
      Unicase::Lowercase[$1] + $'
    else
      self.dup
    end
  end

  def unicode_lowercase
    res = ""
    each_char { |x| res << Unicase::Lowercase[x] }
    res
  end
  def unicode_uppercase
    res = ""
    each_char { |x| res << Unicase::Uppercase[x] }
    res
  end
end
