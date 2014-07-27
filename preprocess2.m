function [train_data, train_label,validation_data, validation_label, test_data] =preprocess2()

  train_data=load('train.csv');
  test_data=load('test.csv');
  
  % Separate data of each digit

  indices=find(train_data(:,1)==0);
  train0=train_data(indices,:);

  indices=find(train_data(:,1)==1);
  train1=train_data(indices,:);

  indices=find(train_data(:,1)==2);
  train2=train_data(indices,:);

  indices=find(train_data(:,1)==3);
  train3=train_data(indices,:);

  indices=find(train_data(:,1)==4);
  train4=train_data(indices,:);

  indices=find(train_data(:,1)==5);
  train5=train_data(indices,:);

  indices=find(train_data(:,1)==6);
  train6=train_data(indices,:);

  indices=find(train_data(:,1)==7);
  train7=train_data(indices,:);

  indices=find(train_data(:,1)==8);
  train8=train_data(indices,:);

  indices=find(train_data(:,1)==9);
  train9=train_data(indices,:);

n_validation=800;

 validation_data = [train0(1:n_validation, :); train1(1:n_validation, :); ...
  train2(1:n_validation, :); train3(1:n_validation, :); train4(1:n_validation, :);...
  train5(1:n_validation, :); train6(1:n_validation, :); train7(1:n_validation, :);
  train8(1:n_validation, :); train9(1:n_validation, :)];
    
 validation_label=validation_data(:,1);
  validation_data=validation_data(:,2:end);
 

 % Remove the combine the examples to form train_data;
  clear 'train_data';
  train_data= [train0(n_validation+1:end, :); train1(n_validation+1:end,:); train2(n_validation+1:end,:); train3(n_validation+1:end,:);...
					    train4(n_validation+1:end,:); train5(n_validation+1:end, :); train6(n_validation+1:end,:);...
					      train7(n_validation+1:end,:); train8(n_validation+1:end, :); train9(n_validation+1:end,:)];
  train_label=train_data(:, 1);
  train_data=train_data(:,2:end);

%   Preprocess the data
train_data = double(train_data); % convert training data to matrix of double
validation_data = double(validation_data); % convert validation data to matrix of double
test_data = double(test_data);   % convert testing data to matrix of double

% get the number of training, validation and test examples
n_feature = size(test_data, 2);


% get the number of training, validation and test examples
n_feature = size(test_data, 2);
%   Delete features which don't provide any useful information for
%   classifiers
sigma = std(train_data);
new_train_data = [];
new_validation_data = [];
new_test_data = [];
for i = 1 : n_feature
    if (sigma(i) > 0.001)
        new_train_data = [new_train_data train_data(:, i)];
        new_validation_data = [new_validation_data validation_data(:, i)];
        new_test_data = [new_test_data test_data(:, i)];
    end
end  

train_data = new_train_data;
validation_data = new_validation_data;
test_data = new_test_data;
