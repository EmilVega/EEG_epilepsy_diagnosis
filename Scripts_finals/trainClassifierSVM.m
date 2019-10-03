function [trainedClassifier,classificationSVM] = trainClassifierSVM(trainingData)

% En esta etapa sería necesario seleccionar el porcentaje de entrenamiento,
% la variable trainingData debe contener las columnas que se desea tener en
% el modelo.
% 
% El modelo está entrenando realizando validación en cruz (5 folds).
% 
% En la parte inferior se tiene el código del entrenamiento del modelo que
% generó el mejor resultado de clasificación con las columnas seleccionadas
% ofreciendo una clasificación del 94.83%
% 
% El modelo de predicción se guarda con el nombre "trainedClassifier"
% 
% Para realizar la clasificación de nuevos datos se aplica el ejemplo
% 
% trainedClassifier.predictFcn(X(1,[132 151 196 188 169 139 165 163 157]))

% El primer parámetro representa a la muestra a clasificar.

% Convert input to table
inputTable = array2table(trainingData, 'VariableNames', {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10'});

predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9'};
predictors = inputTable(:, predictorNames);
response = inputTable.column_10;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationSVM = fitcsvm(...
    predictors, ...
    response, ...
    'KernelFunction', 'gaussian', ...
    'PolynomialOrder', [], ...
    'KernelScale', 3, ...
    'BoxConstraint', 1, ...
    'Standardize', true, ...
    'ClassNames', [0; 1]);

% Create the result struct with predict function
predictorExtractionFcn = @(x) array2table(x, 'VariableNames', predictorNames);
svmPredictFcn = @(x) predict(classificationSVM, x);
trainedClassifier.predictFcn = @(x) svmPredictFcn(predictorExtractionFcn(x));

dataSVM=classificationSVM;
end


% % Perform cross-validation
% partitionedModel = crossval(trainedClassifier.ClassificationSVM, 'KFold', 5);
% 
% % Compute validation predictions
% [validationPredictions, validationScores] = kfoldPredict(partitionedModel);
% 
% % Compute validation accuracy
% validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError')