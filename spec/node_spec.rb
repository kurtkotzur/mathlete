require_relative '../mathlete/node'
require 'pry'

module Mathlete
  describe Node do
    let(:node) { Node.new(1) }

    let(:list) do
      first = Node.new(1)
      first.next = Node.new(2)
      first.next.next = Node.new(3)
      first
    end

    describe '#initialize' do
      it 'saves the node\'s value' do
        expect(node.value).to eq 1
      end
    end

    describe '#append' do
      context 'with a single argument' do
        it 'adds to a single node' do
          node.append([])
          expect(node.next.value).to eq []
        end

        it 'adds to a list' do
          list.append({})
          expect(list.next.next.next.value).to eq({})
        end
      end

      context 'with multiple arguments' do
        it 'adds to a single node' do
          node.append(2, 3)
          expect([node.next, node.next.next].map(&:value)).to eq [2, 3]
        end

        it 'adds to a list' do
          list.append(4, 5)
          fourth = list.next.next.next
          expect([fourth, fourth.next].map(&:value)).to eq [4, 5]
        end
      end
    end

    describe '#delete' do
      it 'returns nil if there is no match' do
        expect(list.delete(4)).to be_nil
      end

      context 'with a matching node' do
        it 'removes it from the list' do
          list.delete(2)
          expect(list.next.value).to eq 3
        end

        it 'returns the node\'s value' do
          expect(list.delete(3)).to eq 3
        end
      end
    end

    describe '#list' do
      it 'prints a single node' do
        expect(node.list).to eq '1'
      end

      it 'prints a list with multiple nodes' do
        expect(list.list).to eq '1 -> 2 -> 3'
      end
    end

    describe '#to_s' do
      it 'returns a string' do
        expect(node.to_s).to be_a String
      end

      it 'delegates to the value' do
        node.value = :foo
        expect(node.to_s).to eq 'foo'
      end
    end

    describe '::link' do
      let(:a_link) { Node.link(1) }
      let(:some_links) { Node.link(1, 2, 3) }

      it 'creates a single node' do
        expect(a_link).to be_a Node
        expect(a_link.next).to be_nil
      end

      it 'creates multiple nodes' do
        expect([some_links, some_links.next].map(&:value)).to eq [1, 2]
      end
    end
  end
end
