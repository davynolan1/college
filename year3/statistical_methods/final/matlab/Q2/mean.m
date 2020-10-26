data = readtable('data.txt');

q1 = data.Var1;
q2 = data.Var2;
q3 = data.Var3;

N = length(q1);

m1 = sum(q1)/N;
m2 = sum(q2)/N;
m3 = sum(q3)/N;

std_dev1 = sqrt((sum((q1-m1).^2))/N);
std_dev2 = sqrt((sum((q2-m1).^2))/N);
std_dev3 = sqrt((sum((q3-m1).^2))/N);

corr_mat1 = corrcoef(q1, q1);
corr_mat2 = corrcoef(q1, q2);
corr_mat3 = corrcoef(q1, q3);
corr1 = corr_mat1(1,2);
corr2 = corr_mat2(1,2);
corr3 = corr_mat3(1,2);

cond_mean_mat1 = [];
cond_mean_mat2 = [];
cond_mean_mat3 = [];

% all condtional means are done with question 1 as the conditon 
cond_mean_mat1 = q1;
cond_mean_sum1 = sum(cond_mean_mat1);
cond_mean_q1 = cond_mean_sum1/N;
cond_var1 = (std_dev1^2)*(1-corr1^2);

for i=1 : N
    cond_mean2 = m2 + corr2*(std_dev2/std_dev1)*(q1(i)-m1);
    cond_mean_mat2 = [cond_mean_mat2; cond_mean2];
    
    
    %cond_var_q2 = [cond_var_q2, cond_var2];
end
cond_mean_sum2 = sum(cond_mean_mat2);
cond_mean_q2 = cond_mean_sum2/N;
cond_var2 = (std_dev2^2)*(1-corr2^2);

for i=1 : N
    cond_mean3 = m3 + corr3*(std_dev3/std_dev1)*(q1(i)-m1);
    cond_mean_mat3 = [cond_mean_mat3; cond_mean3];
    
    
    %cond_var_q3 = [cond_var_q3, cond_var3];
end
cond_mean_sum3 = sum(cond_mean_mat3);
cond_mean_q3 = cond_mean_sum3/N;
cond_var3 = (std_dev3^2)*(1-corr3^2);