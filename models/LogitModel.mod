//Three alternatives: transit, taxi and other

//V_1 = V_TRANSIT = ASC_TRANSIT + B_TT * TRANSIT_TT
//V_2 = V_TAXI = ASC_TAXI + B_TT * TAXI_TT+ B_COST * TAXI_COST
//V_3 = V_OTHER = ASC_OTHER 

[ModelDescription]
"Example of a logit model for a transportation mode choice" "with 3 alternatives:"
"- Transit"
"- Taxi"
"- Other"

[Beta]
// Name Value LowerBound UpperBound status (0=variable, 1=fixed)
ASC_OTHER	0	-1000	1000	0
ASC_TRANSIT	0	-1000	1000	0
ASC_TAXI	0	-1000	1000	1
B_TT  	0	-1000	1000	0
B_COST		0	-1000	1000	0

[Choice]
CHOICE

[Utilities]
// Id Name     Avail       linear-in-parameter expression (beta1*x1 + beta2*x2 + ... )
    1 A1_TRANSIT av1 ASC_TRANSIT * one 
                            + B_TT * TRANSIT_TT 
    2 A2_TAXI    av2          ASC_TAXI * one
                            + B_TT * TAXI_TT
                            + B_COST * TAXI_COST
    3 A3_OTHER   av3     ASC_OTHER * one 

[Expressions]
one = 1

[Model]
$MNL


    

