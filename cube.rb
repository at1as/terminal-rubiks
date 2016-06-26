require 'colorize'
require_relative './printer.rb'

class Array
  def red;    self.map { |x| x.red }; end
  def yellow; self.map { |x| x.yellow }; end
  def blue;   self.map { |x| x.blue }; end
  def white;  self.map { |x| x.white }; end
  def green;  self.map { |x| x.green }; end
  def cyan;   self.map { |x| x.cyan }; end
end


class Cube

  include Printer

  attr_accessor :cube

  def initialize
    @cube = [
        [   #   bottom
          ['A11', 'A21', 'A31'].red,
          ['A12', 'A22', 'A32'].red,
          ['A13', 'A23', 'A33'].red
        ],
        [   # left side
          ['B11', 'B21', 'B31'].yellow,
          ['B12', 'B22', 'B32'].yellow,
          ['B13', 'B23', 'B33'].yellow
        ],
        [   #   front
          ['C11', 'C21', 'C31'].blue,
          ['C12', 'C22', 'C32'].blue,
          ['C13', 'C23', 'C33'].blue
        ],
        [   # right side
          ['D11', 'D21', 'D31'].white,
          ['D12', 'D22', 'D32'].white,
          ['D13', 'D23', 'D33'].white
        ],
        [   # backside (mirrored)
          ['E31', 'E21', 'E11'].green,
          ['E32', 'E22', 'E12'].green,
          ['E33', 'E23', 'E13'].green
        ],
        [   #     top
          ['F11', 'F21', 'F31'].cyan,
          ['F12', 'F22', 'F32'].cyan,
          ['F13', 'F23', 'F33'].cyan
        ],
    ]
  end

  def rotate_horizonal(dir)
    bottom, *middle, top = @cube

    middle = case dir
      when :left  then middle.rotate
      when :right then middle.rotate(-1)
    end

    @cube = [bottom] + middle + [top]
  end

  def rotate_vertical(dir)
    bottom, *middle, top = @cube

    if dir.to_sym == :down
      bottom, top, middle[1], middle[3] = middle[1], middle[3], top, bottom
    elsif dir.to_sym == :up
      bottom, top, middle[1], middle[3] = middle[3], middle[1], bottom, top
    end

    @cube = [bottom] + middle + [top]
  end

  def rotate_row(row_num, dir)
    bottom, *middle, top = @cube
    shifted = Marshal.load(Marshal.dump(middle))

    if dir.to_sym == :left
      (0..3).each do |face|
        shifted[face][row_num] = middle[(face + 1) % 4][row_num]
      end
    elsif dir.to_sym == :right
      (0..3).each do |face|
        shifted[face][row_num] = middle[(face - 1) % 4][row_num]
      end
    end

    rotation_count = case dir
      when :left  then 1
      when :right then 3
    end

    # Rotate face on top or bottom of cube
    if row_num == 0
      rotation_count.times do
        top = top.transpose.map { |row| row.reverse }
      end
    elsif row_num == 2
      (4 - rotation_count).times do
        bottom = bottom.transpose.map { |row| row.reverse }
      end
    end

    @cube = [bottom] + shifted + [top]
  end

  def rotate_column(col_num, dir)
    bottom, *middle, top = @cube
    new_bottom = Marshal.load(Marshal.dump(bottom)) 
    shifted = Marshal.load(Marshal.dump(middle))
    new_top = Marshal.load(Marshal.dump(top))

    if dir.to_sym == :down
      0.upto(2) do |row_num|
        mirrored_col = (col_num - 2).abs

        new_bottom[row_num][col_num]      = middle[1][row_num][col_num]
        shifted[1][row_num][col_num]      = top[row_num][col_num]
        new_top[row_num][col_num]         = middle[3][row_num][mirrored_col]
        shifted[3][row_num][mirrored_col] = bottom[row_num][col_num]
      end
    elsif dir.to_sym == :up
      0.upto(2) do |row_num|
        mirrored_col = (col_num - 2).abs
        
        new_bottom[row_num][col_num]      = middle[3][row_num][mirrored_col]
        shifted[1][row_num][col_num]      = bottom[row_num][col_num]
        new_top[row_num][col_num]         = middle[1][row_num][col_num]
        shifted[3][row_num][mirrored_col] = top[row_num][col_num]
      end
    end

    rotation_count = case dir
      when :up   then 3
      when :down then 1
    end

    if col_num == 0
      rotation_count.times do
        shifted[0] = shifted[0].transpose.map { |row| row.reverse }
      end
    elsif col_num == 2
      (4 - rotation_count).times do 
        shifted[2] = shifted[2].transpose.map { |row| row.reverse }
      end
    end

    @cube = [new_bottom] + shifted + [new_top]
  end
end



cube = Cube.new


# TEST HORIZONTAL CUBE ROTATION

2.times do |idx|
  dir = idx == 1 ? "left" : "right"
  puts "ROTATING CUBE #{dir}"

  4.times do
    cube.rotate_horizonal(dir.to_sym)
    puts "\n"
    cube.print_flat_cube
  end
end


# TEST VERTICAL CUBE ROTATION

2.times do |idx|
  dir = idx == 1 ? "up" : "down"
  print "ROTATING CUBE #{dir}"

  4.times do
    cube.rotate_vertical(dir.to_sym)
    puts "\n"
    cube.print_flat_cube
  end
end

# TEST HORIZONTAL ROW ROTATIONS

0.upto(2) do |row|
  2.times do |idx|
    dir = idx == 1 ? :left : :right
    print "\nROTATING ROW #{row} #{dir}\n"
    4.times do
      cube.rotate_row(row, dir)
      cube.print_flat_cube
    end
  end
end


# TEST VERTICAL ROW ROTATIONS

2.times do |idx0|
  3.times do |idx|
    dir = idx0 == 0 ? :down : :up
    4.times do
      print "\nROTATING COLUMN #{idx} #{dir}\n"
      cube.rotate_column(idx, dir)
      cube.print_flat_cube
    end
  end
end

cube.print_flat_cube_vertical
