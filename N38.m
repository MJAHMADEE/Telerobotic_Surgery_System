%----- INTEGRAL CONTROLABILITY ANALYSIS ----------------
[rA,cA]=size(A);
[rB,cB]=size(B);
[rC,cC]=size(C);
A_bar=[A zeros(rA,1);-C zeros(rC,1)];
B_bar=[B;zeros(rC,cB)];
Integral_controlability_rank=rank(ctrb(A_bar,B_bar))
%----- STATE FEEDBACK DESIGN ------------
P = [-4260 -100 -7870 -100]; % Desired Closed-Loop Ploes
K=acker(A_bar,B_bar,P); % State-Feedback Gain
K1=K(1:rA);
K2=K(rA+1:rA+rC);