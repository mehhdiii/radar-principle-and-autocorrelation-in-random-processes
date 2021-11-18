function [r_est] = autocorrelation_(y,m, ITER)
r_est = zeros(1, length(m));
for ii = 1:length(m)
    for jj = 1:ITER-abs(m(ii))
        r_est(1, ii) = r_est(1, ii) + y(jj)*y(jj+abs(m(ii))); 
    end
    r_est(1, ii) = (1/(ITER-abs(m(ii))))*r_est(1, ii);
end

end

