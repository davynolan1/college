%Question 2 (a)
data = readtable('data.txt');

q1 = data.Var1;
q2 = data.Var2;
q3 = data.Var3;

figure
hist_pmf(q1);
title("PMF of Exam Question 1");
xlabel('Question mark');
ylabel('Probability mass');

figure
hist_pmf(q2);
title("PMF of Exam Question 2");
xlabel('Question mark');
ylabel('Probability mass');

figure
hist_pmf(q3);
title("PMF of Exam Question 3");
xlabel('Question mark');
ylabel('Probability mass');

function hist_pmf(u_data)
    histogram(u_data, 50,'Normalization', 'pdf');
end