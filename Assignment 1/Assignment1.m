%% Question 1 MATLAB CODE
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

for i = 1:numCycles
   e = 0;
    for j = 1:numPatterns
       v = w'*x(j,:)';
       z = sign(v);
       r = d(j) - z;
       delta_w = c * r * x(j,:);
       w = w + delta_w';
       p = 0.5*(d(j)-z)^2;
       e = e+0.5*(d(j)-z)^2;
       pr = [pr p];
    end
    cr = [cr e];
end

figure(1)
plot(pr(1:50))
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
numCycles = 51;
numPatterns = 5;
pr = [];
cr = [];
wMatrix = [];

for i = 1:numCycles
   e = 0;
    for j = 1:numPatterns
        v = w'*x(j,:)';
        z = (1-exp(-v))/(1+exp(-v));
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


