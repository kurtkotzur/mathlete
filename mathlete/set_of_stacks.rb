require_relative 'node'

module Mathlete
  class SetOfStacks
    attr_reader :stacks

    def initialize(capacity)
      @capacity = capacity
      @stacks = []
      @sizes = [0]
    end

    def push(value)
      new_size = @sizes.last + 1

      if new_size > @capacity
        @stacks << Node.new(value)
        @sizes << 1
      else
        new_top = Node.new(value)
        if @stacks.last.nil?
          @stacks << Node.new(value)
        else
          new_top.next = stacks.last
          stacks[-1] = new_top
        end
        @sizes[-1] = new_size
      end

      value
    end

    alias_method :<<, :push

    def pop
      pop_at(-1)
    end

    def pop_at(index)
      top = @stacks[index]
      return nil if top.nil?
      val = top.value

      if top.next.nil?
        @stacks.delete_at(index)
        @sizes.delete_at(index)
      else
        @stacks[index] = top.next
        @sizes[index] -= 1
      end

      val
    end

    def peek
      top = @stacks.last
      top.nil? ? nil : top.value
    end
  end
end
