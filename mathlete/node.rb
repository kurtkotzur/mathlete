module Mathlete
  class Node
    attr_accessor :next, :value

    def initialize(v)
      @value = v
    end

    def append(*vals)
      if vals.empty?
        raise ArgumentError.new 'must append at least one value'
      end

      if vals.size > 1
        vals.each { |v| append(v) }
      else
        other = Node.new(vals.first)
        n = self

        n = n.next until n.next.nil?
        n.next = other

        self
      end
    end

    def delete(v)
      n = self

      return self.next if n.value == v

      until n.next.nil?
        if n.next.value == v
          n.next = n.next.next
          return v
        end
        n = n.next
      end

      nil
    end

    def list
      result = value.to_s
      n = self

      until n.next.nil?
        n = n.next
        result += (' -> ' << n.value.to_s)
      end

      result
    end

    def to_s
      @value.to_s
    end

    def self.link(*vals)
      n = new(vals.first)
      vals.shift
      n.append(*vals) unless vals.empty?
      n
    end

    def self.remove_duplicates_worse(node)
      seen = {}
      previous = nil
      until node.nil?
        if seen[node.value]
          previous.next = node.next
        else
          seen[node.value] = true
          previous = node
        end
        node = node.next
      end
    end

    def self.remove_duplicates(node)
      return if node.nil?

      current = node
      until current.nil?
        runner = current
        until runner.nil?
          if runner.next.value == current.value
            runner.next = runner.next.next
          else
            runner = runner.next
          end
        end
        current = current.next
      end
    end

    def self.kth_last(node, k)
      size = 0
      current = node
      until current.nil?
        size += 1
        current = current.next
      end

      i = 0
      until i == size - k
        node = node.next
        i += 1
      end

      node
    end

    def self.delete_2(node)
      node.data = node.next.data
      node.next = node.next.next
    end

    def self.partition(node, x)
      before_start = nil
      before_end = nil
      after_start = nil
      after_end = nil

      until node.nil?
        next_node = node.next
        node.next = nil
        if node.value < x
          if before_start.nil?
            before_start = node
            before_end = before_start
          else
            before_end.next = node
            before_end = node
          end
        else
          if after_start.nil?
            after_start = node
            after_end = after_start
          else
            after_end.next = node
            after_end = node
          end
        end
        node = next_node
      end

      return after_start if before_start.nil?

      before_end.next = after_start
      before_start
    end

    def self.crazy_add(l1, l2, result=nil, carry=0)
      return result if l1.nil? && l2.nil? && carry.zero?

      val1 = (l1.nil? ? 0 : l1.value) || 0
      val2= (l2.nil? ? 0 : l2.value) || 0
      sum = val1 + val2 + carry
      carry = (sum > 10 ? sum / 10 : 0)

      if result.nil?
        result = Node.new(sum % 10)
      else
        result.append(sum % 10)
      end

      l1 = (l1.nil? ? nil : l1.next)
      l2 = (l2.nil? ? nil : l2.next)
      crazy_add(l1, l2, result, carry)
    end

    def self.loop_start(node)
      seen = {}
      loop do
        node = node.next
        return node.value if seen.include?(node.value)
        seen[node.value] = true
      end
    end

    def self.reverse(node)
      return if node.nil? || node.next.nil?
      second = node.next
      third = second.next
      second.next = node
      node.next = nil

      return second if third.nil?
      current_node = third
      previous_node = second
      until current_node.nil?
        next_node = current_node.next
        current_node.next = previous_node
        previous_node = current_node
        current_node = next_node
      end

      previous_node
    end

    def self.palindrome?(node)
      stack = []
      fast = node
      slow = node
      until fast.nil? || fast.next.nil?
        stack << slow.value
        slow = slow.next
        fast = fast.next.next
      end
      slow = slow.next unless fast.nil?

      until slow.nil?
        val = stack.pop
        return false unless slow.value == val
        slow = slow.next
      end

      true
    end
  end
end
