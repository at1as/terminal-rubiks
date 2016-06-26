require_relative './printer.rb'
require_relative './cube.rb'


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


# CUBE PRINTING VERTICAL
cube.print_flat_cube_vertical

# 3D CUBE RENDER
cube.print_3d_cube

