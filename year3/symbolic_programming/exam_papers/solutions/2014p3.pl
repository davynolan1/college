s --> zeros(N), ones(M), twos(O), {O is N+M}.

zeros(0) --> [].
zeros(N) --> [0], zeros(N0), {N is N0+1}.

ones(0) --> [].
ones(N) --> [1], ones(N0), {N is N0+1}.

twos(0) --> [].
twos(N) --> [2], twos(N0), {N is N0+1}.

sb --> [0], sb, [2].
sb --> ab.
ab --> [1], ab, [2].
ab --> bb.
bb --> [].