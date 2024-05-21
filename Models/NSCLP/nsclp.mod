# Define sets
set DEMAND_POINTS;
set CANDIDATE_LOCATIONS;

# Define parameters
param a{DEMAND_POINTS, CANDIDATE_LOCATIONS} binary;
check {i in DEMAND_POINTS}: sum{j in CANDIDATE_LOCATIONS} a[i, j] >= 1; # Solvable

param b{j in CANDIDATE_LOCATIONS, k in CANDIDATE_LOCATIONS: k != j};
param c{CANDIDATE_LOCATIONS}>=0;

# Define decision variables
var x{CANDIDATE_LOCATIONS} binary;

# Define objective function
minimize Cost:
    sum {j in CANDIDATE_LOCATIONS} c[j]*x[j];
    
# Define constraints
subject to DemandCoverage {i in DEMAND_POINTS}:
    sum {j in CANDIDATE_LOCATIONS} a[i,j] * x[j] >= 1;
    
subject to CandidateCoverage{j in CANDIDATE_LOCATIONS}:
    x[j] <= sum{k in CANDIDATE_LOCATIONS: k != j} b[j,k] * x[k];