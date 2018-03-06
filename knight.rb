def possible_moves position
  moves = []
  first = position[0]
  second = position[1]
  if first - 2 >= 0
    moves.push([first -2,second -1]) if second -1 >= 0
    moves.push([first -2,second +1]) if second +1 <= 7
  end
  if first -1 >= 0
    moves.push([first -1,second -2]) if second -2 >= 0
    moves.push([first -1,second +2]) if second +2 <= 7
  end
  if first +1 <= 7
    moves.push([first +1,second -2]) if second -2 >= 0
    moves.push([first +1,second +2]) if second +2 <= 7
  end
  if first +2 <=7
    moves.push([first +2,second -1]) if second -1 >= 0
    moves.push([first +2,second +1]) if second +1 <= 7
  end
  return moves
end

class Node
  attr_accessor :parent, :position, :children;
  def initialize position, parent = nil
    @position = position
    @parent = parent
    @children = []
  end
end

def bfs start, stop
  queue = [start]
  while queue != []
    current = queue.shift
    return current if current.position == stop
    queue= queue + current.children
  end
end

def knight_moves start, stop
  position = [start]
  knight_start = Node.new(start)
  building = [knight_start]
  while !position.include?(stop)
    current = building.shift
    helper = possible_moves current.position
    helper.each do |x|
      if !position.include?(x)
        position.push(x)
        node = Node.new(x,current)
        current.children.push(node)
        building.push(node)
      end
    end
  end
  path = []
  node = bfs knight_start,stop
  while node.parent != nil
    path.unshift(node.position)
    node = node.parent
  end
  path.unshift(start)
  return path
end

print "#{knight_moves [0,0],[1,2]} \n"
print "#{knight_moves [0,0],[3,3]} \n"
print "#{knight_moves [3,3],[0,0]} \n"
print "\n------------------------ \n#{knight_moves [3,3],[4,3]} \n"
