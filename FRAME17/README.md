# FRAME17

- 需要把整個資料夾設為路徑才能 work
- mac 檔案為 LF，windows 檔案為 CRLF，經測試 windows 系統可能會發生不會換行造成檔案看起來混亂。
- matlab.m 檔編碼為 utf8，如果為預設中文系統語系的 big5 編碼，中文可能會出現亂碼並會造成無法預期的錯誤。


------------------------------------------------------------------------------------------
  Advanced Structural Theory

  Program Assignment No. 1 (weight=1)

  Note that each program assignment has its own weight.
  Usually, the larger the weight, the more time you are expected
  to spend on the assignment.

      Assigned: (10/19/2017)
      Due: (11/2/2017)

    (1) Complete function INPUT
    (2) Complete the main program FRAME17 up to
        % ^^* UP TO HERE  --- PROG 1 ^^*
    (3) Test problem: see programming 1.pdf; you shall
      create an input file and run the program to write out
        the data (in subroutine INPUT) to see if the output
        data are the same as the input data. In addition, use function
        DrawingStructure to check the geometry of the structures.
    (4) Sumbit the following to CEIBA in archive file (*.zip or *.rar):
        (a) Program source code "FRAME17.m"
        (b) Input file "*.ipt"

------------------------------------------------------------------------------------------
  Advanced Structural Theory

  Program Assignment No. 2 (weight=2)
          (11/2/2017)
      Due: 11/16/2017

    (1) Complete functions IDMAT, MEMDOF, and SEMIBAND.
    (2) *Complete main program FRAME17 up to
        % ^^* UP TO HERE  --- PROG 2 ^^*
    (3) Test your program :
        It is required that you test the above functions
        using the two examples described in programming2.pdf
        You should check IDND, NEQ, LM, and NSBAND.
        Compare the results with those obtained by hand calculations.
        (You should upload the results to the Ceiba. )

------------------------------------------------------------------------------------------
    Advanced Structural Theory

    Program Assignment No. 3 (weight=3)
           (11/23/2017)
      Due: 12/7/2017

      1. Complete the main program FRAME17 up to
         % ^^* UP TO HERE  --- PROG 3 ^^*
      2. Complete the following functions:
         (a) FORMKP
         (b) ROTATION (for ITP=3,4&6)
         (c) ELKE
      3. Use the following examples to verify stiffness matrices [Kff]:
         (a) Consider a beam with an internal hinge at point b.
             There are three nodes a,b,and c; their coordinates are
             x=0,2L,and 3L, respectively, where L=3m. Young's modulus
             E=120 GPa and I=0.00008 m^4. The beam is fixed at nodes a and c,
             and is subjected to a downward load P=250 kN. (ITP=1)
         (b)Example 3.2 on page 36 of textbook (ITP=2)
         (c)Example 5.7 on page 115 of textbook (ITP=3)
         (d)The grid structure example discussed in class (ITP=4)
         (e)Example 5.4  on page 104 of textbook (ITP=5)
           *** You shall assemble the element stiffness matrices
               first in order to check the solution from your program.
         (f)Problem 5.10(c)(ITP=6) (on page 134 of textbook) but
            with the following changes:
             (1) delete member cd (only two members ab and bc)
             (2) Lengths: ab=4m, bc=6m
             (3) member ab: A=38000 mm^2, Iy=1400X10^6 mm^4 and Iz=380X10^6 mm^4
                             J=1600X10^6 mm^4
             (4) member bc: A=25000 mm^2, Iy=800X10^6 mm^4 and Iz=700X10^6 mm^4
                             J=2600X10^6 mm^4
             (5) Note that the local y-axis of member ab is along "-Z" direction
                 and that of member bc is along the "X" direction.
             (6) E=200 GPa and v=0.3
             (7) Assume there is no distributed load and a vertical force applied
                 at point C; its value=80 kN and the direction is downward.

