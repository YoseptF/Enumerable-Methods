# frozen_string_literal: true

require 'io/console'
def continue_story
  print 'press any key to continue'
  STDIN.getch
  print "            \r"
end

class String
  def integer?
    to_i.to_s == self
  end
end

def multitply_els(arr)
  arr.my_inject { |total, num| total * num }
end

module Enumerable
  def my_each
    length.times do |item|
      yield(self[item])
    end
  end

  def my_each_with_index
    length.times do |item|
      yield(item, self[item])
    end
  end

  def my_select
    final_arr = []
    my_each do |item|
      final_arr << item if yield(item)
    end
    final_arr
  end

  def my_all?
    flag = true
    if block_given?
      my_each do |item|
        flag = false unless yield(item)
      end
    else
      my_each do |item|
        flag = false if item == false || item.nil?
      end
    end
    flag
  end

  def my_any?
    flag = false
    if block_given?
      my_each do |item|
        flag = true if yield(item)
      end
    else
      my_each do |item|
        flag = true unless item == false || item.nil?
      end
    end
    flag
  end

  def my_none?
    flag = true
    if block_given?
      my_each do |item|
        flag = false if yield(item)
      end
    else
      my_each do |item|
        flag = false if item == false || item.nil?
      end
    end
    flag
  end

  def my_count(num = nil)
    final_count = 0
    if block_given?
      my_each do |item|
        final_count += 1 if yield(item)
      end
    elsif num.nil?
      final_count = length
    else
      my_each do |item|
        final_count += 1 if item == num
      end
    end
    final_count
  end

  def my_map(one_proc = nil)
    new_arr = []
    if one_proc.nil?
      my_each do |item|
        new_arr.push << yield(item)
      end
    else
      my_each do |item|
        new_arr.push << one_proc.call(item)
      end
    end
    new_arr
  end

  def my_inject(initial = nil)
    if initial.nil?
      total = self[0]
      1.upto(length - 1) do |num|
        total = yield(total, self[num])
      end
    else
      total = initial
      0.upto(length - 1) do |num|
        total = yield(total, self[num])
      end
    end
    total
  end
end

puts 'Hello, type your array '
print '(use space to separate items ex.: 1 2 3 4 5 6)'

the_array = gets.chomp.split(' ').map { |data| data.integer? ? data.to_i : data }
option = -1

puts `clear`
puts the_array

while option != 'e'
  puts 'Now select an operation from the list:'
  puts '[1] my_each'
  puts '[2] my_each_with_index'
  puts '[3] my_select'
  puts '[4] my_all?'
  puts '[5] my_any?'
  puts '[6] my_none?'
  puts '[7] my_count'
  puts '[8] my_map'
  puts '[9] my_inject'
  puts '[0] multiply_els'
  puts '[e] exit'
  option = gets.chomp

  puts `clear`

  case option
  when '1'
    the_array.my_each do |value|
      puts "value: #{value}"
    end
  when '2'
    the_array.my_each_with_index do |index, value|
      puts "index: #{index} value: #{value}"
    end
  when '3'
    puts the_array.my_select(&:even?)
  when '4'
    puts(the_array.my_all? { |num| num < 45 })
  when '5'
    puts(the_array.my_any?)
  when '6'
    puts(the_array.my_none? { |num| num == 7 })
  when '7'
    puts the_array.my_count(2)
  when '8'
    my_proc = proc { |num| num * 2 }
    puts(the_array.my_map(my_proc))
  when '9'
    puts(the_array.my_inject { |total, num| total + num })
  when '0'
    puts multitply_els(the_array)
  when 'e'
    puts 'Goodbye'
  when 'E'
    puts 'Goodbye'
  else
    puts 'wrong input'
  end

  continue_story
  puts `clear`

end
