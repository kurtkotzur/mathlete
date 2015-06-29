module Mathlete
  module Matrix
    class ShapeError < StandardError; end

    refine Array do
      def rotate!
        n = size
        return self if n < 2
        unless all? { |row| row.size == n }
          raise ShapeError.new 'cannot rotate nonsquare array'
        end

        (0...n/2).each do |layer|
          (layer...n-1-layer).each do |i|
            temp                   = self[layer][i]
            self[layer][i]         = self[n-1-i][layer] # left to top
            self[n-1-i][layer]     = self[n-1-layer][n-1-i] # bottom to left
            self[n-1-layer][n-1-i] = self[i][n-1-layer] # right to bottom
            self[i][n-1-layer]     = temp # top to right
          end
        end

        self
      end

      def radiate_zeros!
        rows, cols = {}, {}
        height = size
        return self if height.zero?
        width = first.size
        unless all? { |row| row.is_a?(Array) && row.size == width }
          raise ShapeError.new 'cannot radiate through nonrectangular array'
        end

        (0...height).each do |i|
          (0...width).each do |j|
            if self[i][j].zero?
              rows[i] = true
              cols[j] = true
            end
          end
        end

        return self if rows.empty? && cols.empty?
        rows.keys.each { |i| self[i] = Array.new(width, 0)}
        cols.keys.each { |j| (0...height).each { |i| self[i][j] = 0} }
        self
      end
    end
  end
end
