function Price=Binomial(S,K,r,T,vol,q,N,IsCall,IsAmer,Method)
%Ware house of different binomial methods for u,d, and p
%Return price for specific binomial method
dT= T/N;
if strcmp(Method,'EQP')
    %Eql Probability model
     p=0.5;
    u=exp((r-q-(vol^2)/2)*dT+vol*sqrt(dT));    
     d=exp((r-q-(vol^2)/2)*dT-vol*sqrt(dT));    
elseif strcmp(Method,'LR')
    %LR Model
    h=@(z,n)0.5+sign(z)*(0.25-0.25*exp(-((z/(n+1/3))^2)*(n+1/6)))^.5;
    d1=(log(S/K)+(r-q+0.5*vol^2)*T)/(vol*T^.5);
    d2=d1-vol*dT^.5;
    r1=exp((r-q)*dT);
    
    p=h(d2,N);
    p_=h(d1,N);
    u=r1*p_/p;
    d=(r1-p*u)/(1-p);
else 
    %CRR
    u=exp(vol*dT^.5);   
    d=1/u;
        if strcmp(Method,'TIAN')   
        %Strike exactly on Node - TIAN    
        j=ceil((log(K/S)- N*log(d))/(log(u/d)));   
        tilt=(K/(S*(u^j)*(d^(N-j))))^(1/N);  
        u=u*tilt; 
        d=d*tilt;  
        end
    p=(exp((r-q)*dT)-d)/(u-d);
end
%Separate Tree @ u,d, p
Price=BinomialTree(S,K,r,T,u,d,p,N,IsCall,IsAmer);
end