% Stephanie Klumpe
% Final Exam
% Problem 1

t = (0:0.1:2*pi)';
x = 2*cos(t)+0.1*rand(length(t),1);
y = 3*sin(t);

xzero = [x y];

N = length(t);

plot(x,y,'k.')
axis equal

normal = zeros(N:2);

for j = 2:N-1

    data = [x(j-1:j+1) y(j-1:j+1)];
    normal(j:) = bestfitnormal(data);

end

alpha = 0.4;

xplus = xzero+alpha*normal;
xminus = xzero-alpha*normal;

plot(xzero(:,1),xzero(:,2),'ro')
hold on
plot(xplus(:,1),xplus(:,2),'b*')
plot(xminus(:,1),xminus(:,2),'gd')


function out = bestfitnormal(data)

    [M, dim]=size(data);

    Const = ones(M,1); % Vector of the constant term in the RHS
    out = data\Const; % Find the coefficients

end