%     Advanced Structural Theory
%
%     Program Assignment No. 1 (Weight 1)
%
%
%        Assigned: (10/20/2016)
%        Due: (11/3/2016)
%
%      (1) Complete function INPUT
%      (2) Complete the main program FRAME16 up to
%          % ^^* UP TO HERE  --- PROG 1 ^^*
%      (3) Test problem: see programming 1.pdf; you shall
%		   prepare an input file and run the program to read in and
%          write out the data (in function INPUT) to see if the output
%          data are the same as the input data. In addition, use function
%          drawingStructure to check the geometry of the structures.
%      (4) Sumbit the following to CEIBA in archive file (*.zip or *.rar):
%          (a) Program source code "FRAME16.m"
%          (b) Input file "*.ipt"
%
%
function FRAME16(FILENAME)
% FRAME14: A linear analysis program for framed structures
%..........................................................................
%    Programmers: R05521203�i�@�@&R05521245�L�a��
%                 Supervised by Liang-Jenq Leu
%                 For the course: Advanced Structural Theory
%                 Department of Civil Engineering
%                 National Taiwan University
%                 Fall 2016 @All Rights Reserved
%..........................................................................

%    VARIABLES:
%        NNOD   = number of nodes
%        NBC    = number of Beam-column elements
%        NCO    = number of coordinates per node
%        NDN    = number of DOFs per node
%        NNE    = number of nodes per element
%        NDE    = number of DOFs per element
%        NMAT   = number of material types
%        NSEC   = number of cross-sectional types
%        IFORCE = 1 if only concentrated loads are applied
%               = 2 if fixed-end forces are required.
%                   (e.g. problems with distributed loads, fabrication
%                   errors, temperature change, or support settlement)
%    CHARACTERS
%        FUNIT  = unit of force (such as kN and kip)
%        LUNIT  = unit of length (such as mm and in)
%..........................................................................

%    FRAME TYPE    ITP  NCO  NDN   (NCO and NDN are stored in Array IPR)
%           BEAM    1    1    2
%   PLANAR  TRUSS   2    2    2
%   PLANAR  FRAME   3    2    3
%   PLANAR  GRID    4    2    3
%   SPACE   TRUSS   5    3    3
%   SPACE   FRAME   6    3    6

FTYPE = {'BEAM';'PLANE TRUSS';'PLANE FRAME';'PLANE GRID';...
    'SPACE TRUSS';'SPACE FRAME'};
IPR = [1,2,2,2,3,3;2,2,3,3,3,6];

if nargin == 0 % no input argument
    % Open file with user interface
    [~,FILENAME] = fileparts(uigetfile('*.ipt','Select Input file'));
end

% Get starting time
startTime = clock;

% FILENAME.ipt is the input data file.
% FILENAME.dat includes the output of the input data and
%   the nodal displacements and member end forces.

IREAD = fopen([FILENAME '.ipt'], 'r');

% Read in the problem title and the structural data
TITLE = fgets(IREAD);
FUNIT = fgets(IREAD);
LUNIT = fgets(IREAD);
ID = '*';
HEADLINE(ID,IREAD);
line = fgets(IREAD);
args = str2num(line);
[NNOD,NBC,NMAT,NSEC,ITP,NNE,IFORCE] = deal(args(1),args(2),args(3),args(4),args(5),args(6),args(7));
NCO = IPR(1,ITP);
NDN = IPR(2,ITP);
NDE = NDN*NNE;

% Read the remaining data
 [COOR,NFIX,EXLD,IDBC,VECTY,FEF,PROP,SECT] = INPUT(IREAD,ID,NNOD,NCO,NBC,NMAT,NSEC,ITP,NDN,NDE,IFORCE)
fclose(IREAD);

%DrawingStructure
FORMAT='-r';
drawingStructure(ITP,COOR,IDBC,NBC,LUNIT,FORMAT);

%Output data(Input check)
IWRITE=fopen('output data.txt','w');
fprintf(IWRITE,'%s',TITLE);
fprintf(IWRITE,'%s',FUNIT);
fprintf(IWRITE,'%s',LUNIT);
fprintf(IWRITE,'*\t%s\t%s\t%s\t%s\t%s\t%s\t%s\r\n','NNOD','NBC','NMAT','NSEC','ITP','NNE','IFORCE');
fprintf(IWRITE,'\t%d\t%d\t%d\t%d\t%d\t%d\t%d\r\n',NNOD,NBC,NMAT,NSEC,ITP,NNE,IFORCE);

fprintf(IWRITE,'\r\n*\t%s','COOR (m)');
[m, n] = size(COOR');
a=0;
for i = 1 : m
    a=a+1;
    fprintf(IWRITE,'\r\n%d',a);
    for j = 1 : n
        fprintf(IWRITE,'\t%d',COOR(j, i));
    end
end

fprintf(IWRITE,'\r\n');
fprintf(IWRITE,'\r\n*\t%s','NFIX (u,v)');
[m, n] = size(NFIX');
a=0;
for i = 1 : m
    a=a+1;
    fprintf(IWRITE,'\r\n%d',a);
    for j = 1 : n
        fprintf(IWRITE,'\t%d',NFIX(j, i));
    end
end

fprintf(IWRITE,'\r\n');
fprintf(IWRITE,'\r\n*\t%s','External Load (kN): Px, Py');
[m, n] = size(EXLD');
a=0;
for i = 1 : m
    a=a+1;
    fprintf(IWRITE,'\r\n%d',a);
    for j = 1 : n
        fprintf(IWRITE,'\t%d',EXLD(j, i));
    end
end

fprintf(IWRITE,'\r\n');
fprintf(IWRITE,'\r\n*\t%s','IDBC');
[m, n] = size(IDBC');
a=0;
for i = 1 : m
    a=a+1;
    fprintf(IWRITE,'\r\n%d',a);
    for j = 1 : n
        fprintf(IWRITE,'\t%d',IDBC(j, i));
    end
end

fprintf(IWRITE,'\r\n');
fprintf(IWRITE,'\r\n*\t%s','PROP');
[m, n] = size(PROP');
a=0;
for i = 1 : m
    a=a+1;
    fprintf(IWRITE,'\r\n%d',a);
    for j = 1 : n
        fprintf(IWRITE,'\t%d',PROP(j, i));
    end
end

fprintf(IWRITE,'\r\n');
fprintf(IWRITE,'\r\n*\t%s','SECT');
[m, n] = size(SECT');
a=0;
for i = 1 : m
    a=a+1;
    fprintf(IWRITE,'\r\n%d',a);
    for j = 1 : n
        fprintf(IWRITE,'\t%d',SECT(j, i));
    end
end

fclose(IWRITE);


% ^^* UP TO HERE  --- PROG 1 ^^*
[IDND,NEQ] = IDMAT(NFIX,NNOD,NDN)
LM = MEMDOF(NDE,NBC,IDBC,IDND)
NSBAND = SEMIBAND(NBC,LM)

% % DOF numbering
function [IDND,NEQ] = IDMAT(NFIX,NNOD,NDN)
%..........................................................................
%
%   PURPOSE: Transform the NFIX matrix to equation (DOF) number matrix
%            IDND (nodal DOF table) and calculate the number of equation
%            (DOF), NEQ.
%
%
%   INPUT VARIABLES:
%     NFIX(NDN,NNOD)   = matrix specifying the boundary conditions
%     NNOD             = number of nodes
%     NDN              = number of DOFs per node
%
%   OUTPUT VARIABLES:
%     IDND(NDN,NNOD)   = matrix specifying the global DOF from nodal DOF
%     NEQ              = number of equations
%
%   INTERMEDIATE VARIABLES:
%     N                = fixed d.o.f. numbering
%..........................................................................
IDND = zeros(NDN,NNOD);
PS=0;
NS=0;
for j = 1 : NNOD
    for i = 1 : NDN
        if NFIX(i,j) < 0
            NS = NS - 1;
            IDND(i,j) = NS;
        elseif NFIX(i,j) > 0
            IDND(i,j) = IDND(i,NFIX(i,j))
        else
            PS = PS + 1;
            IDND(i,j) = PS;
        end
    end
end
NEQ = PS;
end

% % Compute the member DOF table:  LM(NDE,NBC)
function LM = MEMDOF(NDE,NBC,IDBC,IDND)
%.........................................................................
%
%   PURPOSE: Calculate the location matrix LM for each element
%
%   INPUT VARIABLES:
%   ...
%   ...
%
%   OUTPUT VARIABLES:
%   ...
%..........................................................................
LM = zeros(NDE,NBC);
for j = 1 : NBC
    LM(:,j) = [IDND(:,IDBC(1,j));IDND(:,IDBC(2,j))];
end
end
% % Compute the semi-band width,NSBAND, of the global stiffness matrix
function NSBAND = SEMIBAND(NBC,LM)
%..........................................................................
%   PURPOSE: Determine the semiband width of the global stiffness
%            matrix
%
%   INPUT VARIABLES:
%   ...
%   ...
%
%   OUTPUT VARIABLES:
%     NSBAND     = semiband width
%..........................................................................
for i = 1 : NBC
    LMi=LM(:,i);%��i��element�����쪺DOF
    LMi((find(LMi<0))) = [];%�Nfixed�ݪ������h��
    iBAND(i) = (max(LMi) - min(LMi) + 1);
end
NSBAND=max(iBAND);
end

% %Form the global load vector GLOAD(NEQ) from the concentrated nodal loads
% GLOAD = LOAD(EXLD, ~ );
%
% % ^^* UP TO HERE  --- PROG 2 ^^*
%
% % Form the global stiffness matrix GLK(NEQ,NSBAND) and obtain the
% % equivalent nodal vector by assembling -(fixed-end forces) of each member
% % into the load vector.
% [GLK,GLOAD] = FORMKP(COOR,IDBC,VECTY,PROP,SECT,LM,FEF,GLOAD,NNOD,NBC,NMAT...
%     ,NSEC,IFORCE,ITP,NCO,NDN,NDE,NNE,NEQ);
%
% % ^^* UP TO HERE  --- PROG 3 ^^*
%
% DISP = SOLVE(GLK, ~ );
%
% % Determine the member end forces ELFOR(NDE,NBC)
% ELFOR = FORCE( ~ );
%
% % Get ending time and count the elapased time
% endTime = clock;
%
% % Print out the results
% IWRITE = fopen([FILENAME '.dat'], 'w');
% OUTPUT( ~ );
% fclose(IWRITE);
%
% IGW = fopen([FILENAME '.txt'], 'w');
% GRAPHOUTPUT(IGW,COOR,NFIX,EXLD,IDBC,FEF,PROP,SECT,LM,IDND,DISP,ELFOR,NNOD,...
%     NDN,NCO,NDE,NEQ,NBC,NMAT,NSEC,ITP,NNE,IFORCE,FUNIT,LUNIT);
% fclose(IGW);
%
% % ^^* UP TO HERE  --- PROG 4 ^^*

end

function HEADLINE(ID,IREAD)
while ~feof(IREAD)
    temp = fgets(IREAD);
    if ~isempty(temp) && temp(1) == ID
        return
    end
end
end

function [COOR,NFIX,EXLD,IDBC,VECTY,FEF,PROP,SECT] = INPUT(IREAD,ID,NNOD,NCO,NBC,NMAT,NSEC,ITP,NDN,NDE,IFORCE)
%..........................................................................
%
%    PURPOSE: Reads in the following data: nodal coordinates,
%             boundary conditions, external nodal loads, identification
%             data (connectivity), direction cosines of the local y-axis
%             (for space frame only; ITP=6), fixed-end forces, material
%             and cross sectional properties.
%
%    VARIABLES:
%      IREAD          = index of input stream
%      ID             = identifier charactor of input file
%      NNOD           = number of nodes
%      NBC            = number of Beam-column elements
%      NMAT           = number of material types
%      NSEC           = number of cross-sectional types
%      ITP            = frame tyoe
%      NCO            = number of coordinates per node
%      NDN            = number of DOFs per node
%      NDE            = number of DOFs per element
%      IFORCE         = indicator for fixed-end forces (FEF)
%                     = 1 for the case of ONLY concentrated nodal loads;
%                       no need to input FEF.
%                     = 2 for the following cases: distributed loads,
%                       temperature change, support settlement;
%                       need to input FEF for each member.
%      COOR(NCO,NNOD) = nodal coordinates
%      NFIX(NDN,NNOD) = Boolian id matrix for specifying boundary conditions
%                     = -1 for restrained d.o.f.
%                     =  0 for free d.o.f.
%                     = the first node number for the d.o.f.
%                       that has the same d.o.f. of the second node
%                       when "the double node technique" is used.
%
%      EXLD(NDN,NNOD) = external nodal loads
%      IDBC(5,NBC)    = Beam-column identification data
%                       (1,*) = local node 1
%                       (2,*) = local node 2
%                       (3,*) = material type.
%                       (4,*) = section type.
%                       (5,*) = omitted.
%      VECTY(3,NBC)   = direction cosines of the local y-axis
%                       VECTY is needed only when ITP=6 (space frame)
%      FEF(NDE,NBC)   = FEF is needed only when IFORCE=2
%      PROP(5,NMAT)   = material properties
%                       (1,*) = Young's modulus
%                       (2,*) = Poision ratio.
%                       (3,*) = omitted.
%                       (4,*) = omitted.
%                       (5,*) = omitted.
%      SECT(5,NSEC)   = Beam-column properties
%                       (1,*) = cross-sectional area A.
%                       (2,*) = moment of inertia Iz (3D)
%                       (3,*) = moment of inertia Iy (3D)
%                       Note that for 2D problems, only Iz is required.
%                       (4,*) = torsional constant J.
%                       (5,*) = omitted.
%..........................................................................

% COOR - Nodal coordinates
HEADLINE(ID,IREAD);
COOR = ReadMatrix(IREAD,NCO,NNOD);
%NFIX
HEADLINE(ID,IREAD);
NFIX = ReadMatrix(IREAD,NDN,NNOD);
%EXLD
HEADLINE(ID,IREAD);
EXLD = ReadMatrix(IREAD,NDN,NNOD);
%IDBC
HEADLINE(ID,IREAD);
IDBC = ReadMatrix(IREAD,5,NBC);
%VECTY
if ITP==6
    HEADLINE(ID,IREAD);
    VECTY = ReadMatrix(IREAD,3,NBC);
else
    VECTY=[];
end
%FEF
if IFORCE==2
    HEADLINE(ID,IREAD);
    FEF = ReadMatrix(IREAD,NDE,NBC);
else
    FEF = [];
end
%PROP
HEADLINE(ID,IREAD);
PROP = ReadMatrix(IREAD,5,NMAT);
%SECT
HEADLINE(ID,IREAD);
SECT = ReadMatrix(IREAD,5,NSEC);

end

function mat = ReadMatrix(IREAD, row, col)
% for function INPUT
mat = zeros(row,col);
for j = 1:col
    line = fgets(IREAD);
    num = str2num(line);
    mat(:,j) = num(2:row+1);
end
end

function drawingStructure(ITP,COOR,IDBC,NBC,LUNIT,FORMAT)
switch ITP
    case 1
        for e=1:NBC
            plot([COOR(IDBC(1,e)),COOR(IDBC(2,e))],[0,0],FORMAT,'linewidth',2)
            xlabel(['X ', LUNIT])
            title('Beam')
            hold on
        end
        hold off
    case {2,3}
        for e=1:NBC
            plot([COOR(1,IDBC(1,e)),COOR(1,IDBC(2,e))],...
                [COOR(2,IDBC(1,e)),COOR(2,IDBC(2,e))],FORMAT,'linewidth',2)
            xlabel(['X ', LUNIT])
            ylabel(['Y ', LUNIT])
            if ITP==2
                title('2D truss')
            else
                title('2D frame')
            end
            hold on
        end
        axis equal
        hold off
    case 4
        for e=1:NBC
            plot([COOR(1,IDBC(1,e)),COOR(1,IDBC(2,e))],...
                [COOR(2,IDBC(1,e)),COOR(2,IDBC(2,e))],FORMAT,'linewidth',2)
            xlabel(['X ', LUNIT])
            ylabel(['Z ', LUNIT])
            title('grid')
            hold on
        end
        axis equal
        hold off
    case {5,6}
        for e=1:NBC
            plot3([COOR(1,IDBC(1,e)),COOR(1,IDBC(2,e))],...
                [COOR(2,IDBC(1,e)),COOR(2,IDBC(2,e))],...
                [COOR(3,IDBC(1,e)),COOR(3,IDBC(2,e))],FORMAT,'linewidth',2)
            xlabel(['X ', LUNIT])
            ylabel(['Y ', LUNIT])
            zlabel(['Z ', LUNIT])
            if ITP==5
                title('3D truss')
            else
                title('3D frame')
            end
            hold on
        end
        axis equal
        hold off
end
end