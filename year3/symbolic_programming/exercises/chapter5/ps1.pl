accMax([H|T],A,Max)  :-
    H  >  A,
    accMax(T,H,Max).
   
accMax([H|T],A,Max)  :-
    H  =<  A,
    accMax(T,A,Max).
   
accMax([],A,A). 

min([H|T], A, R) :-
    H < A,
    min(T, H, R).
min([H|T], A, R) :-
    H >= A,
    min(T, A, R).
min([], R, R).

min([H|T], R) :-
    min(T, H, R).