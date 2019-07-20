


%%
A = [0 0 1 0; 0 0 0 1; -0.4568 -0.6196 0 0;0.2485 -6.6174 0 0];
B = [0 0; 0 0; 0.7870 -0.0426; 0.0426 0.1349];
C = [1 0 0 0; 0 1 0 0];
D = [0 0; 0 0];


%%
system=ss(A,B,C,D);
disp('system is contrlable?')
if(rank(ctrb(A,B))==rank(A))
    disp('yes')
else
    disp('No')
end

disp('system is obsernanle?')
if(rank(obsv(A,C))==rank(A))
    disp('yes')
else
    disp('No')
end


%%
eig_value=eig(A)

%Transfer Function
syms s
T = C*inv(s*eye(rank(A))-A)*B + D;
T = vpa(H,3);
T = collect(H);
s = tf('s');
T_prime=minreal(system);
pzmap(T_prime);


%%
Pole_r=[-3000 -2000 -1000 -3000];
L = (place(A',C',Pole_r))'
A_n=A-L*C;
B_n=B;
C_n=C;


