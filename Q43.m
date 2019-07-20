% Q4
clc
clear all
%--- SYSTEM DEFINITION ---
A=[0 1;0 0];
B=[0;1];
%--- SELECTION OF "R1" & "R2" & "P" ACCORDING TO COST
FUNCTION ---
R1=[1000 0;0 0];
R2=20;
P1=[1 0;0 1];
%--- SYSTEM PERFORMANCE TIME AND BOUNDARY VALUES ---
t=.001:0.001:2;
[rt,ct]=size(t);
x(:,1)=[2;6];
P=P1; % final value for P(t) (it means P(t=2))
%--- SYSTEM SIMULATION USING EQ. (34-4-8)---
%~~ IN FIRST FOR-LOOP,WE WILL FIND THE SEQUENCE OF
%~~ FEEDBACK GAIN "K(t)" WHICH SHOULD APPLY TO SYSTEM IN
%~~ ORDER TO "x(t=2)=0"
for k=1:ct-1
P_dot=-(R1-P*B*inv(R2)*B'*P+P*A+A'*P);
P=P-0.001*P_dot;
%The sign '-' is because of backward iteration!
K(ct-k,:)=inv(R2)*B'*P; % Feedback gain
end
%~~ IN SECOND FOR-LOOP, WE WILL APPLY CONTROL SEQUENCE
%~~ TO THE SYSTEM
for k=1:ct-1
u(k)=-K(k,:)*x(:,k);
% Control signal
x(:,k+1)=x(:,k)+0.001*(A*x(:,k)+B*u(k));
% Applying control signal to system
end
%--- DRAWING GRAPHS ----
%Drawing states
plot(t,x(1,1:ct),'b:',t,x(2,1:ct),'b-');
xlabel('Time(sec)');legend('x_1(t)','x_2(t)');
title('System States');
%Drawing Control Signal
figure;plot(t(1:ct-1),u);xlabel('Time(sec)');
title('Control Signal');
%Drawing Feedback Gain
figure;
plot(t(1:ct-1),K(:,1),'b:',t(1:ct-1),K(:,2),'b-');
legend('K_1(t)','K_2(t)');
xlabel('Time [sec]');title('FeedBack Gain');
