%Q44
x4_dot=x4_dot1+x4_dot2+x4_dot3;
x(1,k)=x(1,k-1)+0.01*x1_dot;
x(2,k)=x(2,k-1)+0.01*x2_dot;
x(3,k)=x(3,k-1)+0.01*x3_dot;
x(4,k)=x(4,k-1)+0.01*x4_dot;
end
teta=x(3,:)*180/pi; % changing x3 from radian to
degree