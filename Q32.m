%Q32
g = ss(A,B,C,D);
TF = tf(g)
pzmap(TF)

TF =
 
  %From input 1 to output...
                         0.787 s^2 + 5.181
   1:  -----------------------------------------------------
       s^4 - 9.494e-17 s^3 + 7.074 s^2 + 4.486e-16 s + 3.177
 
                        0.0426 s^2 + 0.215
   2:  -----------------------------------------------------
       s^4 - 9.494e-17 s^3 + 7.074 s^2 + 4.486e-16 s + 3.177
 
  %From input 2 to output...
                       -0.0426 s^2 - 0.3655
   1:  -----------------------------------------------------
       s^4 - 9.494e-17 s^3 + 7.074 s^2 + 4.486e-16 s + 3.177
 
                       0.1349 s^2 + 0.05104
   2:  -----------------------------------------------------
       s^4 - 9.494e-17 s^3 + 7.074 s^2 + 4.486e-16 s + 3.177
 
  %Continuous-time transfer function.