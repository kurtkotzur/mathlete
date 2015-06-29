require_relative 'node'

module Mathlete
  class MinStack
    def push(value)
      new_top = Node.new(value)
      new_top.next = @top
      @top = new_top

      min_val = @min.nil? ? value : [min, value].min
      new_min = Node.new(min_val)
      new_min.next = @min
      @min = new_min

      value
    end

    alias_method :<<, :push

    def pop
      return nil if @top.nil?
      val = @top.value
      @top = @top.next
      @min = @min.next
      val
    end

    def peek
      @top.value
    end

    def min
      @min.value
    end
  end
end
