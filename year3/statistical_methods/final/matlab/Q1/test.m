
n = 4;
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
    X = 0;
else
    X = 1;
end