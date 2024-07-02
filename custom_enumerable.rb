module Enumerable
  def my_each_with_index
    i = 0
    self.my_each do |elem|
      yield elem, i
      i += 1
    end
    self
  end

  def my_all?
    self.my_each { |n| return false unless yield(n) }
    true
  end

  def my_any?
    self.my_each { |elem| return true if yield elem }
    false
  end

  def my_none?
    self.each { |elem| return false if yield elem}
    true
  end

  def my_map
    map_array = []

    self.my_each { |elem| map_array << yield(elem)}
    map_array
  end

  def my_inject(arg=nil)
    initial_value = arg || self.first
    self.each { |elem| initial_value = yield(initial_value, elem) }
    initial_value
  end


  def my_count(arg = nil)
    return self.length if !block_given? && arg.nil?

    count = 0
    self.each do |elem|
      if block_given?
        count += 1 if yield elem
      else
        count += 1 if elem == arg
      end
    end
    count
  end

  def my_select
    display_data = []
    self.my_each { |elem| display_data << elem if yield elem }
    display_data
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method..
class Array
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < length
      yield self[i]
      i += 1
    end
    self
  end

end
