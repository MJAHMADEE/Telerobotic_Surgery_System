variable = [x1 x2 x3 x4 u1 u2 r1 r2];
JacobA = jacobian(x_dot,[x1 x2 x3 x4]);
A = vpa(subs(JacobA,variable,Eq),3);
JacobB = jacobian(x_dot,u);
B = vpa(subs(JacobB,variable,Eq),3);
JacobBd = jacobian(x_dot,d);
Bd = vpa(subs(JacobBd,variable,Eq),3);