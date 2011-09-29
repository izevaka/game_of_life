require 'life'
require 'curses'

class Game
  def initialize
    @window = Curses.init_screen
    @width = @window.maxx
    @height = @window.maxy
    @life = Life.new(@height, @width)
    @window.refresh
  end

  def run
    begin
      yield
    ensure
      Curses.close_screen
    end
  end
end


Game.new.run {sleep 5}
