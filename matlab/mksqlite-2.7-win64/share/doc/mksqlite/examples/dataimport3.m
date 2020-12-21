
%%

% Open the DB file
mksqlite('open', 'C:\sqlite\corona.db');
mksqlite('show tables')

countries= mksqlite('select * from countries');


%%
geoid=countries(32).geoId

% Query the database
results = mksqlite(['select * from coronalite where geoId="',geoid,'" order by year,month,day asc;']);
%yy = [results.deaths];
yy1  = [results.cases];

ym1=movmean(yy1,3);

%%
tfr=10;

%yy mortality
tt=0:length(yy1)-1;
tt1=tt/tfr;

%%
tt0=8.3;
[tta, yya]=splitbyval(tt1, yy1, [0, tt0]);

%%

format long;

nm=max(yya)
ind=find(yya==nm);
tm=tta(ind)
hguess=1.5;
sircoeffs=[0.75;hguess;tm;nm/hguess]
%[c3, R2] = is6fit(tta, yya, sircoeffs)
[c3, R2] = is6fitnlsq(tta, yya, sircoeffs)
%%
z3=c3(4)*is6(tt1-c3(3), c3(1), c3(2));
plot(tt1, yy1, tt1, z3);
 
%%
tt01=17.5
[ttb, yyb]=splitbyval(tt1, yy1, [tt0, tt01]);
%%
nm=max(yyb)
ind=find(yyb==nm,1, 'first');
tm=ttb(ind)
sircoeffs1=[c3(1);c3(2);tm;nm/c3(2)]
%%
[c3b, R2] = is6fit(ttb, yyb, sircoeffs1)
%[c3b, R2] = is6fitnlsq(ttb, yyb, sircoeffs)
%%
z3b=c3b(4)*is6(tt1-c3b(3), c3b(1), c3b(2));
plot(tt1, yy1, tt1, z3, tt1, z3b);
%%
tt02=length(tt1);
[ttc, yyc]=splitbyval(tt1, yy1, [tt01, tt02]);

nm=max(yyc)
ind=find(yyc==nm);
tm=ttc2(ind)

ys=cumtrapz(ttc, yyc);
sircoeffs2=[c3b(1);c3b(2);tm;nm/c3b(2);0]
% [c3c, R2]=ris6fit(ttc, ys, sircoeffs2)

%sircoeffs2=[c3(1);c3b(2);tm;nm/c3b(2)]
%%
[c3c, R2] = ris6fit2(ttc, ys, sircoeffs2,1)
%%

z3c=c3c(4)*is6(tt1-tt01-c3c(3), c3c(1), c3c(2));
%z3b=c3b(4)*is6(tt1-c3b(3), c3b(1), c3b(2));
plot(tt1, yy1, tt1, z3, tt1, z3b, tt1, z3c);
xlabel(['days x', mat2str(tfr)])
title(['COVID-19 mortality in ', geoid,' since 31 Dec 2019']);
% Cleanup
%mksqlite('close');

%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%