class Cell
  
  attr_accessor :neighbours, :location
  
  def initialize(alive = false, alive_next = false)
    @alive = alive
    @alive_next = alive_next
  end
  
  def alive?
    @alive
  end

  def alive=(alive)
    @alive = alive
  end

  def calc_next_state
    alive_count = @neighbours.count{|x| x.alive?}
    if alive? then
      @alive_next = (2..3) === alive_count ? true : false
    else
      @alive_next = 3 == alive_count ? true : false
    end
  end

  def alive_next?
    @alive_next
  end
  def update_state
    @alive = @alive_next
    @alive_next = false 
  end
  def inspect
    @location
  end
end
