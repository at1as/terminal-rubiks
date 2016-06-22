require_relative './printer.rb'

class Cube
  include Printer

  attr_accessor :cube

  def initialize
    @cube = [
        [
          ['A11', 'A21', 'A31'],
          ['A12', 'A22', 'A32'],
          ['A13', 'A23', 'A33']
        ],
        [
          ['B11', 'B21', 'B31'],
          ['B12', 'B22', 'B32'],
          ['B13', 'B23', 'B33']
        ],
        [
          ['C11', 'C21', 'C31'],
          ['C12', 'C22', 'C32'],
          ['C13', 'C23', 'C33']
        ],
        [
          ['D11', 'D21', 'D31'],
          ['D12', 'D22', 'D32'],
          ['D13', 'D23', 'D33']
        ],
        [
          ['E11', 'E21', 'E31'],
          ['E12', 'E22', 'E32'],
          ['E13', 'E23', 'E33']
        ],
        [
          ['F11', 'F21', 'F31'],
          ['F12', 'F22', 'F32'],
          ['F13', 'F23', 'F33']
        ],
    ]
  end

  def rotate_horizonal(dir)
    bottom, *middle, top = @cube

    middle = case dir
      when :left  then middle[1..-1] + [middle.first]
      when :right then [middle.last] + middle[0..-2]
    end

    @cube = [bottom] + middle + [top]
  end

  def rotate_vertical(dir)
    bottom, *middle, top = @cube

    if dir == :up
      bottom, top, middle[1], middle[3] = middle[1], middle[3], top, bottom
    elsif dir == :down
      bottom, top, middle[1], middle[3] = middle[3], middle[1], bottom, top
    end

    @cube = [bottom] + middle + [top]
  end

  def rotate_row(row_num, dir)
    bottom, *middle, top = @cube
    shifted = Marshal.load(Marshal.dump(middle))

    if dir.downcase == :left
      (0..3).each do |face|
        shifted[face][row_num] = middle[(face + 1) % 4][row_num]
      end
    elsif dir.downcase == :right
      (0..3).each do |face|
        shifted[face][row_num] = middle[(face - 1) % 4][row_num]
      end
    end

    @cube = [bottom] + shifted + [top]
  end

  def rotate_column(column_num, dir)

  end
end



cube = Cube.new

# TEST HORIZONTAL CUBE ROTATION
2.times do |idx|
  dir = idx == 1 ? "left" : "right"
  print "ROTATING #{dir}"

  4.times do
    cube.rotate_horizonal(dir.to_sym)
    puts "\n"
    cube.print_flat_cube
  end
end

# TEST VERTICAL CUBE ROTATION
2.times do |idx|
  dir = idx == 1 ? "up" : "down"
  print "ROTATING #{dir}"

  4.times do
    cube.rotate_vertical(dir.to_sym)
    puts "\n"
    cube.print_flat_cube
  end
end

# TEST HORIZONTAL ROW ROTATION
2.times do |idx|
  dir = idx == 1 ? :left : :right
  print "ROTATING row #{dir}\n"
  4.times do
    cube.rotate_row(1, dir)
    cube.print_flat_cube
  end
end
