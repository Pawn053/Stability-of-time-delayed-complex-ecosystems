function plot_ellipse(x0,y0,a,b,theta)
%%  说明
%本程序画一个中心在（x0，y0)处的椭圆，其长短轴分别为a,b,椭圆沿Z轴转theta角
%%
% x0=1;
% y0=1;
% a=2;
% b=1;
% theta=pi/3;
%%
num_t=1e5;
t=linspace(2,num_t+1,num_t);
x=x0+a*cos(2*pi/num_t*t)*cos(theta)-b*sin(2*pi/num_t*t)*sin(theta);
y=y0+a*cos(2*pi/num_t*t)*sin(theta)+b*sin(2*pi/num_t*t)*cos(theta);
global h1; %特殊用处，可删除
h1=plot(x,y,'k','LineWidth',3);  %特殊用处，可删除
end