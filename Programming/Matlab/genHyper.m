% genHyper - Evaluation of an arbitrary order hypergeometric function
%{
%-------------------------------------------------------------------------------
% SYNTAX:
%   [f,g,err] = genHyper(a,b,z,<tol>,<maxIter>)
%
%   tol and maxIter can be given in any order. It is assumed that inputs less
%   than 1 are a tolerance. Otherwise max iterations is assumed.
%
% PURPOSE:
%   This function is made to deal with a hyper geometric function of arbitrary
%   order.
%
% INPUTS:
%   a       - one of two sets of parameters, an array of any size or empty
%   b       - the other set of parameters
%   z       - the values to evaluate the function at, a nonempty array
%   tol     - the absolute error to calculate within (default = 1e-6)
%   maxIter - the most number of iterations before divergence is assumed
%             (default = 1e5)
%
% OUTPUTS:
%   f       - the function evaluation (all outputs given in size of z)
%   g       - the derivative w.r.t. z2^
%   err     - the error in the function evaluation
%
% NOTES:
%   This function, where it converges, is amazingly robust and general. For
%   example:
%   beta(a,b) = genHyper([a+1,1-b],b+1,1)/a
%   exp(x) = genHyper(c,c,x) for any array c
%   log(1+x) = x*genHyper([1,1],2,-x)
%   (1-z)^a = genHyper(a,[],z)
%   So as you can see it can represent special functions as well as exponentials
%   polynomials and logarithms, so basically everything.
%
% ASSUMPTIONS
%   This function uses the series defintion of a hypergeometric function. It
%   will attempt to detect if the series doesn't converge, but in those cases it
%   cannot evaluate.
%
%   We also assume that Taylor series error is good enough for these series.
%   This seems by and large to be a very good assumption.
%-------------------------------------------------------------------------------
%}

function [f,g,err] = genHyper(a,b,z,tol,maxIter)

if nargin==3
    tol=1e-6;
    maxIter = 1e5;
elseif nargin==4
    if tol<=1
        maxIter = 1e5;
    else
        maxIter = tol;
        tol = 1e-6;
    end
end

if nargout>1
    g = prod(a)/prod(b)*genHyper(a+1,b+1,z,tol,maxIter);
end

a = col(a);
b = col(b);

comp = a==b;
% delete any parameters that exist in both a and b.
if any(comp)
    a(comp)=[];
    b(comp)=[];
end

A = length(a);
B = length(b);
% empty params are hard, so don't do it
params = [a; b]';
if (A==0)||(B==0)
    if A==B
        params = [1 1];
    else
        params = [1 params 1];
    end
    A = A+1;
    B = B+1;
end

zSize = size(z);
z = col(z);
N=length(z);
result=ones(N,1);

% calculate 0th term
% pochH = ones(1,3)         (q)_0 = 1 (pochhammer notation)
% term = 1;                 % the 0th term will be 1
err = 1;

% setup first iteration
iter = 1;
logZ = log(z);
zToIter = logZ;             % log(z^iter)
iterFac = log(1);           % log(iter!); obviously log(1) = 0
logParams = log(params);
pochH = ones(N,1)*logParams;% (q)_1 = q

% loop until Taylor series error is less than tol, but use that term anyway.
% the multiplicitve terms are carried in a log space.
while any(err > tol)
    % current term
    term = exp((sum(pochH(:,1:A),2)) - sum(pochH(:,A+1:A+B),2) +...
        (zToIter)-iterFac);
    
    % error is maximized by choosing z = z^iter = 1
    %err = exp(sum(pochH(:,1:A),2) - sum(pochH(:,A+1:A+B),2) - iterFac);
    % for now lets assume that the true err about equal to term
    err = abs(term);
    result = result + term;
    
    % setup next iteration
    iter = iter + 1;
    zToIter = zToIter + logZ;
    iterFac = iterFac + log(iter);
    pochH = pochH + log(params + (iter - 1));      
    
    % don't let it iterate forever.
    if iter == maxIter
        warning(['The series probabaly doesn''t converge for at least one',...
            ' input value'],'genHyper:seriesNoConverge');
        f = reshape(real(result),zSize);
        err =reshape(real(err),zSize);
        % negative integer params implies that there is a finite number of terms
        if any((params==floor(params))&(params~=abs(params)))
            err = zeros(size(err));
        end
        return
    end
end

f = reshape(real(result),zSize);
err = reshape(real(err),zSize);
% Any negative integer params imply that there is a finite number of terms
if any((params==floor(params))&(params~=abs(params)))
    err = zeros(size(err));
end
end
