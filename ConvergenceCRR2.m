function ConvergenceCRR2(S,K,r,T,vol,q,IsCall,IsOdd)
N=25;
BS=BSPrice(S,K,r,T,vol,q,IsCall);
%Pre-allocate memory
CRRaprox=zeros(1,N);
%Price by steps 
    for k = 1:N
        CRRaprox(k)= EuroCRR(S,K,r,T,vol,q,2*k+IsOdd,IsCall);
    end
X=2+IsOdd:2:2*N+IsOdd;    
plot(X,BS*ones(1,N));
hold on;
plot(X,CRRaprox);
hold off;
end
