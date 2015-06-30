require_relative '../mathlete/matrix'

module Mathlete
  describe Matrix do
    using Matrix

    describe '::rotate!' do
      it 'raises an error unless the array is square' do
        expect do
          [[1,2,3],[4,5,6]].rotate!
        end.to raise_error Matrix::ShapeError, 'cannot rotate nonsquare array'
      end

      it 'does not modify empty arrays' do
        arr = []
        arr.rotate!
        expect(arr).to eql []
      end

      it 'does not modify single-element arrays' do
        arr = [1]
        arr.rotate!
        expect(arr).to eql [1]
      end

      it 'works on 2x2 arrays' do
        arr = [[1, 2], [3, 4]]
        arr.rotate!
        expect(arr).to eql [[3, 1], [4, 2]]
      end

      # a b c d e    u p k f a
      # f g h i j    v q l g b
      # k l m n o -> w r m h c
      # p q r s t    x s n i d
      # u v w x y    y t o j e
      it 'works on 5x5 arrays' do
        arr = ('a'..'y').each_slice(5).to_a
        arr.rotate!
        expect(arr).to eql [
          %w(u p k f a),
          %w(v q l g b),
          %w(w r m h c),
          %w(x s n i d),
          %w(y t o j e)
        ]
      end

      # 0 1 2 3 4 5 6 7 8 9    9 8 7 6 5 4 3 2 1 0
      # 1 2 3 4 5 6 7 8 9 0    0 9 8 7 6 5 4 3 2 1
      # 2 3 4 5 6 7 8 9 0 1    1 0 9 8 7 6 5 4 3 2
      # 3 4 5 6 7 8 9 0 1 2    2 1 0 9 8 7 6 5 4 3
      # 4 5 6 7 8 9 0 1 2 3 -> 3 2 1 0 9 8 7 6 5 4
      # 5 6 7 8 9 0 1 2 3 4    4 3 2 1 0 9 8 7 6 5
      # 6 7 8 9 0 1 2 3 4 5    5 4 3 2 1 0 9 8 7 6
      # 7 8 9 0 1 2 3 4 5 6    6 5 4 3 2 1 0 9 8 7
      # 8 9 0 1 2 3 4 5 6 7    7 6 5 4 3 2 1 0 9 8
      # 9 0 1 2 3 4 5 6 7 8    8 7 6 5 4 3 2 1 0 9
      it 'works on 10x10 arrays' do
        arr = Array.new(10) { [] }
        expected = Array.new(10) { [] }
        10.times do |i|
          val1 = i
          val2 = (i - 1) % 10
          10.times do
            arr[i] << val1
            val1 += 1
            val1 %= 10

            expected[i] << val2
            val2 -= 1
            val2 %= 10
          end
        end

        arr.rotate!

        expect(arr).to eq expected
      end
    end

    describe '::radiate_zeros!' do
      it 'does not modify empty arrays' do
        arr = []
        arr.radiate_zeros!
        expect(arr).to eq []
      end

      it 'raises an error unless the array is rectangular' do
        arr = [1, 0, 1, 1]
        expect do
          arr.radiate_zeros!
        end.to raise_error Matrix::ShapeError, 'cannot radiate through nonrectangular array'
      end

      # 1 0 -> 0 0
      # 1 1    1 0
      it 'works on 2x2 arrays' do
        arr = [[1, 0], [1, 1]]
        arr.radiate_zeros!
        expect(arr).to eq [[0, 0], [1, 0]]
      end

      context 'with a 5x5 array' do
        it 'works with a single zero' do
          arr = Array.new(5) { Array.new(5, 1) }
          arr[0][0] = 0
          expected = [
            [0, 0, 0, 0, 0],
            [0, 1, 1, 1, 1],
            [0, 1, 1, 1, 1],
            [0, 1, 1, 1, 1],
            [0, 1, 1, 1, 1]
          ]

          arr.radiate_zeros!

          expect(arr).to eq expected
        end

        it 'works with multiple zeros' do
          arr = Array.new(5) { Array.new(5, 1) }
          arr[1][1] = 0
          arr[3][3] = 0
          expected = [
            [1, 0, 1, 0, 1],
            [0, 0, 0, 0, 0],
            [1, 0, 1, 0, 1],
            [0, 0, 0, 0, 0],
            [1, 0, 1, 0, 1]
          ]

          arr.radiate_zeros!

          expect(arr).to eq expected
        end
      end
    end
  end
end
