%% Question 1
clc
clear
x = [0.4 0.8 0.2 0.3 0.2 1;
     1 0.2 0.5 0.7 -0.5 1;
     -0.1 0.7 0.3 0.3 0.9 1;
     0.2 0.7 -0.8 0.9 0.3 1;
     0.1 0.3 1.5 0.9 1.2 1];
 
d = [1 -1 1 -1 1];
c = 2;
w = [0.3350 0.1723 -0.2102 0.2528 -0.1133 0.5012]';
numCycles = 10;
numPatterns = 5;
pr = [];
cr = [];
wMatrix =[];

for i = 1:numCycles
   e = 0;
    for j = 1:numPatterns
       v = w'*x(j,:)';
       z = sign(v);
       r = d(j) - z;
       delta_w = c * r * x(j,:);
       w = w + delta_w';
       wMatrix = [wMatrix w]; 
       p = 0.5*(d(j)-z)^2;
       e = e+0.5*(d(j)-z)^2;
       pr = [pr p];
    end
    cr = [cr e];
end
 
w

figure(1)
plot(pr(1:5))
xlabel('pattern number')
ylabel('pattern error')
figure(2)
plot(cr(1:10))
xlabel('cycle number')
ylabel('cycle error')

%% Question 2
clc
clear

x = [0.4 0.8 0.2 0.3 0.2 1;
     1 0.2 0.5 0.7 -0.5 1;
     -0.1 0.7 0.3 0.3 0.9 1;
     0.2 0.7 -0.8 0.9 0.3 1;
     0.1 0.3 1.5 0.9 1.2 1];
 
d = [1 -1 1 -1 1];
c = 0.2;
w = [0.3350 0.1723 -0.2102 0.2528 -0.1133 0.5012]';
numCycles = 50;
numPatterns = 5;
pr = [];
cr = [];
wMatrix = [];

for i = 1:numCycles
   e = 0;
    for j = 1:numPatterns
        v = w'*x(j,:)';
        z = (1-exp(-v))/(1+exp(-v))
        df = 0.5*(1-z^2);
        r = (d(j) - z) * df;
        delta_w = c * r * x(j,:);
        w = w + delta_w';
        wMatrix = [wMatrix w];
        p = 0.5*(d(j)-z)^2;
        e = e+0.5*(d(j)-z)^2;
        pr = [pr p];
    end
    cr = [cr e];
end

figure(1)
plot(pr(1:255))
xlabel('pattern number')
ylabel('pattern error')
figure(2)
plot(cr(1:numCycles))
xlabel('cycle number')
ylabel('cycle error')

%% Question 3
clc
clear

X = [0.2 0.5 0.8 1 0.6 0.1];
Y = [0.3 0.6 0.9 1 0.6 0.3];

dX = [0.3 0.6 0.7 0.9 1 0.5];
matrix = [];

for i = 1:size(X,2)
   valX = X(i)
   
   for j = 1:size(Y,2)
      valY = Y(j)
      if valX > valY
          matrix(i,j) = valY;
      else
          matrix(i,j) = valX;          
      end
   end
end
    
matrixMin = [];

for i = 1:size(dX,2)
    for j = 1:size(matrix,2) %column
        for k = 1:size(matrix,1) %row
            valdX = dX(k);
            val_matrix = matrix(k,j);
            matrixMin(k,j) = dot(valdX,val_matrix); %min/dot(max product composition)
        end
    end    
end

S = max(matrixMin)
