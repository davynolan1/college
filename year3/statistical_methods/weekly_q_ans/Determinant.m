function det = Determinant(a)
    if size(a) == 4 
        ad = a(1,1) * a(2,2);
        bc = a(1,2) * a(2,1);
        det = ad - bc;
    %elseif size(a) == 9 
    
    %elseif size(a) == 16
        
    else
        disp('The matrix must be square.')
    end
end
