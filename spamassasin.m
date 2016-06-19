% Add libsvm path to workspace
addpath("./libsvm-3.21/matlab/");

% Load from ex6data1: 
% You will have X, y in your environment
load('ex6data1.mat');

fprintf('\nTraining Linear SVM Using Libsvm ...\n')

% Learning model using libsvm
model = svmtrain(y, X);

model.w = model.SVs' * model.sv_coef;
model.b = -model.rho;

if model.Label(1) == -1
    w = -w;
    b = -b;
end

visualizeBoundaryLinear(X, y, model);