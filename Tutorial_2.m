clc
clear

x = [1 1;-0.5 1;3 1;-2 1];
d = [1 -1 1 -1];
w = [-2.5; 1.75];
c = 2;
pr = [];
cr = [];

for i = 1:1000
   e = 0;
    for j = 1:4
       v = w' * x(j,:)';
       z = (1-exp(-v))/(1+exp(-v));
       
       df = 0.5*(1-z^2);
       
       r = (d(j) -z)*df;
       delta_w = c * r * x(j,:);
       w = w + delta_w'
       p = 0.5*(d(j)-z)^2;
       e = e+0.5*(d(j)-z)^2;
       pr = [pr p];
    end
    cr = [cr e];
end

w

figure(1)
plot(pr(1:40))
xlabel('pattern number')
ylabel('pattern error')
figure(2)
plot(cr(1:10))
xlabel('cycle number')
ylabel('cycle error')