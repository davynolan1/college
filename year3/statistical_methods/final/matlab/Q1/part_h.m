% Question 1 (h)

n = 5;
N = 1000;
topics = 1:10;
y =  stochastic_sim(n,N);

function Y = stochastic_sim(n, N)
    X = [];
    qP = [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
    nP = [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
    last_year = [];
    for run_count=1 : N
        for i=1 : length(last_year)
            qP(last_year(i)) = 0.2;
            nP(last_year(i)) = 1;
        end
    
        n_topics = datasample(1:10, n, 'Replace', false, 'Weights', nP);
        q_topics = datasample(1:10, 3, 'Replace', false, 'Weights', qP);
        last_year = q_topics;
        qP = [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
        nP = [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
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

