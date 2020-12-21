%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIR Outbreak Model analysis package
%
% SIROM
% (c) Dimiter Prodanov, 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function zz=sirapprox2(x, g, bb)
% zz=sirapprox(x, g, bb)
%bb=g*log(g)-g+a;
%cc=1.0;
if (g>=1.0)
    cc=sqrt(2.0*bb*g);
else
    cc=sqrt(exp(-1)*2.0*bb*g*2.0);
end
    if (x>0) 
        cc=cc*exp(-0.5); 
    end
    zz=bb*exp(1.0-exp(-x*cc)-x*cc); 
end