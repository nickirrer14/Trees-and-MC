function Price=CRR2(S,K,r,T,vol,q,N,IsAmer)
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
%Allocate Memory
Tree=zeros(N+1,N+1);
%Intrinsic value @ expiration
for i=0:N
    Tree(i+1,N+1)=Intrinsic(S*(u^i)*(d^(N-i)));
end
%Work back through tree
for j=N:-1:1
    for i =1:j
        Tree(i,j)=max(IsAmer*Intrinsic(S*(u^(i-1))*(d^(j-i))),(p*Tree(i+1,j+1)+(1-p)*Tree(i,j+1))*exp(-r*dT));
    end
end
Price=Tree(1,1);
end
