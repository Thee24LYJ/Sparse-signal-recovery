clear; close all;
%% Initial value
% m rows -> equations, n columns -> vars
m = 128; n = 256; 
A = normc(randn(m, n));
x = randn(n, 1);
y = A * x;
%% exact solution, least-squares solution, and basic solution
xExact = x;
xBasic = pinv(A) * y;
xLeastSquare = A \ y;
% corresponding errors
errorMeanExact = mean(A * xExact - y);
errorMeanBasic = mean(A * xBasic - y);
errorMeanLeastSquare = mean(A * xLeastSquare - y);
%% Ground truth solution vs Underdetermined solutions
xExactIndex = find (xExact ~= 0);
xBasicIndex = find(xBasic ~= 0);
xLeastSquareIndex = find(xLeastSquare ~= 0);
figure;
% basic solution
basicFig = subplot(2, 1, 1);
plot(xExactIndex, xExact, 'k');
hold on;
xBasicPlot = plot(xBasic, 'r');
xlim([0 n]);
title('基于伪逆的欠定系统的基本解');
xlabel('x索引值');
ylabel('x索引对应值');
legend('准确解', '基本解');
% least-squares solution
leastSquareFig = subplot(2, 1, 2);
plot(xExactIndex, xExact, 'k');
hold on;
xLeastSquarePlot = plot(xLeastSquare, 'magenta');
xlim([0 n]);
title('用Mldivide法求解欠定系统的最小二乘解');
xlabel('x索引值');
ylabel('x索引对应值');
legend('准确解', '最小二乘解');
