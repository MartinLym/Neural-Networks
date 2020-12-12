%% Exercise 1
clear all
clc

x = [0 0 0;
    0 0 1;
    0 1 0;
    1 0 0;
    0 1 1;
    1 0 0;
    1 0 1;
    1 1 0;
    1 1 1];

weight = [-1 -1 -1];
input = x;
v1 = input.*weight;

for i = 1:8
    for j = 1:3
        if v1(i,j)>=0
            y(i,j)=1;
        else
            y(i,j)=0;
        end
    end
end

net = y*[1 1 1]';

for i = 1:8
    if net(i)>=1
        o(i)=1;
    else
        o(i)=0;
    end
end
%% Exercise 2
clc
clear all

v = -5:5;
P = 1./(1+exp(-v));
plot(v,P)

%% Exercise 3
clc
clear all
x1 = [1 2];
x2 = [-3 0.5];
x = [x1;x2];

weights = [0.5 1.5]';
net = x*weights;

for i = 1:2
    if net(i)>=0
        o(i)=1;
    else
        o(i)=0;
    end 
end
o=o';
