require 'life'

describe Life do
  context 'creation' do
    it 'should create universe of specified size' do
      life = Life.new(10, 8)
      life.width.should be 10
      life.height.should be 8
    end

    it 'should fill universe with dead cells' do
      life = Life.new(10,8)

      (0..9).each do |left|
        (0..7).each do |top|
	  life.cell_at(left,top).should_not be_alive
	end
      end
    end

    it 'should fill neighbours for all edge cases' do
      life = Life.new(3,3)

      top_left = life.cell_at(0,0)
      top_middle = life.cell_at(1,0)
      top_right = life.cell_at(2,0)

      middle_left = life.cell_at(0,1)
      middle_middle = life.cell_at(1,1)
      middle_right = life.cell_at(2,1)
      
      bottom_left = life.cell_at(0,2)
      bottom_middle = life.cell_at(1,2)
      bottom_right = life.cell_at(2,2)

      top_left.neighbours.should include(top_middle, middle_middle, middle_left)
    end
  end
end
