%x = -pi:0.01:pi;
figure(10)
clf
x = 0:1:1024;
k=50
size(x)
plot(x,sin(x*2*pi*k/1024))
grid on
