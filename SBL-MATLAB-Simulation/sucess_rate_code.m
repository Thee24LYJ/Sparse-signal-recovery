%  Show the MSBL sucess rate in noiseless case

clc;
clear;

iterNum = 1000;          % Trial number (i.e. number of repeating the experiment)

% Problem dimension
M = 25;                  % Row number of the dictionary matrix
N = 50;                 % Column number of the dictionary matrix
L = 1;                   % Number of measurement vectors    
K_temp = 4:2:20;        % Number of nonzero rows (i.e. source number) in the solution matrix
sucess_rate = zeros(1,length(K_temp));
fail_MSBL = zeros(1,iterNum);

for i = 1:length(K_temp)
    K = K_temp(i);
    for it = 1 : iterNum
        
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
        
        % Failure rate
        F3 = perfSupp(Weight3,indice,'firstlargest', K);
        fail_MSBL(it) = (F3~=1);
        
    end
    % Sucess rate
    sucess_rate(i) = (iterNum-sum(fail_MSBL))/iterNum;
end

figure(1);
plot(K_temp,sucess_rate,'-*');
title('25*50Ëæ»ú¾ØÕóµÄÏ¡ÊèÐÅºÅ»Ö¸´');
xlabel('Ï¡Êè¶È');
ylabel('Ï¡ÊèÐÅºÅ»Ö¸´³É¹¦ÂÊ');