%parts (b) and (c) are performed in the one script
%Question 2 (b)
data = readtable('data.txt');
data(:,4) = [];
data = table2array(data);
bins = zeros(1000,2); 
cond_means = zeros(10, 2);
cond_var = zeros(10, 2);
N = 1000;
x = 100;
d = 10;
r = mod(x, d);
y = (x - r) / d;

for i = 1:N
    mark = data(i, 1);  
    if (mark < 10)  %Handling bin 0-10
        bins(i, 1) = 1;
        bins(1, 2) = (bins(1, 2) + 1);
    elseif mark == 100  %Handling bin 90-100 for when the mark is 100
        bins(i, 1) = 10;
        bins(10, 2) = (bins(10, 2) + 1);
    else  %Handling bins 10-20, 20-30, 30-40, 40-50, 50-60, 60-70, 70-80, 80-90 and 90-100 for marks that are not 100 
        r = mod(mark, 10);  % r is the second digit of the mark (e.g) if mark is 73 then r is 3
        bin_no = ((mark-r)/10) + 1; % taking the digit away from the mark and then dividing it by 10 leaves just the first digit (i.e) the bin number  
        bins(i, 1) = bin_no;    
        bins(bin_no, 2) = bins(bin_no, 2) + 1;
    end
end

for i = 1:2
    for j = 1:N
        %q1_cond = data(j,1); %for debugging
        q1_bin = bins(j, 1);   % The bin which question 1 is in
        mark = data(j,i+1);    % mark for question 2/3 (depending on i)
        bin_amount = bins(q1_bin,2);    % bin count for q1_bin
        result = mark/bin_amount;   % Divided the mark by the bin count for calculating the mean
        cond_means(q1_bin,i) = result + cond_means(q1_bin,i); % Adds all the mark/bin_amount together to get the mean for that bin 
    end
end

disp(cond_means);

for i = 1:2
    for j = 1:N
        %q1_cond = data(j,1); %for debugging
        q1_bin = bins(j, 1);   % The bin which question 1 is in
        mark = data(j,i+1);    % mark for question 2/3 (depending on i)
        bin_amount = bins(q1_bin,2);    % bin count for q1_bin
        mark_mean = cond_means(q1_bin, i);
        variance = ((mark-mark_mean)^2/bin_amount);   % Divided the mark by the bin count for calculating the mean
        cond_var(q1_bin, i) = variance + cond_var(q1_bin,i);
        
    end
end

disp(cond_var);

%Question 2 (c)
clt_lower = zeros(10,2);
clt_error_inter = zeros(10,2);
for i = 1:2
    for j=1:10
        mean = cond_means(j,i);
        variance = cond_var(j,i);
        n = bins(j,2);
        std_dev = sqrt(variance);
        
        clt_u = mean + (2 * (std_dev / sqrt(n)));
        clt_l = mean - (2 * (std_dev / sqrt(n)));

        clt_error_inter(j,i) = mean-clt_l;
    end
end


%hold on;
%plot(cond_means(:,1), 10:10:100);
hold on;
p1 = errorbar(1:10:100, cond_means(:,1),  clt_error_inter(:,1));
p2 = errorbar(1:10:100, cond_means(:,2),  clt_error_inter(:,2));
title("Graph of Conditional Mean Confidence Intervals");
xlabel('Bin Range (10-20, 20-30 etc..)');
ylabel('Condtional Mean');
l1="Question 2";
l2="Question 3";
legend([p1,p2], [l1, l2]);
%plot(cond_means(:,2), 10:10:100);
        
        
        
        
        
