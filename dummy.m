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


  
