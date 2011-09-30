require 'life'

describe Life do
  context 'creation' do
    it 'should create universe of specified size' do
      life = Life.new(10, 8)
      life.width.should be 8
      life.height.should be 10
    end

    it 'should fill universe with dead cells' do
      life = Life.new(10,8)

      (0..9).each do |top|
        (0..7).each do |left|
	  life.cell_at(top,left).should_not be_alive
        end
      end
    end
    it 'should fill universe with dead cells' do
      life = Life.new(10,8)
      cells = []
      (0..9).each do |top|
        (0..7).each do |left|
	  cells.push life.cell_at(top, left)
        end
      end
      cells.uniq.length.should == 80
    end
 end
  context 'Filling neighbours' do
    life = Life.new(3,3)

    top_left = life.cell_at(0,0)
    top_middle = life.cell_at(0,1)
    top_right = life.cell_at(0,2)

    middle_left = life.cell_at(1,0)
    middle_middle = life.cell_at(1,1)
    middle_right = life.cell_at(1,2)
    
    bottom_left = life.cell_at(2,0)
    bottom_middle = life.cell_at(2,1)
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
    it 'should fill neighbours for middle middle' do
      middle_middle.neighbours.should =~ [top_left, top_middle, top_right, middle_left, middle_right,  bottom_left, bottom_middle, bottom_right ]
    end
    it 'should fill neighbours for middle right' do
      middle_right.neighbours.should =~ [top_middle, top_right, bottom_right, bottom_middle, middle_middle ]
    end
  
    it 'should fill neighbours for bottom left' do
      bottom_left.neighbours.should =~ [bottom_middle, middle_middle, middle_left]
    end
    it 'should fill neighbours for bottom middle' do
      bottom_middle.neighbours.should =~ [bottom_left, bottom_right, middle_left, middle_middle, middle_right]
    end
    it 'should fill neighbours for bottom right' do
      bottom_right.neighbours.should =~ [bottom_middle, middle_middle, middle_right]
    end
  end
  context 'Iteration' do
    it 'should be called with every cell position and cell' do
      life = Life.new (2,3)
      positions = []
      cells = []
      life.each do |top, left, cell|
        positions.push [top, left]
	cells.push cell
      end

      positions.should =~[[0,0], [0,1], [0,2], [1,0], [1,1], [1,2]]
      cells.count {|x| x.is_a? Cell}.should == 6
    end
  end
  context 'Game' do
    it 'should calculate next state when update_state' do
      life = Life.new(3,3)

      life.cell_at(1,1).alive= true
      life.cell_at(1,0).alive= true
      life.cell_at(1,2).alive= true


      life.update_state

      life.cell_at(1,1).should be_alive
      life.cell_at(1,0).should_not be_alive
      life.cell_at(1,2).should_not be_alive
      
      life.cell_at(0,1).should be_alive
      life.cell_at(2,1).should be_alive
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
