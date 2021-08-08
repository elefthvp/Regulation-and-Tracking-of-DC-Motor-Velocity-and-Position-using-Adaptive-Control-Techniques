function a_s = generate_a_s(n)
syms s
a_s=s^0;

    for i=1:n
    a_s=[s^(i); a_s];
    end
end

