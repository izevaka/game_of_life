#!/usr/bin/env ruby

require 'life'
require 'curses'

class Game
  def initialize
    Curses.noecho
    Curses.curs_set(0)
    @window = Curses.init_screen
    @window.refresh
    
    @width = @window.maxx
    @height = @window.maxy
    @life = Life.new(@height, @width)
    
    create_glider
    create_spaceship
    
    #Curses.setpos(0,0)
    #Curses.addstr "w #{@width} h #{@height}"
    #Curses.addch ?@
  end

  def create_glider
    #glider
    #  @
    #   @
    # @@@
    @life.cell_at(0,1).alive= true
    @life.cell_at(1,2).alive= true
    @life.cell_at(2,0).alive= true
    @life.cell_at(2,1).alive= true
    @life.cell_at(2,2).alive= true
  end

  def alive(t,l)
    @life.cell_at(t,l).alive= true
  end

  def create_spaceship
   #spaceship
   # @  @ 
   #     @
   # @   @
   #  @@@@
   spaceship = [[0,0], [0, 3], [1, 4], [2,0], [2,4], [3, 1], [3,2], [3,3], [3,4]]
   
   spaceship.each do |cell|
     #cell.map! {|x| x + 12}
     alive(cell[0] + 8, cell[1])
   end
  end
 
  def draw
    @window.clear
    @life.each do |t, l, cell|
      if cell.alive? 
        Curses.setpos(t, l)
        Curses.addch ?@
      end
    end
    @life.update_state
    Curses.refresh
  end
  def run
    begin
      yield self
    ensure
      Curses.close_screen
    end
  end
end

Game.new.run do |game|
  loop do
    #case Curses.getch
    #  when ?q then break
    #end
    game.draw
    sleep 0.03
  end
end
