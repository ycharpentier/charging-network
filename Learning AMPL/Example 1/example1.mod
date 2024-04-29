# PART 1 : DECISION VARIABLES
var XB;
var XC;

# PART 2 : OBJECTIVE FUNCTION
maximize Profit: 25 * XB + 30 * XC;

# PART 3: CONSTRAINTS
subject to Time: (1/200) * XB + (1/140) * XC <= 40;
subject to B_limit: 0 <= XB <= 6000;
subject to C_limit: 0 <= XC <= 4000;
