if-then-else(A,B,C) :-
    A, !,
    B;
    C.

no-duplicates([],[]).
no-duplicates([H|T],L2) :- \+member(H,T), no-duplicates(T,L2)