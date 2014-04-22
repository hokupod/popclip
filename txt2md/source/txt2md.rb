#!/usr/bin/ruby
# -*- coding: utf-8 -*-

$KCODE = 'u'

def two_byte_encode(utf_8_mac_text)
  utf_8_mac_text.gsub("\u309B", "\u3099").gsub("\u309C", "\u309A")
  .encode("UTF-8", "UTF-8-MAC")
end

text_in = ENV['POPCLIP_TEXT'].to_s
text_in = text_in.split("\n")
indent = /\t|\s{4}/
heading_prefix = /^#.*/
list_prefix = /^-\s/
write_text = Array.new

before_count = 0
before_text = ""
i = 0

text_in.reverse_each do |paragraph|
  count = paragraph.scan(indent).size
  heading_check = before_text.scan(heading_prefix).size
  list_check = before_text.scan(list_prefix).size

  text = two_byte_encode(paragraph.gsub(indent, ""))
  title = text + "\n========\n"
  heading = "#" * (count + 1) + " " + text
  list1 = "- " + text + "\n\n"
  list2 = "- " + text

  if count == 0
    write_text[i] = title
  elsif before_count < count && list_check == 0
    write_text[i] = list1
  elsif before_count <= count && list_check != 0 && heading_check == 0
    write_text[i] = list2
  else
    write_text[i] = heading
  end

  before_count = count
  before_text = write_text[i]
  i += 1
end

write_text.reverse_each do |md|
  puts md
end
