#!/usr/bin/ruby
# -*- coding: utf-8 -*-

$KCODE = 'u'

def two_byte_encord(utf_8_mac_text)
  utf_8_mac_text.gsub("\u309B", "\u3099").gsub("\u309C", "\u309A")
  .encode("UTF-8", "UTF-8-MAC")
end

text_in = ENV['POPCLIP_TEXT'].to_s
text_in = text_in.split("\n")
prefix = /^((((#+?|\s*?(-|\*))\s)|\s{4}).+|.+\s{2})?$/

text_in.each do |paragraph|
  unless prefix =~ paragraph
    puts two_byte_encord(paragraph) + "  "
  else
    puts two_byte_encord(paragraph)
  end
end