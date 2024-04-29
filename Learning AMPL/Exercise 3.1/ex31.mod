set PLANTS;
set CUSTOMERS;

param cap {PLANTS}>=0; #capacity parameter
param demand {CUSTOMERS}>=0; #demand parameters
check: sum {i in PLANTS} cap[i] >= sum {j in CUSTOMERS} demand[j];

param distance {PLANTS,CUSTOMERS} >= 0;

param cost>=0;

var ship {PLANTS, CUSTOMERS} >= 0; # decision variable 

maximize total_cost:
	sum{i in PLANTS, j in CUSTOMERS} (cost*distance[i,j]/1000)*ship[i,j]; # cost is given in thousand of miles
	
	
subject to Demand_C {j in CUSTOMERS}: # meet the points' demand
	sum {i in PLANTS} ship[i,j] = demand[j];
	
subject to Supply_C {i in PLANTS}: # constraint : not excess the plants' capicity
	sum {j in CUSTOMERS} ship[i,j] <= cap[i];
