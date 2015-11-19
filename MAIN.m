% This MATLAB R2014b code is for EVOLUTIONARY MULTITASKING across minimization problems. 
% For maximization problems, multiply objective function by -1.

% For suggestions please contact: Abhishek Gupta (Email: abhishekg@ntu.edu.sg or
% agup839@aucklanduni.ac.nz or abhi.nitr2010@gmail.com)

clear
close all

n=30;
M=orth(randn(n,n));

Load
Tasks(1) = testfun(1);

%% Calling the solvers
% For large population sizes, consider using the Parallel Computing Toolbox
% of MATLAB.
% Else, program can be slow.
pop = 100; % population size
gen = 200; % generation count
selection_pressure = 'roulette wheel'; % choose either 'elitist' or 'roulette wheel'
p_il = 1; % probability of individual learning (BFGA quasi-Newton Algorithm) --> Indiviudal Learning is an IMPORTANT component of the MFEA.
rmp = 0.4; % random mating probability
i = 7;
% for i = 1:length(testfun)
    data_SOO=SOO(testfun(i),1,pop,gen,selection_pressure,p_il);     
    bestfun(i).name = testfun(i).funname;
    bestfun(i).key = data_SOO.EvBestFitness;
% end
