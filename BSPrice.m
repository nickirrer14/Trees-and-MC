function Price = BSPrice(S,K,r,T,vol,q,IsCall)  
d1=(log(S/K)+(r-q+0.5*vol^2 )*T)/(vol*T^0.5);
d2=d1-vol*sqrt(T);
    
    if IsCall
        Delta=exp(-q*T)*normcdf(d1);
        Price=S*Delta-K*exp(-r*T)*normcdf(d2);
        
    else
        Delta=-exp(-q*T)*normcdf(-d1);
        Price=K*exp(-r*T)*normcdf(-d2)+S*Delta;
    end  
        
end