module Printer

  def draw_row(row)
    '| ' + row.join(' | ') + ' |'
  end

  def draw_separator(len, offset = 0)
    puts offset + '-' * len
  end


  def print_cell(cell, offset: 0, top: true, bottom: true)
    width = 0
    spacing = ' ' * offset
    cell.each_with_index do |row, idx|
      current_row = draw_row(row)
      width = current_row.uncolorize.length
      draw_separator(width, spacing) unless idx == 0 && !top
      puts spacing + draw_row(row)
    end
    draw_separator(width, spacing) if bottom
  end

  def print_cells(cell_blocks)
    rows_per_cell = cell_blocks.first.length - 1
    seperator = nil

    0.upto(rows_per_cell) do |row_num|
      seperator = 0
      current_row = ['| ']
      cell_blocks.each do |face|
        current_row << face[row_num].join(' | ') + ' | '
      end
      seperator = current_row.inject(:+).uncolorize.length
      puts '-' * seperator
      print current_row.join('') + "\n"
    end
      puts '-' * seperator
  end


  def print_current_face
    print "\n Current Face: \n"
    print_cell(@cube[2])
    print "\n"
  end


  def print_flat_cube
    <<-DETAILS
    Print a flat 2D rendition of the current Rubiks cube
    in the following format:
                                  TOP
                       LEFTSIDE  FRONT   RIGHTSIDE   BACK
                                 BOTTOM
    DETAILS

    print_cell(@cube.last, offset: 18, top: true, bottom: false)
    print_cells(@cube[1..-2])
    print_cell(@cube.first, offset: 18, top: false, bottom: true)
  end


  def print_flat_cube_vertical
    <<-DETAILS
    Print a flat 2D rendering of current Rubiks cube
    in the following format:
                                 BACK  
                                 TOP
                      LEFTSIDE  FRONT  RIGHTSIDE
                                BOTTOM
    DETAILS

    print_cell(@cube[-2].map { |x| x.reverse }.reverse, offset: 18, top: true, bottom: false)
    print_cell(@cube.last, offset: 18, top: true, bottom: false)
    print_cell(@cube[1..-3])
    print_cell(@cube.first, offset: 18, top: false, bottom: true)
  end

  def print_3d_cube

    front, top, side = @cube[1], @cube[2], @cube[5]
    f = front.flatten
    t = top.flatten
    s = side.flatten
    
    cube = <<-CUBE
        -------------------------- \\
       / #{t[0]}  / #{t[1]}   /  #{t[2]}   /    | 
      /      /       /        /     |
     /---------------------- +  #{s[2]}/|
    / #{t[3]}  / #{t[4]}   /  #{t[5]}  /  |   / |
   /      /       /       /   |  /  |
  /----------------------- #{s[1]}| /   |
 /  #{t[6]}  / #{t[7]}   /  #{t[8]}  / |  /| #{s[5]}|
/       /       /       /  | / |   /|
+----------------------- #{s[0]}/  |  / |
|       |       |       |  /|#{s[4]} /  |
|  #{f[0]}  |  #{f[1]}  |  #{f[2]}  | / |  /|   |
|       |       |       |/  | / |#{s[8]}|
+-----------------------+   |/  |  /
|       |       |       |#{s[3]}/   | /
|  #{f[3]}  |  #{f[4]}  |  #{f[5]}  |  /|#{s[7]}|/
|       |       |       | / |   /
+-----------------------+/  |  /
|       |       |       |   | /
|  #{f[6]}  |  #{f[7]}  |  #{f[8]}  |#{s[6]}|/
|       |       |       |   /
+-----------------------+ -/
  CUBE
  puts ?\n + cube + ?\n
  end

  def inspect_cube
    puts @cube.inspect
  end
end
