function y = simulate_first_order(system,input,t,prev)
temp = lsim(system,input,t,prev);
y=temp(end);
end