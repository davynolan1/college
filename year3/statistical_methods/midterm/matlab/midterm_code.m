


























data = readtable('data.txt');
probs = readtable('probabilities.txt');

user0 = data.Var1;
user1 = data.Var2;
user2 = data.Var3;
user3 = data.Var4;

all_times = [user0,user1,user2,user3];
parsed_probs = probs.Var2;

%Q1_a
hist_pmf(user0);

%Q1_b
fprintf("\nQuestion 1 (b)");
fprintf("\nProb(X0 = 1) = %f",mean(user0));

fprintf("\n");

%Q1_c
fprintf("\nQuestion 1 (c)");
con_inter(user0);
con_inter_bstrap(user0);

fprintf("\n");

%Q2
fprintf("\nQuestion 2");
fprintf("\nProb(X1 = 1) = %f",mean(user1));
fprintf("\nProb(X2 = 1) = %f",mean(user2));
fprintf("\nProb(X3 = 1) = %f",mean(user3));

fprintf("\n");

%Q3
fprintf("\nQuestion 3");
fprintf("\nP(Zn > 10) = %f",mean_zn(all_times, parsed_probs));

fprintf("\n");

%Q5
fprintf("\nQuestion 5");
fprintf("\nSimulation P(Zn > 10) = %f",stoc_sim(all_times, parsed_probs, 100000));

function hist_pmf(u_data)
    histogram(u_data, 50,'Normalization', 'pdf');
end

function m = mean(u_data)
    onesCount = 0;
    for n = 1 : length(u_data)
        if u_data(n) > 10
            onesCount = onesCount + 1;
        end
    end

    m = onesCount / length(u_data);
    
end

function con_inter(u_data)
    N = length(u_data);
    m = mean(u_data);
    std_dev = sqrt(m - (m^2));
    
    cheby_higher = m + (std_dev / sqrt(0.05 * N));
    cheby_lower = m - (std_dev / sqrt(0.05 * N));
    
    clt_higher = m + (2 * (std_dev / sqrt(N)));
    clt_lower = m - (2 * (std_dev / sqrt(N)));
    
    fprintf("\nChebyshev .95 confidence interval: %f < X < %f", cheby_lower, cheby_higher);
    fprintf("\nCLT .95 confidence interval: %f < X < %f", clt_lower, clt_higher);
end

function con_inter_bstrap(u_data)
    N = length(u_data);
    S = 1000;
    
    means = [];
    for n = 1: S
        k = 0.2 * N; % 20 percent of dataset with replacement
        sample = randsample(u_data, k);
        means = [means, mean(sample)];
    end
    
    m = sum(means) / length(means);
    std_dev = sqrt (m - (m^2));
    
    cheby_higher = m + (std_dev / sqrt(0.05 * N));
    cheby_lower = m - (std_dev / sqrt(0.05 * N));
    
    clt_higher = m + (2 * (std_dev / sqrt(N)));
    clt_lower = m - (2 * (std_dev / sqrt(N)));
    
    fprintf("\nBootstrapped Chebyshev .95 confidence interval: %f < X < %f", cheby_lower, cheby_higher);
    fprintf("\nBootstrapped CLT .95 confidence interval: %f < X < %f", clt_lower, clt_higher);
end

function sum_mean = mean_zn(all_u_data, par_probs)
    sum_mean = 0;
    for i=1 : length(par_probs)
        sum_mean = sum_mean + mean(all_u_data(:,i)) * par_probs(i);
    end
    
end

function sz = stoc_sim(all_u_data, par_probs, req_sims)
    prob_timing = [];
    for k=1 : length(par_probs)
        prob_timing = [prob_timing, mean(all_u_data(:,k))];
    end
   
    count = 0;
    for i=1: req_sims
        ran_user_p = unifrnd(0,1);
        user_j = -1;
        sum_probs = 0;
        for j=1: length(par_probs)
            sum_probs = sum_probs + par_probs(j);
            if ran_user_p <= sum_probs
                user_j = j;
                break;
            end
        end
        ran_req_p = unifrnd(0,1);
        if ran_req_p <= prob_timing(user_j)
            count = count + 1;
        end
    end
    sz = count / req_sims;
end
