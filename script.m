clearvars;
clc;

% Perform pre-processing
[train_data, train_label, validation_data, validation_label, test_data] = preprocess2();

save('train_data', 'train_label', 'validation_data', 'validation_label', 'test_data');

fprintf('Size of train_date');
size(train_data)
fprintf('Size of test_data');
size(test_data)
fprintf('Size of validation data');
size(validation_data)

%Encode the single digit labels to 10-bit vectors
n_class = 10;
T = zeros(size(train_label, 1), n_class);
for i = 1 : n_class
    T(:, i) = (train_label == i);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Binary Logistic Regression with Gradient Descent*******************
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\nLogistic regression with Gradient descent\n');
options = optimset('MaxIter', 200);
W = zeros(size(train_data, 2) + 1, n_class);
initialWeights = zeros(size(train_data, 2) + 1, 1);
for i = 1 : n_class
    objFunction = @(params) blrObjFunction(params, train_data, T(:, i));
    [w, ~] = fmincg(objFunction, initialWeights, options);
    W(:, i) = w;
end

W_blr=W;
predicted_label = blrPredict(W, train_data);
size(predicted_label)
fprintf('\nTraining Set Accuracy: %f\n', mean(double(predicted_label == train_label)) * 100);

predicted_label = blrPredict(W, validation_data);
fprintf('\nValidation Set Accuracy: %f\n', mean(double(predicted_label == validation_label)) * 100);

predicted_label = blrPredict(W, test_data);
fprintf('\nTest Set Accuracy: %f\n', mean(double(predicted_label == test_label)) * 100);

return;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Binary Logistic Regression with Newton-Raphson method**************
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% (extra credits)
% (un-comment this block of code to run)
fprintf('\nLogistic regression with Newton-Raphson method\n');
W = zeros(size(train_data, 2) + 1, n_class);
initialWeights = zeros(size(train_data, 2) + 1, 1);
n_iter = 5;
for i = 1 : n_class
    W(:, i) = blrNewtonRaphsonLearn(initialWeights, train_data, T(:, i), n_iter);
 end
% 
W_blr_NR=W;
predicted_label = blrPredict(W, train_data);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(predicted_label == train_label)) * 100);
% 
predicted_label = blrPredict(W, validation_data);
fprintf('\nValidation Set Accuracy: %f\n', mean(double(predicted_label == validation_label)) * 100);
% 
predicted_label = blrPredict(W, test_data);
fprintf('\nTest Set Accuracy: %f\n', mean(double(predicted_label == test_label)) * 100);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multiclass Logistic Regression with Gradient Descent *******
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (extra credits)
% (un-comment this block of code to run)
fprintf('\nMulticlass Logistic regression with gradient descent\n');
options = optimset('MaxIter', 200);
initialWeights = zeros((size(train_data, 2) + 1) * n_class, 1);
 
    objFunction = @(params) mlrObjFunction(params, train_data, T);
[W, cost] = fmincg(objFunction, initialWeights, options);
W = reshape(W, size(train_data, 2) + 1, n_class);    
W_mlr=W;

predicted_label = mlrPredict(W, train_data);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(predicted_label == train_label)) * 100);
 
predicted_label = mlrPredict(W, validation_data);
fprintf('\nValidation Set Accuracy: %f\n', mean(double(predicted_label == validation_label)) * 100);
 
predicted_label = mlrPredict(W, test_data);
fprintf('\nTest Set Accuracy: %f\n', mean(double(predicted_label == test_label)) * 100);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multiclass Logistic Regression with Newton-Raphson method **
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (extra credits)
% (un-comment this block of code to run)
clear train_data;
clear train_label;
clear test_data;
clear test_label;
clear validation_data;
clear validation_label;
clear T;


load('newdataset_MLR.mat');

n_class = 10;
T = zeros(size(train_label, 1), n_class);
for i = 1 : n_class
    T(:, i) = (train_label == i);
end

initialWeights = zeros((size(train_data, 2) + 1) * n_class, 1);
n_iter = 2;
[W] = mlrNewtonRaphsonLearn(initialWeights, train_data, T, n_iter);
% 
predicted_label = mlrPredict(W, train_data);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(predicted_label == train_label)) * 100);
% 
predicted_label = mlrPredict(W, validation_data);
fprintf('\nValidation Set Accuracy: %f\n', mean(double(predicted_label == validation_label)) * 100);
% 
predicted_label = mlrPredict(W, test_data);
fprintf('\nTest Set Accuracy: %f\n', mean(double(predicted_label == test_label)) * 100);
W_mlr_NR=W;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Support Vector Machine**************************************
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   YOUR CODE HERE %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear train_data;
clear train_label;
clear test_data;
clear test_label;
clear validation_data;
clear validation_label;
clear T;
load('newdataset_SVM.mat');

% Part 1 : Linear Kernel
model_linear= svmtrain ( train_label, train_data , '-q -t 0' ) ; 
fprintf('\nTraining data\n');
[train_output,train_accuracy, ~]=svmpredict(train_label,train_data,model_linear);
fprintf('\nValidation data\n');
[validation_output, validation_accuracy, ~]=svmpredict(validation_label,validation_data,model_linear);
fprintf('\nTest data\n');
[test_output, test_accuracy, ~]=svmpredict(test_label,test_data,model_linear);


% Part 2: Radial basis function(-t 2) & gamma=1(-g 1)
model_rbf_1 = svmtrain ( train_label, train_data , '-q -t 2 -g 1' ) ;
fprintf('\nTraining data\n');
[train_output,train_accuracy, ~]=svmpredict(train_label,train_data,model_rbf_1);
fprintf('\nValidation data\n');
[validation_output, validation_accuracy, ~]=svmpredict(validation_label,validation_data,model_rbf_1);
fprintf('\nTest data\n');
[test_output, test_accuracy, ~]=svmpredict(test_label,test_data,model_rbf_1);


% Part 3: Radial basis function only(-t 2)
model_rbf_default = svmtrain ( train_label, train_data , '-q -t 2') ;
fprintf('\nTraining data\n');
[train_output,train_accuracy, ~]=svmpredict(train_label,train_data,model_rbf_default);
fprintf('\nValidation data\n');
[validation_output, validation_accuracy, ~]=svmpredict(validation_label,validation_data,model_rbf_default);
fprintf('\nTest data\n');
[test_output, test_accuracy, ~]=svmpredict(test_label,test_data,model_rbf_default);



% Part 4: Radial basis function & varying C=(1; 10; 20; 30;...; 100)
%and plot the graph of accuracy with respect to values of C in the report.
accuracy =zeros(1,11);
fprintf('\nC=1\n');
model =  svmtrain ( train_label, train_data ,['-q -t 2 -c 1' ] ) ;
fprintf('\nTraining data\n');
[train_output,train_accuracy, ~]=svmpredict(train_label,train_data,model);
fprintf('\nValidation data\n');
[validation_output, validation_accuracy, ~]=svmpredict(validation_label,validation_data,model);
fprintf('\nTest data\n');
[test_output, test_accuracy, ~]=svmpredict(test_label,test_data,model);


train_accuracy=zeros(3,size((10:10:100),2));
test_accuracy=zeros(3,size((10:10:100),2));
validation_accuracy=zeros(3,size((10:10:100),2));

 
for i=10:10:100
   fprintf('\nC= %d\n',i);
   model =  svmtrain ( train_label, train_data ,['-q -t 2 -c ' num2str(i)] ) ;
   fprintf('\nTraining data\n');
   [train_output,train_accuracy(:,(i/10)), ~]=svmpredict(train_label,train_data,model);
   fprintf('\nValidation data\n');
   [validation_output, validation_accuracy(:,i/10), ~]=svmpredict(validation_label,validation_data,model);
   fprintf('\nTest data\n');
   [test_output, test_accuracy(:,i/10), ~]=svmpredict(test_label,test_data,model);
      
end

[~, mac_C]= max(validation_accuracy(1,:));

model_rbf_C=svmtrain ( train_label, train_data ,['-q -t 2 -c ' num2str(mac_C)] ) ;

save('param.mat', 'W_blr','W_blr_NR', 'W_mlr', 'W_mlr_NR', 'model_linear', 'model_rbf_1','model_rbf_default', 'model_rbf_C');
