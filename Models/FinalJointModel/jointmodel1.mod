# Define sets
set WH;  # Set of candidate warehouses
set CS;  # Set of candidate charging stations
set DE;  # Set of demand clusters

# Define parameters
param a1{WH, CS} binary;          # CS is in the range of WH
param a2{CS, DE} binary;          # DE is in range of CS
param a3{CS, CS} binary;          # CS is in range of another CS
param dk{DE} >= 0;                # Demand at cluster k
param a_ik{WH, DE} >= 0;          # Cost to ship from WH to DE
param c{WH} >= 0;                 # Cost of setting up a warehouse
param b{CS} >= 0;                 # Cost of setting up a charging station
param K{WH} >= 0;                 # WH capacity

# Define decision variables
var x{WH} binary;               
var y{CS} binary;                 
var s{WH, DE} >= 0;   

# Define objective function
minimize Cost:
    sum {i in WH} c[i] * x[i] +
    sum {i in WH, k in DE} a_ik[i,k] * s[i,k] +
    sum {j in CS} b[j] * y[j];

# Define constraints
subject to WhCapacity {i in WH}:
    sum {k in DE} s[i,k] <= K[i] * x[i];

subject to DemandMeeting {k in DE}:
    sum {i in WH} s[i,k] = dk[k];

subject to FeasibleTrip_WH_CS {i in WH}:
    sum {j in CS} a1[i,j] * y[j] >= x[i];

subject to FeasibleTrip_CS_DE {k in DE}:
    sum {j in CS} a2[j,k] * y[j] >= 1;

subject to FeasibleTrip_CS_CS {j in CS}:
    sum {j_prime in CS: j_prime != j} a3[j,j_prime] * y[j_prime] >= y[j];