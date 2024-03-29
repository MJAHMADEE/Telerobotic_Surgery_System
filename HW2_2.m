A = diag([-1,-2,-3,-4,-5]);
A1 = diag([-2,-2,-2,-2,-2]);

cvx_begin

    cvx_solver Gurobi
    
      variable P(5,5) symmetric semidefinite;
      variable P2(5,5) symmetric semidefinite
      variable P3(5,5) symmetric semidefinite
      variable U(5,5) symmetric semidefinite
      variable lambda semidefinite
      variable h semidefinite
    
      phi11 = (P2)'.*(A+A1) + (A+A1)'.*P2;
      phi12 = P-(P2)'+(A+A1)'.*P3
      phi13 = -h.*(P2)'*A1;
      phi21 = (P-(P2)'+(A+A1)'*P3)';
      phi22 = -P3-(P3)';
      phi23 = -h.*(P3)'.*A1;
      phi31 = (-h.*(P2)'.*A1)';
      phi32 = ( -h.*(P3)'.*A1)';
      phi33 = -h.*U;
      minimize(norm(lambda - 0.1,2))
        subject to
          [phi11, phi12, phi13; phi21, phi22, phi23; phi31,phi32,phi33] == -eye(5)*0.000001;
          P - lambda*eye(5) == semidefinite(5)
          
cvx_end    