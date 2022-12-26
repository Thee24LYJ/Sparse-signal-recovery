 %  Show how to use MSBL in noiseless case

clc;
clear;
 
% Problem dimension 
M = 25;                  % Row number of the dictionary matrix  
N = 50;                 % Column number of the dictionary matrix 
L = 1;                   % Number of measurement vectors 
K = 8;                  % Number of nonzero rows (i.e. source number) in the solution matrix

% Generate dictionary matrix with columns draw uniformly from the surface of a unit hypersphere 
Phi = randn(M,N); 
Phi = Phi./(ones(M,1)*sqrt(sum(Phi.^2))); 

% Generate the K nonzero rows      
nonzeroW = randn(K,L); 

% Locations of nonzero rows are randomly chosen 
ind = randperm(N); 
indice = ind(1:K); 
Wgen = zeros(N,L); 
Wgen(indice,:) = nonzeroW; 

% Noiseless signal 
Y = Phi * Wgen; 

%============================ Run MSBL ========================== 
lambda = 1e-10;          % Initial value for the regularization parameter.  
                         %  In noiseless cases, you can set lambda = 
                         %  1e-10 (or any other very small values) and  
                         %  set learn_Lambda = 0, which can lead to excellent performance. 

learn_Lambda = 0;        % Using its lambda learning rule to learn an (sub-)optimal lambda.  
                         %  When SNR < 20 dB, the lambda learning rule may not be 
                         %  robust. In this case, you probabaly need to use 
                         %  other methods to find a lambda value and set learn_Lambda = 0. 

[Weight3,gamma_est3,gamma_used3,count3] = MSBL(Phi,Y, lambda, learn_Lambda); 

figure(1)
stem(1:50,Wgen);

figure(2);
stem(1:50,Wgen);hold on;
stem(1:50,Weight3,'-*');
legend('原始信号','恢复信号');
title('基于SBL的稀疏信号恢复');
% figure(2)
% stem(1:25,Y);
% title('y');

 