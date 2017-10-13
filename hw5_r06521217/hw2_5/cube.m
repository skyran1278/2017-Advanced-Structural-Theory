% R06521217 乃宥然 高結HW2_5

function [ x iter ] = cube(a, tol)

  x = a;
  iter = 0;
  condition = true;


  while condition
    oldx = x;
    x = 1 / 3 * (2 * oldx + a / oldx ^ 2);
    iter = iter + 1;
    condition = abs((x - oldx) / x) > tol;
  end

end
