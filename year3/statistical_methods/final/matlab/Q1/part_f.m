% Question 1 (f)
n = 5;
N = 1000;
y =  stochastic_sim(n, N);  
exp = exp3(n);
EXi = 1- exp;  %mean
std_dev = sqrt(y - (y^2));  %standard deviation
clt_higher = EXi + (2 * (std_dev / sqrt(N)));
clt_lower = EXi - (2 * (std_dev / sqrt(N)));

function Y = stochastic_sim(n, no_of_runs)
    X = [];
    for N=1 : no_of_runs
        n_topics = randsample(1:10,n,false);
        q_topics = randsample(1:10,3,false);
        same_topics = 0;
        for i=1 : n
            for j=1 : length(q_topics)
                if n_topics(i) == q_topics(j)
                    same_topics = same_topics+1;
                end
            end
        end

        if same_topics < 2
            X = [X, 0];
        else
            X = [X, 1];
        end
    end
    Y = sum(X)/N;
end


function x = choose(n,k)
    x = factorial(n)/(factorial(k)*factorial(n-k));
end

function y1 = exp3(n)
    if n < 8
        y1 = ((choose(n,1)*choose(10-n,2))/120) + ((choose(10-n,3))/120);
    elseif n == 8
        y1 = ((choose(n,1)*choose(10-n,2))/120);
    else 
        y1 = 0;
    end
end
