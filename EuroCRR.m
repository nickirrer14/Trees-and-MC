function Price = EuroCRR(S,K,r,T,vol,q,N,IsCall)
%European CRR Binomial Tree
%Handle Call or Put
    if IsCall
        Intrinsic=@(S)max(0,S-K);
    else
        Intrinsic=@(S)max(0,K-S);
    end      
%CRR
dT=T/N;
u=exp(vol*dT^.5);
d=1/u;
p=(exp((r-q)*dT)-d)/(u-d);
%Binomial Tree
Sum=0;
    for k = 1:N
        Sum=Sum+nchoosek(N,k)*p^k*(1-p)^(N-k)*Intrinsic(S*u^k*d^(N-k));
    end    
Price=exp(-r*T)*Sum;  
end