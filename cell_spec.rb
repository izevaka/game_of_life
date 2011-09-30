require 'cell'

describe Cell do
  let(:dead_cell){Cell.new}
  let(:alive_cell){Cell.new(true, false)}
  let(:one_neighbour) {[
   	Cell.new,
	Cell.new,
	Cell.new(true),
   	Cell.new,
   	Cell.new,
	Cell.new,
	Cell.new,
	Cell.new
   ]}
   let(:two_neighbours) {[
   	Cell.new,
	Cell.new,
	Cell.new(true),
   	Cell.new(true),
   	Cell.new,
	Cell.new,
	Cell.new,
	Cell.new
   ]}
  let(:three_neighbours) {[
   	Cell.new,
	Cell.new,
	Cell.new(true),
   	Cell.new(true),
   	Cell.new(true),
	Cell.new,
	Cell.new,
	Cell.new
   ]}
   let(:four_neighbours) {[
   	Cell.new,
	Cell.new,
	Cell.new(true),
   	Cell.new(true),
   	Cell.new(true),
	Cell.new(true),
	Cell.new,
	Cell.new
   ]}
   context 'creation' do
     it 'should be dead when created' do
       dead_cell.alive?.should be false
     end
     it 'should be alive if created alive' do
      alive_cell.alive?.should be true
     end
   end
   context 'Calculation' do
    it 'should be dead in the next state if less than two neighbours and is alive' do
      alive_cell.neighbours= one_neighbour
      alive_cell.calc_next_state
      alive_cell.alive_next?.should be false
    end
    it 'should be dead in the next state if founr neighbours and is alive' do
     alive_cell.neighbours= four_neighbours
     alive_cell.calc_next_state
     alive_cell.alive_next?.should be false
    end
    it 'should be dead in the next state if two neighbours and is dead' do
     dead_cell.neighbours= two_neighbours
     dead_cell.calc_next_state
     dead_cell.alive_next?.should be false
    end
    it 'should be alive in the next state if three neighbours and is dead' do
     dead_cell.neighbours= three_neighbours
     dead_cell.calc_next_state
     dead_cell.alive_next?.should be true
    end
    it 'should set alive' do
      dead_cell.alive= true
      dead_cell.should be_alive
    end
  end
  context 'Update state' do
    it 'should set alive to false when alive and is dead in the next state' do
      alive_cell.update_state
      alive_cell.alive?.should be false
      alive_cell.alive_next?.should be false
    end
    it 'should set alive to true when dead and is alive in the next state' do
     cell = Cell.new(false, true)
     cell.update_state
     cell.alive?.should be true
     cell.alive_next?.should be false
    end
  end
end
