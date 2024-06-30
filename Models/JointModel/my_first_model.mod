# Define sets
set CS;
set WH;
set DE;

# Define parameters
param a1{WH, CS} binary;
param a2{CS, DE} binary;	
param dk{DE}>=0; 			#demand parameters
param a_ik{WH,DE}>=0; 		#cost to ship $/qt to ship
param c{WH}>=0; 			# cost of setting up a warehouse
param b{CS}>=0; 			# cost of setting up a charging station
param K{WH}>=0; 			# WH capacity 

# Define decision variables
var x{WH} binary;
var y{CS} binary;
var s{WH,DE}>=0;

# Define objective function
minimize Cost:
    sum {i in WH} c[i]*x[i] + sum {i in WH} sum {k in DE} s[i,k]*a_ik[i,k] + sum {j in CS} y[j]*b[j];

# Define constraints
subject to WhCapacity {i in WH}:
	sum{k in DE} s[i,k] <= K[i]*x[i];
	
subject to FeasibleTrip {i in WH, k in DE}:
	sum{j in CS} a1[i,j]*a2[j,k]*y[j] >= x[i];
	
subject to DemandMeeting {k in DE}:
    sum {i in WH} s[i,k] = dk[k];