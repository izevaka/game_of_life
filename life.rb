require 'cell'

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

private
  def fill_neighbours
    (0..width - 1).each do |left|
      (0..height - 1).each do |top|
        @cells[left][top].neighbours = []
      end
    end
  end
end
