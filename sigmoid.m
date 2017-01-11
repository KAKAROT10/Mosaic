function g = sigmoid(z)           
e = 2.71;
g=1./(1+(e.^(-z)));
end
