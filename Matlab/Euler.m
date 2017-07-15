function [x,t] = Euler(f,t0,tf,x0,n)
%Estimates the solution of an IVP for a first order ODE using
%Euler's method
%   [x,t]=Euler(f,t0,tf,x0,n)
%
%Euler solves the IVP of x'=f(t,x) for x0'=f(t0,x0) on the interval
%[t0,tf] with n iterations.

x=zeros(n+1,1);
x(1)=x0;
t=linspace(t0,tf,n+1)';
dt=(tf-t0)/n;
for i=2:n+1
    x(i)=x(i-1)+dt*f(t(i-1),x(i-1));
end
end