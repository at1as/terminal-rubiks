require_relative './cube'

PRINT_HELP = <<-HELP
  How would you like the cube printed?
    [1] Flat 2D Horizontal View
    [2] Flat 2D Vertical View
    [3] Single Face
    [4] 3-Dimensional View
HELP

MOVE_HELP = <<-HELP
  To rotate the cube type any of the following
    `r <row num> <direction>`  (rotate row number <row num> in the direction <direction>)
    `c <col num> <direction>`  (rotate col number <col num> in the direction <direction>)
    `f <direction>`            (rotate cube face in the direction <direction>)

    Examples:
      `row 2 left`  or    `r 2 l`
      `row 3 right` or    `r 3 r`
      `col 1 up`    or    `c 1 u`
      `col 1 down`  or    `c 1 d`
      `f up`        or    `f u`
HELP

GENERAL_HELP = <<-HELP
  Type any of the following commands
    `print help`
    `move help`
HELP

ROW_COL         = ['r', 'c', 'row', 'col']
FACE            = ['f', 'face']
H_DIRECTIONS    = ['l', 'r', 'left', 'right']
V_DIRECTIONS    = ['u', 'd', 'up', 'down'] 
DIRECTIONS      = H_DIRECTIONS + V_DIRECTIONS
VALID_ROWS_COLS = [1,2,3]


def cube_printer(cube, print_style)
  case print_style
  when 1
    cube.print_flat_cube
  when 2
    cube.print_flat_cube_vertical
  when 3
    cube.print_current_face
  when 4
    cube.print_3d_cube
  end
end


def main
  print_type = nil
  cube = Cube.new
  
  loop do
    puts PRINT_HELP
    print_type = gets

    if ['1','2','3','4'].include? print_type.strip
      puts MOVE_HELP
      break
    end
  end

  while true do
    print "What would you like to move?\n> "
    modify = gets

    # Ensure input is valid and no help flag has been triggered
    if modify.strip.downcase == "print help"
      puts PRINT_HELP
      next
    elsif modify.strip.downcase == "move help"
      cube_printer(cube, print_type.to_i)
      puts MOVE_HELP
      next
    end
    
    modify = modify.split
    
    # ROTATE COL/ROW
    if ROW_COL.include?(modify.first.strip.downcase) && modify.length == 3
      if VALID_ROWS_COLS.include? modify[1].to_i
        if ['r', 'row'].include? modify.first.strip.downcase
          case modify[2].to_sym
            when :l, :left
              cube.rotate_row(modify[1].to_i - 1, :left)
            when :r, :right
              cube.rotate_row(modify[1].to_i - 1, :right)
            else
              next
          end
        elsif ['c', 'col'].include? modify.first.strip.downcase
          case modify[2].to_sym
            when :u, :up
              cube.rotate_column(modify[1].to_i - 1, :up)
            when :d, :down
              cube.rotate_column(modify[1].to_i - 1, :down)
            else
              next
          end
        else
          next
        end

      end

    # ROTATE CUBE
    elsif FACE.include?(modify.first.strip.downcase) && modify.length == 2
      case modify[1].to_sym
      when :u, :up
        cube.rotate_vertical(:up)
      when :d, :down
        cube.rotate_vertical(:down)
      when :l, :left
        cube.rotate_horizontal(:left)
      when :r, :right
        cube.rotate_horizontal(:right)
      else
        next
      end
    else
      next
    end
    
    cube_printer(cube, print_type.to_i)
  end
end


main()

