function [x,errbnd]=Bisection(f,a,b,tol)
% uses the method of bisection to find a root of a function
%[x,errbnd]=Bisection(f,a,b,tol)
% Bisection finds a root of f on (a,b) using the bisection method within a
% tilerance of tol. It displays the root as x and the corresponding error
% bound as errbnd.

%this checks that a and b are suitable values for the bisection method,
%that is, f(a) and f(b) have opposite signs
fa=f(a);
fb=f(b);
if fa*fb>0
    error('f(a) and f(b) must have opposite signs')
elseif fa==0
    x=a;errbnd=0;
    return
elseif fb==0
    x=b;errbnd=0;
    return
end

%this applies the bisection method until an error less than the tolerance is achieved or the
%while loop is iterated 1001 times.
k=0;
fc=1e10;
while abs((b-a)/2)>tol&&abs(fc)>1e-12
    c=(b+a)/2;
    k=k+1;
    fc=f(c);
    if k>1000;
        x=c;
        errbnd=(b-a)/2;
        return
    elseif fc*fa>0
        a=c;
        fa=f(a);
    elseif fc*fb>0;
        b=c;
        fb=f(b);
    else
        x=c;errbnd=0;
        return
    end
    errbnd=(b-a)/2;
    %fprintf(1,'[%.8f,%.8f], current estimate: %.8f error bound: %.4e \n',a,b,c,errbnd);
end
x=c;
end