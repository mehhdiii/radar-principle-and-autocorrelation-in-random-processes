function [C] = CorR(x,y, m)
    ITER = length(x);
    C = 0;
    if (m<0)
        for jj = abs(m)+1:ITER
            C = C + x(jj)*y(jj+m) ;  
        end
        C = (1/(ITER-abs(m)))*C;
    else
        for jj = 1:ITER-m
            C = C + x(jj)*y(jj+m) ;  
        end
        C = (1/(ITER-m))*C;
    end
    
    
end

