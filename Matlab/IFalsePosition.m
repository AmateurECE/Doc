function x=IFalsePosition(f,a,b,pflag,Tol,fTol)
% uses the Illinois variant of the false position method to find a root of a function
%
%   x=IFalsePosition(f,a,b,pflag,tol,ftol)
%
% IFalsePosition finds a root of f on (a,b) using the Illinois variant of the false position method within a
% tolerance of Tol or within a function tolerance of fTol. It displays the
% root as x. There are three options for output, toggled by pflag: If
% pflag=0, there is no output. If pflag=1, the final error bound and the
% final estimate of x, as well as the interval the root could be in. If
% pflag=2, IFalsePosition displays as if pflag=1 as well as the interval,
% current estimate, and current error bound on each iteration

%this checks that a and b are suitable values for the Illinois false position method.
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

%allows pflag, Tol, and fTol to be optional inputs and redefines Tol if it
%unrealistically small.
if nargin<6
    fTol=1e-12;
end
if nargin<5||Tol<2.3e-16*max(abs(a),abs(b))
    Tol=2.3e-16*max(abs(a),abs(b));
end
if nargin<4
    pflag=0;
end

%this applies the Illinois false position method until the error bound is achieved or the
%program is iterated 100 times.
k=0;
errbnd=b-a;
fc=1e300;
lastchange=0;
while errbnd>Tol&&abs(fc)>fTol
    c=b-((fb*(b-a))/(fb-fa));
    k=k+1;
    fc=f(c);
    if fc*fa>0
        errbnd=b-c;
        a=c;
        fa=fc;
        if lastchange=='a'
            fb=0.5*fb;
        end
        lastchange='a';
    elseif fc*fb>0
        errbnd=c-a;
        b=c;
        fb=fc;
        if lastchange=='b'
            fa=0.5*fa;
        end
        lastchange='b';
    elseif k==100;
        x=c;
        return
    else
        x=c;errbnd=0;
        break
    end
    if pflag==2
        fprintf(1,'[%1.8e,%1.8e], current estimate: %1.8e error bound: %.4e \n',a,b,c,errbnd);
    end
end
if pflag>=1
    fprintf(1,'\n[%1.8e,%1.8e], best estimate: %1.8e smallest error bound: %.4e \n',a,b,c,errbnd);
end
x=c;
end