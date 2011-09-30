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

  def initialize(height, width)
    @width = width
    @height = height
    @cells = Array.new(height) {Array.new(width) {Cell.new}}
    
    each {|t, l, cell| cell.location = "#{t}x#{l}"}
    fill_neighbours
  end
  def cell_at(top, left)
    @cells[top][left]
  end
  def each
    for left in (0..width - 1)
      for top in (0..height - 1)
        yield(top, left, @cells[top][left])
      end
    end
  end
  def update_state

    each do |t,l,cell|
      cell.calc_next_state
    end

    each do |t,l,cell|
      cell.update_state
    end
  end

private
  def fill_neighbours
    each do |top, left, cell| 
      fill_neighbours_for_cell(top, left,cell) 
    end
  end
  def fill_neighbours_for_cell(cell_top, cell_left, cell)
    neighbours = Array.new
    (-1..1).each do |l|
      (-1..1).each do |t|
	#exlude ourselves
        left = l
        top = t

        if  (top == 0 and left == 0) then next end
	left = cell_left + left
	top = cell_top + top
        
        
        left = Helper.clamp(left, 0, @width - 1)
        top = Helper.clamp(top, 0, @height - 1 )
       
        #exclude ourselves
	if (left == cell_left and top == cell_top) then next end
        neighbours.push @cells[top][left]
      end
    end
    cell.neighbours= neighbours.uniq
  end
end
