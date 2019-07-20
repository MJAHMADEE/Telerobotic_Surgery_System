% Kalman Filter
clc
clear all
%--- SYSTEM DEFINITION ---
A=[0 1;0 0];
B=[0 1]';
C=[1 0;0 1];
%~~~ Part1: KALMAN FILTER DESIGN ~~~~
%------------------------------------------------------
%-SELECTION OF "R1" & "R2" ACCORDING TO COST FUNCTION -
R1=1;
R2=[2 0;0 1];
%--- SOLVING RICCATI EQUATION (8-3-15) ---
R=C'*inv(R2)*C;
Q=B*R1*B';
[P1,P2,LAMP,PERR,WELLPOSED,P] =
aresolv(A',Q,R,'schur');
L_Kalman=inv(R2)*C*P; %state feedback
%~~~ Part2: LUENBERGER OBSERVER DESIGN ~~~
P=[-2 -3]; %desired observer poles
L_t=place(A',C',P);
L_Luenberger=L_t';
%--- SIMULATION ---
sim('compare',[0 7]);
plot(time,state1(:,1),'b:',time,state1(:,2),'b--
',time,state1(:,3),'b-');
title('States variation: x_1');xlabel('Time [sec]');
legend('Real','Luenberger estimated','Kalman
estimated',2);
figure;
plot(time,state2(:,1),'b:',time,state2(:,2),'b--
',time,state2(:,3),'b-');
legend('Real','Luenberger estimated','Kalman
estimated',2);
title('States variation: x_2');xlabel('Time [sec]');