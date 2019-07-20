close all;
clear all;
clc;
% model variables (Area = V instead of A).
syms x1 x2 tau Fe;

% state vectors
u = [phi_i; A_v];
x = [m]; 
y = [h; m; p; phi_o];
% non-linear system, dx(t)/dt = f(x,u,t)
F1  = rho * phi_i - rho * K * A_v * sqrt((g / V) * m);
F = [F1];
% non-linear system, y(t) = g(x,u,t)
G2 = m;
G1 = rho * V * G2;
G3 = (g * G2) / V;
G4 = K * A_v * sqrt(G3);
G = [G1; G2; G3; G4];
% compute jacobian
A.symbolic = jacobian(F, x);
B.symbolic = jacobian(F, u);
C.symbolic = jacobian(G, x);
D.symbolic = jacobian(G, u);
% Algebraic value of operating point see ex1a.
m_0 = sym(8966455680130479/8796093022208);
% compute matrices A, B, C, D
A.algebraic = simplify(subs(A.symbolic, {A_v V rho g K m}, ...
                [sym(0.01) sym(1) sym(980) sym(9.81) sym(0.01) m_0]));
B.algebraic = simplify(subs(B.symbolic, {A_v V rho g K m}, ...
                [sym(0.01) sym(1) sym(980) sym(9.81) sym(0.01) m_0]));
C.algebraic = simplify(subs(C.symbolic, {A_v V rho g K m}, ...
                [sym(0.01) sym(1) sym(980) sym(9.81) sym(0.01) m_0]));
D.algebraic = simplify(subs(D.symbolic, {A_v V rho g K m}, ...
                [sym(0.01) sym(1) sym(980) sym(9.81) sym(0.01) m_0]));             
% compute numerical values            
A.eval = eval(A.algebraic);
B.eval = eval(B.algebraic);
C.eval = eval(C.algebraic);
D.eval = eval(D.algebraic);
% linearized system
linsys = ss(A.eval, B.eval, C.eval, D.eval);

However just out of curiousity I also wanted Matlab compute the linearized system, http://www.mathworks.nl/help/slcontrol/ug/linearize.html.
I however miserably fail using the linearize functionality and I am not exactly sure what I am doing wrong. So I was hoping someone can help me to get this fixed.
Currently I have
sys = 'ex1a_model';
load_system(sys);
open_system(sys);
% Inputs
sys_io(1) = linio('ex1a_model/phi_i(t)',1,'in');
sys_io(2) = linio('ex1a_model/A_v',2,'in');
% Outputs
sys_io(3) = linio('ex1a_model/Out m(t)',1,'out');
sys_io(4) = linio('ex1a_model/Out h(t)',2,'out');
sys_io(5) = linio('ex1a_model/Out p_i(t)',3,'out');
sys_io(6) = linio('ex1a_model/Out phi_o(t)',6,'out');
% update linio
setlinio(sys,sys_io);
% Set openloop
sys_io(3).OpenLoop='on';
sys_io(4).OpenLoop='on';
sys_io(5).OpenLoop='on';
sys_io(6).OpenLoop='on';
% Linearize
linsys = linearize(sys,sys_io);