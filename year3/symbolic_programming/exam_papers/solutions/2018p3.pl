%s --> as(N), bs(O), cs(M), {O is N+M}.

%as(0) --> [].
%as(N) --> [a], as(N0), {N is N0+1}.

%bs(0) --> [].
%bs(N) --> [b], bs(N0), {N is N0+1}.

%cs(0) --> [].
%cs(N) --> [c], cs(N0), {N is N0+1}.



