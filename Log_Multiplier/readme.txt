**********************************************************************************************************************************
**********************************************************************************************************************************

Logarithmic multiplication introduces an operand conversion from integer number system into the logarithm number system(LNS). 
The multiplication of the two operands N1 and N2 is performedin three phases, calculating the operand logarithms, t
he addition of the operand logarithms and the calculation of the antilogarithm,
which is equal to the multiple of the two original operands.
The main advantage of this method is the substitution of the
multiplication with addition, after the conversion of the operands
into logarithms. LNS multipliers can be generally divided into
two categories, one based on methods that use lookup tables and
interpolations, and the other based on Mitchell’s algorithm (MA)
although there is a lookup-table approach in some of the MA-based methods.
**********************************************************************************************************************************
**********************************************************************************************************************************

A logarithmic number system is introduced to simplify multiplication, especially in cases when the accuracy requirements are
not rigorous. In LNS two operands are multiplied by finding their
logarithms, adding them, and after that looking for the antilogarithm
of the sum.
One of the most significant multiplication methods in LNS is
Mitchell’s algorithm. An approximation of the logarithm and
the antilogarithm is essential, and it is derived from a binary representation
of the numbers.

**********************************************************************************************************************************
**********************************************************************************************************************************

SOURCE : https://www.sciencedirect.com/science/article/abs/pii/S0141933110000438
