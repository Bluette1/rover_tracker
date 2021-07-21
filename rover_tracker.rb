def heading_map (ch)
  heading = nil
  
  if (ch == 'N')
    heading = [0, 1]   
  elsif (ch == 'S')
    heading = [0, -1] 
  elsif (ch == 'E')
    heading = [1, 0]   
  else
    heading = [-1, 0]
  end
  heading
end

def ch_map (heading)
  ch = nil
  
  if (heading == [0, 1])
    ch =  'N'  
  elsif (heading ==[0, -1])
    ch = 'S'
  elsif (heading == [1, 0])
    ch = 'E'
  else
    ch = 'W'
  end
  ch
end

def angle_deg(size)
  size += 90
  if (size >= 180)
    size = 90
  end
  size
end

def turn (posn, turn, angle)
  x_posn = posn[0]
  y_posn = posn[1]
  res = nil
  if (angle == 90)
    if (turn == 'L')
      res = [-y_posn, x_posn]
    else
      res = [y_posn, -x_posn]
    end 
  else
    res = [-x_posn, -y_posn] 
  end
  res
end

def add(posn_1, posn_2)
  x_posn = posn_1[0] + posn_2[0]
  y_posn = posn_1[1] + posn_2[1]
  [x_posn, y_posn]
end

def rover_tracker(input)
 bounds = input[0]

 end_posns = []

 (1..input.length - 1).each do |idx|
  angle = 0
  rover = input[idx].split
  x_posn = rover[0].to_i
  y_posn = rover[1].to_i
  posn = [x_posn, y_posn]
  heading = heading_map(rover[2])
  moves = rover[3].split('')

  for value in moves do   
    if(value == 'M')
      posn = add(heading, posn)
    else
      angle = angle_deg(angle)
      heading = turn(heading, value, angle)
    end
  end
  posn << ch_map(heading)
  end_posns << posn
 end
 end_posns
end

input_file = File.open('input.txt')
input = input_file.readlines.map(&:chomp)

p rover_tracker(input)