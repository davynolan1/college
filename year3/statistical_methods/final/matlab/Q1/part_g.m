% Question 1 (g)
n = 7;
N1 = 1000;
N2 = 10000;
clt_l_1000 = 0.7923;
clt_h_1000 = 0.8411;
clt_l_10000 = 0.8090;
clt_h_10000 = 0.8244;

runs = 100;
in_conf_inter_1000 = 0;
in_conf_inter_10000 = 0;


for i=1:runs
    y = stochastic_sim(n, N1);
    
    if y > clt_l_1000 && y < clt_h_1000
        in_conf_inter_1000 = in_conf_inter_1000 + 1;
    end
end
for i=1:runs
    y = stochastic_sim(n, N2);

    if y > clt_l_10000 && y < clt_h_10000
        in_conf_inter_10000 = in_conf_inter_10000 + 1;
    end
end

result_1000 = in_conf_inter_1000/runs;
result_10000 = in_conf_inter_10000/runs;


function Y = stochastic_sim(n, no_of_runs)
    X = [];
    for N=1 : no_of_runs
        n_topics = randperm(10,n);
        q_topics = randperm(10,3);
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
