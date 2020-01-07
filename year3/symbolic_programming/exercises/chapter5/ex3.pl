addone([], []).
addone([H|T], [Hx|Tx]) :-
    Hx is H + 1,
    addone(T, Tx).

