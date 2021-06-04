function ConvergenceCRR(S,K,r,T,vol,q,IsCall)
N=50;
BS=BSPrice(S,K,r,T,vol,q,IsCall);
%Pre-allocate memory
CRRaprox=zeros(1,N);
%Price by steps
    for k=1:N
        CRRaprox(k)=EuroCRR(S,K,r,T,vol,q,k,IsCall);
    end
X=1:N;    
plot(X,BS*ones(1,N));
hold on;
plot(X,CRRaprox);
hold off;  
end