require_relative 'node'

module Mathlete
  class Queue
    def enqueue(value)
      if @first.nil?
        @last = Node.new(value)
        @first = @last
      else
        @last.next = Node.new(value)
        @last = @last.next
      end
    end

    alias_method :<<, :enqueue
    alias_method :push, :enqueue

    def dequeue
      return nil if @first.nil?
      val = @first.value
      @first = @first.next
      val
    end

    alias_method :pop, :dequeue
    alias_method :shift, :dequeue
  end
end
