% R06521217 乃宥然 高結HW2_4

function [ area ] = integral(a,b,deltax)

  area = 0;
  x = a : deltax : b

  for index = 1 : size(x)
    area = ( x(index) + x(index + 1) ) / 2 * deltax
  end

end
