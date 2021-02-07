%% Obtain Left/Right Class Data
num = 1;
originalData = ALLEEG(num).data;
icaWeights = ALLEEG(num).icaweights;
icaSphere = ALLEEG(num).icasphere;
icaInv = ALLEEG(num).icawinv;

icaDataUse = icaWeights * icaSphere * originalData;
icaDataUse = icaDataUse';

originalData = originalData';

sampleMatrix = [];
val = 1;

startRow = 1;
endRow = 501;

for k = 1:72
    for j = 1:size(icaDataUse,2)
        for i = startRow:endRow
            dataValue = icaDataUse(i,j);
            sampleMatrix = [sampleMatrix; dataValue];
            
            if isequal(size(sampleMatrix,1), 501)
                emdData = emd(sampleMatrix);
                hht(emdData, 250);
                saveas(gcf, ['left' num2str(val) '.jpg'])
                sampleMatrix = [];
                val = val + 1;
            end
            
        end
    end
    
    startRow = startRow + 501;
    endRow = endRow + 501;
    myImages = cell(1,10);
    for z = 1:22
        myImages{z} = imread(['C:\Users\marti\Desktop\University\Neural Networks & Fuzzy Logic\Images\alpha\left\left' num2str(z) '.jpg']);
    end
    
    montage(myImages);
    
    saveas(gcf, ['leftCNN_' num2str(k) '.jpg'])
    val = 1;
end

%% Setup Image Dimensions
dim = [150 150];
% left
for i = 1:72
    imgleft = imread(['C:\Users\marti\Desktop\University\Neural Networks & Fuzzy Logic\Images\alpha\CNN_Images\leftCNN\leftCNN_' num2str(i) '.jpg']);
    imgrightResize = imresize(imgleft, dim);
    imwrite(imgrightResize, ['C:\Users\marti\Desktop\University\Neural Networks & Fuzzy Logic\Images\alpha\training\leftCNN\left' num2str(i) '.jpg']);
end

% right
for i = 1:72
    imgright = imread(['C:\Users\marti\Desktop\University\Neural Networks & Fuzzy Logic\Images\alpha\CNN_Images\rightCNN\rightCNN_' num2str(i) '.jpg']);
    imgrightResize = imresize(imgright, dim);
    imwrite(imgrightResize, ['C:\Users\marti\Desktop\University\Neural Networks & Fuzzy Logic\Images\alpha\training\rightCNN\right' num2str(i) '.jpg']);
end

%% Convolutional Neural Network

dataValue = imageDatastore('C:\Users\marti\Desktop\University\Neural Networks & Fuzzy Logic\Images\alpha\training', ...
    'IncludeSubfolders', true, 'labelsource', 'foldernames');
numTrainFiles = 0.7;
[dataTrain, dataValidation] = splitEachLabel(dataValue, numTrainFiles);
layers = [
    imageInputLayer([dim 3])
    
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