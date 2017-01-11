load('X.mat');
y = zeros(240, 1);
y(1:30, 1) = 1;
y(31:60, 1) = 2;
y(61:90, 1) = 3;
y(91:120, 1) = 4;
y(121:150, 1) = 5;
y(151:180, 1) = 6;
y(181:210, 1) = 7;
y(211:240, 1) = 8;
[m, n] = size(X);
X = [ones(m, 1) X];
for i=1:8
    initial_theta = zeros(n + 1, 1);
    yc = (y==(i));
    [cost, grad] = costFunction(initial_theta, X, yc);
    options = optimset('GradObj', 'on', 'MaxIter', 200);
    [theta, cost] = ...
        fminunc(@(t)(costFunction(t,X,yc)), initial_theta, options);
    all_theta(:, i) = theta;
    p = predict(theta, X);
    fprintf('Train accuracy = %f\n', (sum(p == yc)/280)*100);
end

