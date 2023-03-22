% Stephanie Klumpe
% Problem 2.7 edited code

clear
close all
clc

hval = [2^-3 2^-4 2^-5 2^-6];             %% h-value vector
maxe = zeros(2,4);                       %% Max error matrix for both fxns
counter = 1;                              %% Indexing counter

for h = hval

  xmax = 10; clf
  x = -xmax:h:xmax;                      % computational grid %% Estimate?
  xx = -xmax-h/20:h/10:xmax+h/20;        % plotting grid %% Actual?

  for plt = 1:2
    switch plt
        case 1, v = (abs(x)<=3);          % square wave
                vv = (abs(xx)<=3);        

        case 2, v = max(0,1-abs(x)/3);    % hat function
                vv = max(0,1-abs(xx)/3);  
    end

    p = zeros(size(xx));
    for i = 1:length(x)
      p = p + v(i)*sin(pi*(xx-x(i))/h)./(pi*(xx-x(i))/h);
    end

    maxe(plt,counter) = norm(p-vv,Inf);   %% Max error entries
  end

 counter = counter+1;
end

subplot(2, 1, 1);
loglog(hval,maxe(1,:))                    %% Plot of h vs error of sw
subplot(2, 1, 2);
loglog(hval,maxe(2,:))                    %% Plot of h vs error of hf