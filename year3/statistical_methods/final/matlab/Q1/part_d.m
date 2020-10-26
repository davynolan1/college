% Question 1 (d)
n = 1:10;
y_exp3 = [];
y_exp4 = [];
for i=1 : 10
    y_exp3 = [y_exp3, exp3(i)];
    y_exp4 = [y_exp4, exp4(i)];
end

title('Graph of the Probability of Exam Failure')
xlabel('Number of studied topics');
ylabel('Probability of exam failure');
grid on ;
hold on ;
p1=plot(n, y_exp3);
p2=plot(n, y_exp4);
l1="3 Question Exam";
l2="4 Question Exam";
legend([p1,p2], [l1, l2]);
hold off;

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

function y2 = exp4(n)
    if n < 7
        y2 = ((choose(n,1)*choose(10-n,3))/210) + ((choose(10-n,4))/210);
    elseif n == 7
        y2 = ((choose(n,1)*choose(10-n,3))/210);
    else
        y2 = 0;
    end
end