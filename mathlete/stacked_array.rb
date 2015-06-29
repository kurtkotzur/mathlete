module Mathlete
  class StackedArray
    def initialize(stack_size)
      @stack_size = stack_size
      @buffer = Array.new(stack_size * 3, nil)
      @stack_pointers = [-1, -1, -1]
    end

    def push(stack_num, val)
      unless @stack_pointers[stack_num] + 1 < @stack_size
        raise 'out of space'
      end

      @stack_pointers[stack_num] += 1
      @buffer[abs_top_of_stack(stack_num)] = val

      val
    end

    alias_method :<<, :push

    def pop(stack_num)
      if @stack_pointers[stack_num] == -1
        raise 'trying to pop an empty stack'
      end

      val = @buffer[abs_top_of_stack(stack_num)]
      @buffer[abs_top_of_stack(stack_num)] = nil
      @stack_pointers[stack_num] -= 1

      val
    end

    def peek(stack_num)
      index = abs_top_of_stack(stack_num)
      @buffer[index]
    end

    def empty?(stack_num)
      @stack_pointers[stack_num] == -1
    end

    private

    def abs_top_of_stack(stack_num)
      return @stack_size * stack_num + @stack_pointers[stack_num]
    end
  end
end
