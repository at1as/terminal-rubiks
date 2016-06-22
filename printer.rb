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
    cell.each do |row|
      current_row = draw_row(row)
      width = current_row.length
      draw_separator(width, spacing)
      puts spacing + draw_row(row)
    end
    draw_separator(width, spacing) if bottom
  end

  def print_cells(cell_blocks)
    rows_per_cell = cell_blocks.first.length - 1
    0.upto(rows_per_cell) do |row_num|
      seperator = 0
      current_row = '| '
      cell_blocks[1..-2].each do |face|
        current_row = face[row_num].join(' | ') + ' | '
        seperator += current_row.length
        print current_row
      end
      puts "\n" + '-' * seperator
    end
  end

  def print_current_face
    print "\n Current Face: \n"
    print_cell(@cube[2])
    print "\n"
  end

  def print_flat_cube

    inst = <<-DESC
    Print a flat 2D rendition of the current cube
    Printed in the format:
           TOP
     LS   FACE   RS   BACK
         BOTTOM
    DESC

    print_cell(@cube.first, offset: 16, bottom: false)
    print_cells(@cube)
    print_cell(@cube.last, offset: 16)
  end

  def inspect_cube
    puts @cube.inspect
  end
end
