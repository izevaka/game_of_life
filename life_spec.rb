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
  end
  context 'Filling neighbours' do
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


    ################################################
    #              #                #              #
    # top_left     # top_middle     # top_right    #
    #              #                #              #
    ################################################
    #              #                #              #
    # middle_left  # middle_middle  # middle_right #
    #              #                #              #
    ################################################
    #              #                #              #
    # bottom_left  # bottom_middle  # bottom_right #
    #              #                #              #
    ################################################

    it 'should fill neighbours for top left' do
      top_left.neighbours.should =~ [top_middle, middle_middle, middle_left]
    end
    it 'should fill neighbours for top middle' do
      top_middle.neighbours.should =~ [top_left, top_right, middle_left, middle_middle, middle_right]
    end
    it 'should fill neighbours for top right' do
      top_right.neighbours.should =~ [top_middle, middle_middle, middle_right]
    end
    it 'should fill neighbours for middle left' do
      middle_left.neighbours.should =~ [top_left, top_middle, middle_middle, bottom_middle, bottom_left]
    end
  end
  context 'Iteration' do
    it 'should be called with every cell position and cell' do
      life = Life.new (2,3)
      positions = []
      cells = []
      life.each do |left, top, cell|
        positions.push [left, top]
	cells.push cell
      end

      positions.should =~[[0,0], [0,1], [0,2], [1,0], [1,1], [1,2]]
      cells.count {|x| x.is_a? Cell}.should == 6
    end
  end
end

describe Helper do
  it 'should set to min when less than min' do
    value = Helper.clamp(0,1,5)
    value.should be 1
  end 
  it 'should set to max when grater than max' do
    value = Helper.clamp(7,1,5)
    value.should be 5
  end 
end
