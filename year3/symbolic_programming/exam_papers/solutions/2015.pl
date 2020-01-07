
member(X, [H|T]) :- X==H; member(X, T).

last(X, [X|[]]).
last(X, [_|T]) :- last(X,T).

multiple(X, L) :- 
    findall(X, member(X,L), XList),
    length(XList,XLen),
    XLen >= 2.

next(A,B,[X,Y|T]) :- 
    consecutive(A,B,X,Y);
    next(A,B,[Y|T]).

consecutive(A,B,X,Y) :-
    A == X,
    B == Y.