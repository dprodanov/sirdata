%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIR Outbreak Model analysis package
%
% SIROM
% (c) Dimiter Prodanov, 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result=is6half(x, g, bb, branch)
% result=is6half(x, g, bb)
% branch -1, rising part, +1 - falling part, 0 - both branches
% g - alpha/gamma
% bb - peak value
%
% inversion by Newton iteration
 niter=16;
 tol=1e-15;
 n=length(x);
 result=zeros(1,n);
   for i=1:n 
    if x(i)==0 
        result (i)= bb; % g*log(g)-g+a;
    elseif x(i)>0
        if branch ==0 || branch ==1
            result (i)= rbranch(x(i), g, bb, niter, tol);
        elseif branch==-1
             result (i)=bb;
        end
    else 
        if branch ==0 || branch ==-1
            result (i)= lbranch(x(i), g, bb, niter, tol);
        elseif branch==1
             result (i)=bb;
        end
    end 
   end
end   


function w=rbranch(x, g,  bb, niter, tol)
w = sirapprox2(x, g, bb);
i=0;
err=w+2;
%a=-g*log(g)+g+bb;
while i<niter && abs(err-w)>tol
    err=w;   
    %arg=-exp((w-a)/g)/g;
    arg=-exp(w/g-bb/g-1);
	da=lambertw(0, arg);	
    df=sir3(w, g, bb, 0);
    w=w+ w.*(da+1).*(df-g*x);
    i=i+1;
end
 
end

function w=lbranch(x, g,  bb, niter, tol)
w = sirapprox2(x, g, bb);
i=0;
err=w+2;
%a=-g*log(g)+g+bb;
while i<niter && abs(err-w)>tol
    err=w;   
    %arg=-exp((w-a)/g)/g;
    arg=-exp(w/g-bb/g-1);
	da=lambertw(-1,arg);	
    df=sir3(w, g, bb, -1);
    
    w=w+ w.*(da+1).*(df-g*x);
    i=i+1;
end
 
end

