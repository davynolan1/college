% Question 1 (e)
n = 5;
x =  stochastic_sim(n);

function X = stochastic_sim(n)
X = 0;
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
    X = 0;
else
    X = 1;
end
end
