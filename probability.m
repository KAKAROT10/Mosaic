function what_symbol = probability(pattern)
    load('theta.mat');
    X = open_matrix(pattern);
    X = [ones(1, 1) X];
    prob = sigmoid(X * all_theta);
    prob
    [max_prob, what_symbol] = max(prob);
end
