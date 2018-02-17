function [x,u,t]=linRK4(f,df,t0,tf,x0,n)
%Solves the IVPs x'=f(x), x(t0)=x0 and u'=f'(x(t))*u for the specific purpose of use in
%ODEfun1a.m
%
%   [x,u,t]=linRK4(f,df,t0,tf,x0,n)

dt=(tf-t0)/n;
t=linspace(t0,tf,n+1);
x=zeros(1,n+1);
u=zeros(1,n+1);
x(1)=x0;
u(1)=1;
for i=2:n+1
    m1=f(x(i-1));
    m2=f(x(i-1)+0.5*dt*m1);
    m3=f(x(i-1)+0.5*dt*m2);
    m4=f(x(i-1)+dt*m3);
    x(i)=x(i-1)+(dt/6)*(m1+2*m2+2*m3+m4);
    k1=df(x(i-1))*u(i-1);
    k2=df(x(i-1)+0.5*dt*m1)*(u(i-1)+0.5*dt*k1);
    k3=df(x(i-1)+0.5*dt*m2)*(u(i-1)+0.5*dt*k2);
    k4=df(x(i-1)+dt*m3)*(u(i-1)+dt*k3);
    u(i)=u(i-1)+(dt/6)*(k1+2*k2+2*k3+k4);
end
x=x';
u=u';