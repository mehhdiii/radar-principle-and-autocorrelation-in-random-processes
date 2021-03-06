ITER = 1000; 

x = randn(1, ITER);
a = 1; 
b = [1 -1 1];
y_delay = zeros(4, ITER);
y = filter(b, a, x); 
m = [1 2 3 4];

%estimate auto correlation 
r_est = autocorrelation_(y,m, ITER);

close all; 
for ii=1:4
    subplot(2, 2, ii)
    y_delay(ii, :) = [y(1, m(ii)+1:end) zeros(1, m(ii))];
    plot(y,y_delay(ii, :) , '*')
    title('r bw Y and Y_{n+'+string(ii)+'}'+": r'="+string(r_est(1, ii)))
end
figure()
%actual r: 
n = -10:10;
r = [zeros(1, 8) 1 -2 3 -2 1 zeros(1, 8)];
m = -10:10; 
r_est = autocorrelation_(y,m, ITER);

subplot(2, 1, 1)
stem(n, r, '*')
title('Actual r')
subplot(2, 1, 2)
stem(n, r_est, '*')
title('Estimated r')


%Cross correlation: 
X = randn(1, ITER); 
Z = randn(1, ITER);
Y = X+Z;
m = -10:10;
r_corr = zeros(1, length(m));
for jj=1:length(m)
    r_corr(jj) = CorR(X, Y, m(jj));
end
close all;
figure()
stem(m, r_corr, '*')
title('Cross Correlation between X and Y')
xlabel('Lag (m)')

close all; 
myradar = load('radar.mat')
figure()
subplot(2, 1, 1)
plot(myradar.trans)
title('Sent')
subplot(2,1,2)
plot(myradar.received)
title('Received')
close 

%autocorrelation of transmitted signal: 
m = -100:100;
r_sent = autocorrelation_(y,m, length(myradar.trans));
stem(m, r_sent, '*')
title('Autocorr of Sent signal')

%radar distance calculations: 

m = -100:100;
r_corr = zeros(1, length(m));
for jj=1:length(m)
    r_corr(jj) = CorR(myradar.trans, myradar.received, m(jj));
end


[~, indx] = max(r_corr);


stem(m, r_corr, '*')
title('delay: ' + string(m(indx))+'m')
    