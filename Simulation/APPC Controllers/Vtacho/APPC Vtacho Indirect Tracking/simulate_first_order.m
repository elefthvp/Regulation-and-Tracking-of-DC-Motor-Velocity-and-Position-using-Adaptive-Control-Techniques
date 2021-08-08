function y = simulate_first_order(system,input,t,prev)
%integrate a first-ordr system and return its final value
temp = lsim(system,input,t,prev);
y=temp(end);
end