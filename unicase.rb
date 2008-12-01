# encoding: utf-8
module Unicode
  Uppercase = Hash.new { |h,k| k}
  Lowercase = Hash.new { |h,k| k}
  def self.to_u(x)
    [x.to_i(16)].pack("U").freeze 
  end
  
  File.open(File.join(File.dirname(__FILE__), "case_data.dat")) do |f|
    f.each do |line|
      parts = line.chomp!.split("\t")
      cp = parts[0]
      lc = parts[1]
      uc = parts[2]

      char = Unicode::to_u(cp)
      Lowercase[char] = Unicode::to_u(lc) if lc
      Uppercase[char] = Unicode::to_u(uc) if uc
    end
  end
end

class String
#  def each_char
#    if block_given?
#      self.scan(/./um) do |x|
#        yield x
#      end
#    else
#      yield x
#    end
#  end
  
  def first_unicode_capitalize
    if self =~ /\A(.)/um
      Unicode::Uppercase[$1] + $'
    else
      self.dup
    end
  end
  
  def first_unicode_lowercase
    if self =~ /\A(.)/um
      Unicode::Lowercase[$1] + $'
    else
      self.dup
    end
  end

  def unicode_lowercase
    res = ""
    each_char { |x| res << Unicode::Lowercase[x] }
    res
  end
  def unicode_uppercase
    res = ""
    each_char { |x| res << Unicode::Uppercase[x] }
    res
  end
end
