function w1w2_new = findw1w2(F,g,w1w2_prev,up,yp,t)

w1_new=findw1(F,g,w1w2_prev(1),up,t);
w2_new=findw2(F,g,w1w2_prev(2),yp,t);
w1w2_new=[w1_new w2_new];

end

