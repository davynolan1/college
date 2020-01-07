%b) listSum(+List, ?Sum)
listSum(L,S) :- accLSum(L,0,S).
accLSum([],S,S).
accLSum([H|T],Acc,S) :- NewA is Acc+H, accLSum(T,NewA,S).
%c) listProd(+List, ?Prod)
listProd(L,S) :- accLProd(L,1,S).
accLProd([],S,S).
accLProd([H|T],A,S) :- NewA is A*H, accLProd(T,NewA,S).
%d) list2N(+Int, ?List)
list2N(0,[]).
list2N(X,[X|T]) :- NX is X-1, NX >= 0, list2N(NX, T).
%e) nonInc(+List)
nonInc([_]).
nonInc([H,H2|T]) :- H>=H2, nonInc([H2|T]).
%f) sumList(+Sum, ?List)
sumList(0,[]).
sumList(N, [X|L]) :- list2N(N, List), member(X, List), Nnew is N-X, sumList(Nnew, L), nonInc([X|L]).

subset([],_).
subset([H|T], L2) :- member(H,L2), subset(T,L2).

setEq(L1,L2) :- subset(L1,L2), subset(L2,L1).

setEq2(L1,L2) :- setof(C,member(C,L1),S), setof(B,member(B,L2),S).

nonmember(X, L) :- \+member(X,L).

setInt(L1,L2,LBoth) :- 
    append(L1,L2,LConcat),
    setEq(LConcat, LBoth).

setInt2(L1,L2,LBoth) :-
    append(L1,L2,LConcat),
    setEq2(LConcat,LBoth).

if(A,B,C) :-
    A, !, % if a
    B;    % then b
    C.    % else c

max(X, [X]).
max(H, [H|T]) :- max(M, T), H >= M.
max(M, [H|T]) :- max(M, T), H < M.

remMax(H, [H|T], T).
remMax(X, [H|T], [H|T2]) :- remMax(X, T, T2).

maxHead(L1, [H|T]) :- max(H, L1), remMax(H, L1, T).

maxHead2([H|T], Result) :- accmaxHead2(H, [], T, Result).

accmaxHead2(H, S, [], [H|S]).
accmaxHead2(C, S, [H|T], Result) :- C >= H, !, accmaxHead2(C, [H|S], T, Result);
                              accmaxHead2(H, [C|S], T, Result).