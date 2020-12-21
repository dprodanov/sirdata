%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIR Outbreak Model analysis package
%
% SIROM
% (c) Dimiter Prodanov, 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y=is6deivp1(x, g, s0,i0)
% y=is6deivp1(x, g, s0,i0)
    tm = sirtmax(g, s0, i0) +x(1);
    fun=@(t,y) ker(t, y, g, s0, i0, tm);
    options = odeset('RelTol',1e-12,'AbsTol',1e-15);
    [~, y] = ode45( fun, x, i0, options);   
end

function dydt=ker(t, u, g, s0, i0, tm)
    n=length(t);
    dydt=zeros(1,n);
    nn=s0+i0;
    for i=1:n
        arg=(u(i)-nn)/g;
        uarg=-s0/g;
        if t(i)>tm
            branch=0;
        else
            branch=-1;
        end
        dydt(i)=-g*u(i)*real(lambertw( branch, uarg* exp(arg) ) +1 );
    end
end
