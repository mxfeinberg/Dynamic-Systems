function state = diff_eq(t,y)
g = 9.81;
l = 0.1;
state = [y(2); -(g/l)*sind(y(1))];
end