%Q41
clc
clear all
%~~ DEFINITION OF PARAMETERS OF Longitudinal motion ~~~
A=[-0.007 0.012 0 -9.81;-0.128 -0.54 1 0;0.064 0.96 -0.99
0;0 0 1 0];
B=[0;-0.036;-12.61;0];
C=[1 0 0 0;0 1 0 0];
% Selecting state 'x(t)' & 'teta(t)' as measured outputs,
% Other states should be estimated!
%-- SELECTING OBSERVER POLES -------
D=[-10 0;0 -10];
%-- SELECTING "Q" AND FINDING "A_taw" ---
Q=[0,0,1,0;0,0,0,1;0,1,0,0;1,0,0,0];
A_taw=inv(Q)*A*Q;
A11_taw=A_taw(1:2,1:2);
A12_taw=A_taw(1:2,3:4);
A21_taw=A_taw(3:4,1:2);
A22_taw=A_taw(3:4,3:4);
%-- FINDING "R" & "T" --
L_taw=(D-A11_taw)*inv(A21_taw);
T=A12_taw+L_taw*A22_taw-D*L_taw;
L=[L_taw [0 1;1 0]];
R=L*B;
%-- FINDING "F1" & "F2" --
F=inv([C;L]);
F1=F(:,1:2);
F2=F(:,3:4);
K=[0.922 -6.5955 -2.35 -8.977];
% state feedback from example 6-8
%-- SIMULATION USING "SIMULINK" --
sim('reduced_obsv_cont',[0 10]);
% this simulation will return "time","real_states" &
% "estimated_states" to workspace.
%-- DRAWING GRAPHS ---
subplot(2,2,1);plot(time,estim_state(:,1));
legend('Measured State');title('X_1');
subplot(2,2,2);plot(time,estim_state(:,2));
legend('Measured State');title('X_2');
subplot(2,2,3);plot(time,estim_state(:,3));
legend('Estimated State');title('X_3');
xlabel('Time(sec)');
subplot(2,2,4);plot(time,estim_state(:,4));
legend('Estimated State');title('X_4');
xlabel('Time(sec)');
[rt,ct]=size(time);
kk=(rt-mod(rt,4.5))/4.5;
figure;
plot(time(1:kk),real_cont(1:kk),'b:',time(1:kk),estim_con
t(1:kk),'b-');xlabel('Time(sec)');
legend('With Real States','With Estimated States');
title('Control Signal')