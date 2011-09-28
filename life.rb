require 'cell'

class Helper
  def Helper.clamp(value, min, max)
    ret = value
    if (value < min)
      ret = min
    end
    if (value > max)
      ret = max
    end
    ret
  end
end

class Life
  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
    @cells = Array.new(width, Array.new(height, Cell.new))

    fill_neighbours
  end
  def cell_at(left, top)
    @cells[left][top]
  end
  def each
    for left in (0..width - 1)
      for top in (0..height - 1)
        yield(left, top, @cells[left][top])
      end
    end
  end

private
  def fill_neighbours
    each do |left, top, cell| fill_neighbours_for_cell(left,top,cell) end
  end
  def fill_neighbours_for_cell(cell_left, cell_top, cell)
    neighbours = Array.new
    (-1..1).each do |left|
      (-1..1).each do |top|
	#exlude ourselves
        if  (top == 0 and left == 0) then next end
	left = cell_left + left
	top = cell_top + top

        left = Helper.clamp(left, 0, @width - 1)
        top = Helper.clamp(top, 0, @height - 1 )
        #exclude ourselves
	if (left == cell_left and top == cell_top) then next end
        neighbours.push @cells[left][top]
      end
    end
    cell.neighbours= neighbours#.uniq
  end
end
