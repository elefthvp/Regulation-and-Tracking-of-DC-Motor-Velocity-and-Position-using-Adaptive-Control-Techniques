function w1w2_new = findw1w2(F,g,w1w2_prev,up,yp,t,M0_w) %,M0_w,q0,sigma0

w1_new=findw1(F,g,w1w2_prev(1),up,t,M0_w(1)); %,M0_w(1),q0(1),sigma0(1)
w2_new=findw2(F,g,w1w2_prev(2),yp,t,M0_w(2)); %,M0_w(2),q0(2),sigma0(2)
w1w2_new=[w1_new w2_new];

end

