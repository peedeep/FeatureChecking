clear; clc;

[X,T] = wine_dataset;
hiddenSize = 10;
autoenc1 = trainAutoencoder(X,hiddenSize,... 
    'L2WeightRegularization',0.001,... 
    'SparsityRegularization',4,...... 
    'SparsityProportion',0.05,...... 
    'DecoderTransferFunction','purelin');

features1 = encode(autoenc1,X);

hiddenSize = 10;
autoenc2 = trainAutoencoder(features1,hiddenSize,...
    'L2WeightRegularization',0.001,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.05,...
    'DecoderTransferFunction','purelin');

features2 = encode(autoenc2,features1);

hiddenSize = 10;
autoenc3 = trainAutoencoder(features2,hiddenSize,...
    'L2WeightRegularization',0.001,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.05,...
    'DecoderTransferFunction','purelin');

features3 = encode(autoenc3, features2);

softnet = trainSoftmaxLayer(features3, T , 'LossFunction', 'crossentropy');

deepnet = stack(autoenc1, autoenc2,  autoenc3, softnet);

deepnet = train(deepnet, X, T);

wine_type = deepnet(X);

plotconfusion(T, wine_type);

