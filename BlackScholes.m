function Result = BlackScholes(S,K,T,r,vol,q,IsCall,Result)
% Carries out Black-Scholes calculations for European options on stocks, 
% stock indices, currencies and futures
%   >>><<<
%   S         Asset Price
%   K         Strike price
%   T         Time to maturity (yrs)
%   r         Domestic risk-free rate
%   vol       Volatility. BUT Enter Price if Implied Volatility (Result=7)
%   q         (i) Dividend yield for stock index options, 
%             (ii) foreign risk free rate for currency options
%             (iii) Enter q = r domestic risk-free rate for futures options
%   IsCall    1 if call, 0 if put
%   Result    0=Price; 1=Delta (per $); 2=Gamma (per $ per $);
%             3=Vega (per %); 4=Theta (per day); 5=Rho (per basis point); 
%             6=Psi (per %); 7=Implied Vol
%   >>><<<    
    switch Result  
        case 0 % Price            
            Result = BSPrice(S,K,T,r,vol,q,IsCall);        
        case 1 % Delta            
            Result = BSDelta(S,K,T,r,vol,q,IsCall);        
        case 2 % Gamma            
            Result = BSGamma(S,K,T,r,vol,q);        
        case 3 % Vega            
            Vega = BSVega(S,K,T,r,vol,q);            
            % Vega per % requires dividing by 100:            
            Result = Vega/100;        
        case 4 % Theta            
            Theta = BSTheta(S,K,T,r,vol,q,IsCall);           
            % Theta per day requires dividing by 365            
            Result = Theta/365;        
        case 5 % Rho            
            Rho = BSRho(S,K,T,r,vol,q,IsCall);            
            % Rho per basis point requires dividing by 10,000            
            Result = Rho/10000;        
        case 6 % Psi            
            Psi = BSPsi(S,K,T,r,vol,q,IsCall);            
            % Psi per % requires dividing by 100:            
            Result = Psi/100;        
        case 7 % Implied vol            
            Result = BSImpliedVol(S,K,T,r,vol,q,IsCall);    
    end
    
% Script M-file: BlackScholesPlot2D
%   >>><<<
% Initial Values
S= 50;
K= 50; 
T= 1;
r= 0.05; 
vol= .20;
q= .02;
IsCall=1;
%   >>><<<
% Plot Results 0-6 from BlackScholes.m
% Vertical Axis: Transition through Results
ChangeLabel = {'Price' 'Delta(per $)' 'Gamma(per $ per $)' ...
'Vega (per %)' 'Theta (per day)' 'Rho per basis point)' 'Psi (per %)'};
for Result = 0:6    
    % Horizontal Axis    
    h = @(S) BlackScholes(S,K,T,r,vol,q,IsCall,Result);    
    % 2D Plot    
    [x,y] = fplot(h,[10 90]);    
    plot(x,y,'--r','LineWidth',2);     
    xlabel('Stock Price');    
    ylabel(ChangeLabel(Result+1));    
    title('Option Price Sensitivity');    
    grid on;    
    % Press any key to advance to next plot:    
    if (Result < 6), pause, end
end