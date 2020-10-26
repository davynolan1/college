
function [L,A]=LUdecompGauss(A)
[m,n] = size(A);
L=eye(n);
for k=1:n
    if (A(k,k) == 0) 
        Error('Pivot required'); 
    end
    L(k+1:n,k)=A(k+1:n,k)/A(k,k);
    for j=k+1:n
        A(j,:)=A(j,:)-L(j,k)*A(k,:);
    end
end

