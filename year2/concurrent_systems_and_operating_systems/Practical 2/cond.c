
int cond1(int n) { return ((n/2)*2!=n); }
/*
    1   1
    2   0
    3   1
    4   0
    5   1
    6   0
    7   1
    8   0
    9   1
    10  0
    11  1
    12  0
    13  1
    14  0
    15  1
    16  0
    17  1
    18  0
    19  1
    20  0
    0
    csum = 100
*/
int cond2(int n) { return ((n/2)*2==n); }
/*
    1   0
    2   1
    3   0
    4   1
    5   0
    6   1
    7   0
    8   1
    9   0
    10  1
    11  0
    12  1
    13  0
    14  1
    15  0
    16  1
    17  0
    18  1
    19  0
    20  1
    0
    csum = 110
*/
int cond3(int n) { return ( n % 3 == 0 ); }
/*
    1   0
    2   0
    3   1
    4   0
    5   0
    6   1
    7   0
    8   0
    9   1
    10  0
    11  0
    12  1
    13  0
    14  0
    15  1
    16  0
    17  0
    18  1
    19  0
    20  0
    0
    csum = 72
*/
