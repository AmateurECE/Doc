function x= GEPP3(A,b)
%Solves the matrix equation Ax=b
%   x=GEPP3(A,b)
%A is an n by n matrix and b is a column vector of length n. This program
%implements Gaussian elimination and back substitution so that both
%operations are vectorized and column oriented.

%Gaussian Elimination
M=[A,b];
n=length(A(1,:));
for i=1:n-1
    [m,ii]=max(abs(M(i:n,i)));
    ii=ii+i-1;
    if m==0
        error('The matrix is singular')
    end
    tmp=M(ii,:);
    M(ii,:)=M(i,:);
    M(i,:)=tmp;
    M(i+1:n,i)=M(i+1:n,i)./M(i,i);
    for j=i+1:n+1
        M(i+1:n,j)=M(i+1:n,j)-M(i+1:n,i).*M(i,j);
    end
end

%Back sub
if M(n,n)==0
    error('the matrix is singular')
end
for i=n:-1:1
    M(i,n+1)=M(i,n+1)-M(i,i+1:n)*M(i+1:n,n+1);
    M(i,n+1)=M(i,n+1)/M(i,i);
end
x=M(:,n+1);
end