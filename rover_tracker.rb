def heading_map(char)
  case char
  when 'N'
    [0, 1]
  when 'S'
    [0, -1]
  when 'E'
    [1, 0]
  else
    [-1, 0]
  end
end

def ch_map(heading)
  case heading
  when [0, 1]
    'N'
  when [0, -1]
    'S'
  when [1, 0]
    'E'
  else
    'W'
  end
end

def angle_deg(size)
  size += 90
  size = 90 if size >= 180
  size
end

def turn(posn, turn, angle)
  x_posn = posn[0]
  y_posn = posn[1]
  if angle == 90
    if turn == 'L'
      [-y_posn, x_posn]
    else
      [y_posn, -x_posn]
    end
  else
    [-x_posn, -y_posn]
  end
end

def add(posn_one, posn_two)
  x_posn = posn_one[0] + posn_two[0]
  y_posn = posn_one[1] + posn_two[1]
  [x_posn, y_posn]
end

def bounds_exceeded?(posn, bounds)
  exceeded = false
  exceeded = true if posn[0] > bounds[0].to_i || posn[1] > bounds[1].to_i || (posn[0]).negative? || (posn[1]).negative?
  exceeded
end

def rover_tracker(input)
  bounds = input[0].split

  end_posns = []

  (1..input.length - 1).each do |idx|
    angle = 0
    rover = input[idx].split
    x_posn = rover[0].to_i
    y_posn = rover[1].to_i
    posn = [x_posn, y_posn]
    heading = heading_map(rover[2])
    moves = rover[3].split('')

    moves.each do |value|
      if bounds_exceeded?(posn, bounds)
        p 'Bounds exceeded!'
        return nil
      end

      if value == 'M'
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
input_file.close

output = rover_tracker(input)

output.each do |line|
  p line.join(' ')
end
