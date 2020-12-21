function tm=sirtmax(g, s0, i0)
   warning off;
   tol=1e-15;
   fun = @(u) 1./( -(s0+i0) + s0*exp(u) -g*u );
   tm=integral(fun, 0, log(g/s0), 'RelTol',tol,'AbsTol',1e-8);
end
  