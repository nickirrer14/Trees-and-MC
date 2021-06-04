function Price=CRR(S,K,r,T,vol,q,N,IsCall,IsAmer)
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
        Tree(i,j)=(p*Tree(i+1,j+1)+(1-p)*Tree(i,j+1))*exp(-r*dT);
        if IsAmer
            Tree(i,j)=max(Tree(i,j),Intrinsic(S*(u^(i-1))*(d^(j-i))));
        end
    end
end
Price=Tree(1,1);
end