function ELFOR = FORCE( ... )
%..........................................................................
%   PURPOSE:  Find the member forces with respect to the local axes.
%
%   VARIABLES:
%     INPUT:
%        ...
%        ...
%        ...
%
%     OUTPUT:
%        ELFOR   = the member forces in local axes
%
%     INTERMEDIATE:
%        ...
%        ...
%        ...
%
%..........................................................................
ELFOR = zeros(NDE, NBC);
for IB = 1 : NBC
    [T, RL] = ROTATION(COOR, VECTY, IDBC, IB, ITP, NCO, NDE);
    % Calculate the element stiffness matrix, EE
    EE = ELKE(ITP, NDE, IDBC, PROP, SECT, IB, RL);
    % Get element DOF

    % ...

    % Get element disp.

    % ...

    % Transform into local coordindate

    % ...

    %     Compute the member forces
    %     {ELFOR}=[EE]{DSL}       (if IFORCE .EQ. 1)
    %     {ELFOR}=[EE]{DSL}+{FEF} (if IFORCE .EQ. 2)

    % ...

end
end