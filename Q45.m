% Q4
clc
%--- SYSTEM DEFINITION ---
A=[0 1;0 0];
B=[1 0;0 1];
%- SELECTION OF "R1" & "R2" ACCORDING TO COST FUNCTION -
R1=[1 1;1 1];
R2=[1 0;0 1];
%--- SOLVING RICCATI EQUATION (15-3-8) ---
R=B*inv(R2)*B';
Q=R1;
[P1,P2,LAMP,PERR,WELLPOSED,P_alfa] =
aresolv(A+2*eye(2),Q,R,'schur');
K_alfa=inv(R2)*B'*P_alfa; %state feedback
%--- SIMULATION ---
sim('optimal',[0 2.5]);
plot(time,control);
title('Control Signal');xlabel('Time [sec]');
figure;
plot(time,states(:,1),'b:',time,states(:,2),'b-');
legend('x_1(t)','x_2(t)');
title('System States');xlabel('Time [sec]');
%--- CLOSED-LOOP POLES ---
closed loop_poles=eig(A-B*K_alfa)