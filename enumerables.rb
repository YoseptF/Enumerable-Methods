# frozen_string_literal: true

module Enumerable
  def my_each
    length.times do |item|
      yield(self[item])
    end
  end
end

exp = [1, 1, 3]

exp.my_each do |x|
  puts "each: #{x}"
end
