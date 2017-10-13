% R06521217 乃宥然 高結HW2_3

% 消除前一次作業
clc; clear; close all;

printProbability(100);
printProbability(10000);
printProbability(1000000);


function f = printProbability(testTimes)
  fprintf('after %d tests, probability of failure is %f \n', testTimes, bigTest(testTimes));
end


function probability = bigTest(testTimes)
%bigTest - probability of failure
%
% Syntax: probability = bigTest(testTimes)
%
% Long probability of failure

  exceedLimitTimes = 0;

  for index = 1 : testTimes

    L = 5;
    E = 7.7 * 10 ^ 6 + ( 0.1 * 10 ^ 6 * rand );
    I = 8 * 10 ^ (-4) + ( 2 * 10 ^ (-4) * rand );
    w = 10 + 15 * rand;

    exceedLimit = 0.0069 * w * L ^ 4 / E / I > L / 360;

    if exceedLimit
      exceedLimitTimes = exceedLimitTimes + 1;
    end

  end

  probability = exceedLimitTimes / testTimes;

end
