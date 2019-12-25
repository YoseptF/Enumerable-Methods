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

exp = [1, 2, 12, 7, 4, 34, 2]

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

puts(exp.my_all? { |num| num < 45 })

puts '-------------------------------------------------'

puts(exp.my_any?)

puts '-------------------------------------------------'

puts(exp.my_none? { |num| num == 7 })

puts '-------------------------------------------------'

puts exp.my_count(2)

puts '-------------------------------------------------'

puts(exp.my_map { |num| num * 2 })

puts '-------------------------------------------------'

puts(%w[a aba].my_inject(0) { |_total, num| num.length })

puts '-------------------------------------------------'

puts(exp.my_inject { |total, num| total + num })

puts '-------------------------------------------------'

def multitply_els(arr)
  arr.my_inject { |total, num| total * num }
end

puts multitply_els([2, 4, 5])

puts '-------------------------------------------------'

my_proc = proc { |num| num * 2 }

puts(exp.my_map(my_proc))
