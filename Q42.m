% Q4
clc
%--- SYSTEM DEFINITION ---
A=[0 1;0 0];
B=[0;1];
%========= FIRST SELECTION FOR 'R1' & 'R2'=========
%- SELECTION OF "R1" & "R2" ACCORDING TO COST FUNCTION -
R1=[1 0;0 0];
R2=1;
K=gain_cal(A,B,R1,R2);
%--- SIMULATION ---
sim('optimal',[0 5]);state1=states;
control1=control;time1=time;
%========= SECOND SELECTION FOR 'R1' & 'R2'=========
%- SELECTION OF "R1" & "R2" ACCORDING TO COST FUNCTION -
R1=[10 0;0 0];
R2=1;
K=gain_cal(A,B,R1,R2);
%--- SIMULATION ---
sim('optimal',[0 5]);state2=states;
control2=control;time2=time;
%========= THIRD SELECTION FOR 'R1' & 'R2'=========
%- SELECTION OF "R1" & "R2" ACCORDING TO COST FUNCTION -
R1=[100 0;0 0];
R2=1;
K=gain_cal(A,B,R1,R2);
%--- SIMULATION ---
sim('optimal',[0 5]);state3=states;
control3=control;time3=time;
%========= FORTH SELECTION FOR 'R1' & 'R2'=========
%- SELECTION OF "R1" & "R2" ACCORDING TO COST FUNCTION -
R1=[10 0;0 0];
R2=5;
K=gain_cal(A,B,R1,R2);
%--- SIMULATION ---
sim('optimal',[0 5]);state4=states;
control4=control;time4=time;
%========= FIFTH SELECTION FOR 'R1' & 'R2'=========
%- SELECTION OF "R1" & "R2" ACCORDING TO COST FUNCTION -
R1=[10 0;0 0];
R2=25;
K=gain_cal(A,B,R1,R2);
%--- SIMULATION ---
sim('optimal',[0 5]);state5=states;
control5=control;time5=time;
%######### RESULTS PLOTTING #########
subplot(2,1,1);plot(time1,state1(:,1),'b:',time2,state2(:
,1),'b-',time3,state3(:,1),'b--');
legend('R1=1','R1=10','R1=100');
subplot(2,1,2);plot(time1,state1(:,2),'b:',time2,state2(:
,2),'b-',time3,state3(:,2),'b--');
legend('R1=1','R1=10','R1=100');xlabel('Time(sec)');
figure;plot(time1,control1,'b:',time2,control2,'b-
',time3,control3,'b--');
legend('R1=1','R1=10','R1=100');xlabel('Time(sec)');
title('Optimal Control Signal: Effect of "R1" Variation')
figure;plot(time2,control2,'b:',time4,control4,'b-
',time5,control5,'b--');

legend('R2=1','R2=5','R2=25',4);xlabel('Time(sec)');
title('Optimal Control Signal: Effect of "R2" Variation')

function [K]=gain_cal(A,B,R1,R2)
%--- SOLVING RICCATI EQUATION (15-3-8) ---
R=B*inv(R2)*B';
Q=R1;
[P1,P2,LAMP,PERR,WELLPOSED,P] = aresolv(A,Q,R,'schur');
K=inv(R2)*B'*P; %state feedback