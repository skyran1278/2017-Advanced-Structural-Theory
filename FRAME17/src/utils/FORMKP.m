function [GLK,GLOAD] = FORMKP(COOR,IDBC,VECTY,PROP,SECT,LM,FEF,GLOAD,NNOD,NBC,NMAT...
    ,NSEC,IFORCE,ITP,NCO,NDN,NDE,NNE,NEQ)
%..........................................................................
%
%   PURPOSE: Form the global stiffness matrix GLK.
%
%   INPUT VARIABLES:
%     ...
%     ...
%     ...
%   OUTPUT VARIABLES:
%     GLK(NEQ,NSBAND)= the global stiffness matrix in banded form
%     ...
%
%   INTERMEDIATE VARIABLES:
%     ...
%..........................................................................

%--------------------------------------------------------------------------
%     FORM [K]
%--------------------------------------------------------------------------
% Preallocate the global stiffness matrix
%GLK = spalloc(NEQ,NEQ,NEQ*NEQ);
GLK = zeros(NEQ);

for IB = 1 : NBC
    % Calculate the element rotation matrix ROT and the length RL
    [T, RL] = ROTATION(COOR, VECTY, IDBC, IB, ITP, NCO, NDE);

    % Calculate the element stiffness matrix, EE
    EE = ELKE(ITP, NDE, IDBC, PROP, SECT, IB, RL);

    % Get element DOF
    LDOF = find(LM(:, IB) > 0);
    GDOF = LM(LDOF, IB);

    % Transform the element stiffness matrix from the local axes to global
    % axes : EE --> ELK
    ELK = T' * EE * T;

    % Assemble the global element stiffness matrix to form the global
    % stiffness matrix GLK
    GLK(GDOF, GDOF) = GLK(GDOF, GDOF) + ELK(LDOF, LDOF);

    % This part is to be completed in PROG4.
    % -----------------------------------------------------------------
    % FORM {P} (add the part arising from equivalent member end forces)
    % -----------------------------------------------------------------
    % ****** ADDFEF will be added in PROG4 *****
    if IFORCE == 2
        EQLOAD = - T' * FEF(:, IB);
        GLOAD(GDOF) = GLOAD(GDOF) + EQLOAD(LDOF);
    end
end
end
