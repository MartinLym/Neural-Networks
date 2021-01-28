%% Obtain Left/Right Class Data
num = 2;

leftData = ALLEEG(num).data;

icawLeft = ALLEEG(num).icaweights;
icasp = ALLEEG(num).icasphere;
wLeft = icawLeft * icasp;

leftData_1 = leftData(1,:);
leftData_1 = leftData_1';

sampleMatrix = [];
val = 0;
for i = 1:size(leftData,1)
    for j = 1:size(leftData,2)
        data = leftData(i,j);
        sampleMatrix = [sampleMatrix; data];
        
        if isequal(size(sampleMatrix,1), 501)
            emdData = emd(sampleMatrix);
            hht(emdData, 250);
            saveas(gcf, ['right' num2str(val) '.jpg'])
            sampleMatrix = [];
            val = val + 1;
        end
        
    end
end

% [leftData_1_imf, leftData_1_residual, leftData_1_info]  = emd(leftData_1);
% 
% figure(1)
% hht(leftData_1_imf, 250)
% 
% figure(2)
% hht(leftData_1_imf, 13)
% 
% plot(leftData_1(1:500, 1))

%% Setup Image Dimensions

% left
for i = 0:1583
    imgleft = imread(['C:\Users\marti\Desktop\University\Neural Networks & Fuzzy Logic\Images\leftImages\left' num2str(i) '.jpg']);
    imgrightResize = imresize(imgleft, [50 30]);
    imwrite(imgrightResize, ['C:\Users\marti\Desktop\University\Neural Networks & Fuzzy Logic\Images\leftNew\left' num2str(i) '.jpg']);
end

% right
for i = 0:1583
    imgright = imread(['C:\Users\marti\Desktop\University\Neural Networks & Fuzzy Logic\Images\rightImages\right' num2str(i) '.jpg']);
    imgrightResize = imresize(imgright, [50 30]);
    imwrite(imgrightResize, ['C:\Users\marti\Desktop\University\Neural Networks & Fuzzy Logic\Images\rightNew\right' num2str(i) '.jpg']);
end
%% Convolutional Neural Network

data = imageDatastore('C:\Users\marti\Desktop\University\Neural Networks & Fuzzy Logic\Images\CNN_Images', ...
    'IncludeSubfolders', true, 'labelsource', 'foldernames');
numTrainFiles = 0.7;
[dataTrain, dataValidation] = splitEachLabel(data, numTrainFiles);
layers = [
    imageInputLayer([50 30 3])
    
    convolution2dLayer(5, 24, 'Stride', 1,'Padding', 2)
    batchNormalizationLayer 
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(5, 28, 'Stride', 1,'Padding', 2)
    batchNormalizationLayer 
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(5, 32, 'Stride', 1,'Padding', 2)
    batchNormalizationLayer 
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(5, 36, 'Stride', 1,'Padding', 2)
    batchNormalizationLayer 
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];

options = trainingOptions('adam', ...
    'InitialLearnRate', 0.001, ...
    'MaxEpochs', 80, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', dataValidation, ...
    'ValidationFrequency', 10, ...
    'Verbose', false, ...
    'Plots', 'training-progress');

net = trainNetwork(dataTrain, layers, options);