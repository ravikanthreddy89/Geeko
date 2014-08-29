clearvars;
clc;

% Perform pre-processing
[train_data, train_label, validation_data, validation_label, test_data] = preprocess2();

save('train_data', 'train_label', 'validation_data', 'validation_label', 'test_data');

k=1;

predicted_label = knnPredict(k, train_data, train_label, validation_data);
fprintf('\nValidation Set Accuracy: %f\n', ...
         mean(double(predicted_label == validation_label)) * 100);

