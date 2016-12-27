class Game
	attr_accessor :board
	def initialize
		@board = create_board
		build_graph
	end
	
	def create_board
		 x = 1
		 y = 1
		 counter = 0
		temp_board= []
		 8.times{
			 8.times{
				 temp_board.push(Square.new([x, y]))
				 y+=1
			 }
			 x+=1
			 y=1
		 }
		 return temp_board			
	end

	def build_graph
		 @board.each{|x|
				x.connections.each{|y| x.possible_moves.push(get_node(y))}				
			 }
	end
	
	def get_node(coordinates)
		@board.each{|x| 
		return x if x.coordinate == coordinates}
	end
	
	def knight_moves(start, finish)
		 current_pos = get_node(start)
		 final_pos = get_node(finish)
		 queue = [current_pos]
		 visited = {current_pos=>true}
		 
		#loops through and adds unchecked to the queue. We're adding a visited tag so
		#it will terminate branches that end up on an already visited square
		 while final_pos != current_pos				 
			 current_pos.possible_moves.each{|x|				 
				 if !visited[x]
					 queue.push(x)
					 x.previous = current_pos
					 visited[x] = true
				 end
				 }			
			current_pos = queue[0]
			queue.shift			
		end
		 
		puts "\n\nStart: #{get_node(start).coordinate}, End: #{final_pos.coordinate}"
		
		#backtrace all previous from final coordinate. Since the loop terminates once it finds
		#the end, tracing back will be the shortest route
		path = []
		curr_path = final_pos
		while curr_path !=nil			
			path.unshift(curr_path)
			curr_path = curr_path.previous
		end
		path.each_with_index{|x,y| puts "#{y}: #{x.coordinate.inspect}"}
		puts "Shortest route distance: #{path.length-1} "
	end
end
class Square
	attr_accessor :x, :y, :connections, :coordinate, :possible_moves, :previous
	def initialize(coordinate)
		@coordinate = coordinate
		@x = coordinate[0]
		@y = coordinate[1]
		@connections = get_possible_moves
		@possible_moves = []
		@previous = nil
	end
	
	def get_possible_moves
		moves = []
		x = @x
		y = @y 
		
		if (1..8).include?(@x-1) && (1..8).include?(@y+2) 
			  moves.push([@x-1, @y+2])
		end
		if (1..8).include?(@x-1) && (1..8).include?(@y-2) 
			  moves.push([@x-1, @y-2])
		end		
		if (1..8).include?(@x-2) && (1..8).include?(@y-1) 
			  moves.push([@x-2, @y-1]) 	
		end
		if (1..8).include?(@x-2) && (1..8).include?(@y+1) 
			  moves.push([@x-2, @y+1])			
		end
		if (1..8).include?(@x+1) && (1..8).include?(@y+2) 
			  moves.push([@x+1,@y+2])
		end
		if (1..8).include?(@x+1) && (1..8).include?(@y-2) 
			  moves.push([@x+1,@y-2])	
		end
		if (1..8).include?(@x+2) && (1..8).include?(@y-1) 		
		 	  moves.push([@x+2, @y-1])	
		end
		if (1..8).include?(@x+2) && (1..8).include?(@y+1) 		
			  moves.push([@x+2, @y+1])
		end		
		
		return moves
	end
end

my_game = Game.new
x = []
y = []
sx = nil
sy = nil
fx = nil
fy = nil
system("cls")
puts "Enter two points for the knight to travel between:\n\n"

while !(1..8).include?(sx)
	print "Starting X value [1-8]: "
	sx = gets.chomp.to_i
	if !(1..8).include?(sx)
		puts "Input not in range, try again."
	end
end
x.push(sx)

while !(1..8).include?(sy)
	print "Starting Y value [1-8]: "
	sy = gets.chomp.to_i
	if !(1..8).include?(sy)
		puts "Input not in range, try again."
	end
end
	x.push(sy)


while !(1..8).include?(fx)
	print "End point X value [1-8]: "
	fx = gets.chomp.to_i
	if !(1..8).include?(fx)
		puts "Input not in range, try again."
	end
end
y.push(fx)

while !(1..8).include?(fy)
	print "End point Y value [1-8]: "
	fy = gets.chomp.to_i
	if !(1..8).include?(fy)
		puts "Input not in range, try again."
	end
end

y.push(fy)
my_game.knight_moves(x, y)
gets
#test_game.get_node([3,3]).possible_moves.each{|x| puts x.coordinate.inspect}
