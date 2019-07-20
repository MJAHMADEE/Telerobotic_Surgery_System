syms p11 p12 p13 p14 p21 p22 p23 p24 p31 p32 p33 p34 p41 p42 p43 p44
Q = eye(4);
R = eye(2);
P = [p11 p12 p13 p14;p21 p22 p23 p24;p31 p32 p33 p34;p41 p42 p43 p44];
Equation = A'*P + P*A - P*B*inv(R)*B'*P == -Q;
sP = solve(Equation , P);
i = 1;
Pn = [sP.p11(i) sP.p12(i) sP.p13(i) sP.p14(i);sP.p21(i) sP.p22(i) sP.p23(i) sP.p24(i);sP.p31(i) sP.p32(i) sP.p33(i) sP.p34(i);sP.p41(i) sP.p42(i) sP.p43(i) sP.p44(i)];
Pn = vpa(Pn,3);
Kn = inv(R)*B'*Pn;
vpa(k,3)