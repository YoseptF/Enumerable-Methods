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
    return to_enum(:my_each) unless block_given?

    real_array = to_a

    real_array.length.times do |item|
      yield(real_array[item])
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    real_array = to_a

    real_array.times do |item|
      yield(item, real_array[item])
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    final_arr = []
    my_each do |item|
      final_arr << item if yield(item)
    end
    final_arr
  end

  def my_all?(condition = nil)
    flag = true
    if !condition.nil?
      if (condition.instance_of? Integer) || (condition.instance_of? String) || (condition.instance_of? Regexp)
        my_each do |item|
          flag = false unless item == condition
        end
      else
        my_each do |item|
          flag = false unless item.is_a? condition
        end
      end
    elsif block_given?
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

  def my_any?(condition = nil)
    flag = false
    if !condition.nil?
      if (condition.instance_of? Integer) || (condition.instance_of? String)
        my_each do |item|
          flag = true if item == condition
        end
      else
        my_each do |item|
          flag = true if item.is_a? condition
        end
      end
    elsif block_given?
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

  def my_none?(condition = nil)
    flag = true
    if !condition.nil?
      if (condition.instance_of? Integer) || (condition.instance_of? String)
        my_each do |item|
          flag = false if item == condition
        end
      else
        my_each do |item|
          flag = false if item.is_a? condition
        end
      end
    elsif block_given?
      my_each do |item|
        flag = false if yield(item)
      end
    else
      my_each do |item|
        flag = false unless item == false || item.nil?
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
    if block_given?
      my_each do |item|
        new_arr.push << yield(item)
      end
    elsif !one_proc.nil?
      my_each do |item|
        new_arr.push << one_proc.call(item)
      end
    else
      return to_enum(:map)
    end
    new_arr
  end

  def my_inject(initial = nil, sym = nil)
    real_array = to_a

    if !sym.nil? && !initial.nil?
      total = initial
      0.upto(real_array.length - 1) do |num|
        total = total.method(sym).(real_array[num])
      end
    elsif (!initial.is_a? Integer) && !initial.nil?
      total = real_array[0]
      1.upto(real_array.length - 1) do |num|
        total = total.method(initial).(real_array[num])
      end
    elsif (initial.is_a? Integer) && block_given?
      total = initial
      0.upto(real_array.length - 1) do |num|
        total = yield(total, real_array[num])
      end
    elsif block_given?
      total = real_array[0]
      1.upto(real_array.length - 1) do |num|
        total = yield(total, real_array[num])
      end
    end
    total
  end
end

the_array = [1, 2, 3]

puts (1..4).my_all?(Integer)

=begin

puts 'Hello, type your array '
print '(use space to separate items ex.: 1 2 3 4 5 6)'


the_array = gets.chomp.split(' ').map { |data| data.integer? ? data.to_i : data }
option = -1

puts `clear`

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
=end