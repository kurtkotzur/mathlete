require_relative 'node'

module Mathlete
  class Stack
    def push(value)
      node = Node.new(value)
      node.next = @top
      @top = node
      value
    end

    alias_method :<<, :push

    def pop
      return nil if @top.nil?
      val = @top.value
      @top = @top.next
      val
    end

    def peek
      @top.value
    end
  end
end
