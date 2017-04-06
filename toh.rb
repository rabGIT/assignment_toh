class Toh
  def initialize(disks=3)
    @num_disks = disks
    @moves = 0
    @stack1 = []
    @stack2 = []
    @stack3 = []
    disks.downto(1) { |disk| @stack1.push(disk) }
  end

  def render
    puts
    puts "After #{@moves} moves: "
    @num_disks.downto(0) do |num|
      num >= @stack1.length ? print("|".center(5)) : print(@stack1[num].to_s.center(5))
      num >= @stack2.length ? print("|".center(5)) : print(@stack2[num].to_s.center(5))
      num >= @stack3.length ? puts("|".center(5)) : puts(@stack3[num].to_s.center(5))
    end
    puts "\n"
  end

  def play
    puts "Welcome to Tower of Hanoi with #{@num_disks} disks.\n\n"
    puts "Instructions for play: "
    puts "Enter a move in the format 'from,to' at the prompt or Q to the quit."
    puts "For example, entering '1,3' will move the top disk from stack 1 to stack 3.\n\n"
    puts "The current board looks like: "
    render
    puts
    loop do
      move
      render
      if won?
        puts "\nYou won!"
        exit
      end
    end
  end

  def won?()

    @stack2.length == @num_disks || @stack3.length == @num_disks ? (return true) : (return false)
  end

  def move()
    puts "Enter your move: "
    new_move = gets.strip.upcase.split(',')
    disk_to_move = 0
    stack_from = []
    stack_to = []

    if new_move[0] == 'Q'
      puts "\n\nThanks for playing!"
      exit
    end

    if new_move[0].length > 1 || new_move.length > 2
      puts("\n\nMoves should be entered as from,to where values are 1,2 or 3 or Q to quit.")
    elsif new_move[0] =~ /[123]/ && new_move[1] =~ /[123]/ && valid_move?(new_move[0].to_i, new_move[1].to_i)
      stack_from = assign_stack(new_move[0].to_i)
      stack_to = assign_stack(new_move[1].to_i)
      stack_to.push(stack_from.pop)
      @moves += 1
    else
      puts("\n\nNot a valid move.")
    end
  end

  def valid_move?(start_stack, end_stack)
    stack_from = assign_stack(start_stack)
    stack_to = assign_stack(end_stack)
    to_top_disk = 0
    stack_from.empty? ? (return false) : from_top_disk = stack_from[-1]

    stack_to.empty? ? to_top_disk = @num_disks**2 : to_top_disk = stack_to[-1]
    from_top_disk < to_top_disk ? (return true) : (return false)
  end

  def assign_stack(stack)
    case stack
    when 1
      return @stack1
    when 2
      return @stack2
    when 3
      return @stack3
    end
  end

end
