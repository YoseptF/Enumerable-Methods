# frozen_string_literal: true

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
end

exp = [1, 2, 12, 7, 4, 34]

exp.my_each do |value|
  puts "value: #{value}"
end

puts '-------------------------------------------------'

exp.my_each_with_index do |index, value|
  puts "index: #{index}"
  puts "value: #{value}"
end

puts '-------------------------------------------------'

puts exp.my_select(&:even?)

puts '-------------------------------------------------'

puts exp.my_all?
