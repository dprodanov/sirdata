%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIR Outbreak Model analysis package
%
% SIROM
% (c) Dimiter Prodanov, 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result=sir3(x, g, bb, branch)
% result=sir3(x, g, bb, branch)
    warning off;
    tol=1e-15;
    if (branch>=0)
      branch=0;
    else
      branch=-1;
    end
    fr=-g;
   % bb=g*log(g)-g+a;
   % arg=exp((x-a)/g)/g;
    arg=exp((x-bb)/g-1);
    dd=-g*lambertw(branch,-arg);
    %g/(u*(g*log(u)-u+a))
    %a=-g*log(g)+g+bb;
    fun = @(u) 1./(u.*(g*log(u/g)-u+g+bb));
    n=length(x);
    result=zeros(1,n);
    for i=1:n 
      if (x(i)>=0 && x(i)<bb) 
          result(i)= fr*integral(fun, g, dd(i), 'RelTol',tol,'AbsTol',1e-8);
          %result(i)= fr*quadcc(fun,g,dd(i), [tol, 1e-8]);
      end
    end
  
 
end