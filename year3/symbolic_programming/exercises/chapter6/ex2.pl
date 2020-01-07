grab([],R, 0, A) :- 
    reverse(A, R).

grab([H|T], List, N, A) :-
    N1 is N - 1,
    grab(T, List, N1, [H|A]).

palindrome(L) :-
    length(L, Len),
    grab(L, L, Len, []).