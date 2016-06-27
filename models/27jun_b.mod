//Four alternatives: taxi or FHV, transit, other, and free

//V_1 = V_TAXI = ASC_TAXI + B_TT * TAXI_TT+ B_COST * TAXI_COST + B_INTL * INTL
//V_2 = V_TRANSIT = ASC_TRANSIT + B_TT * TRANSIT_TT + B_INTL * INTL
//V_3 = V_OTHER = ASC_OTHER + B_INTL * INTL
//V_4 = V_FREE = ASC_FREE + B_INTL * INTL

[ModelDescription]
"Nothing here"

[Beta]
// Name Value LowerBound UpperBound status (0=variable, 1=fixed)
ASC_OTHER	0	-1000	1000	0
ASC_TRANSIT	0	-1000	1000	0
ASC_TAXI	0	-1000	1000	1
ASC_FREE	0	-1000	1000	0
B_TT  	0	-1000	1000	0
B_COST		0	-1000	1000	0
B_INTL		0	-1000	1000	0

[Choice]
CHOICE

[Utilities]
// Id Name     Avail       linear-in-parameter expression (beta1*x1 + beta2*x2 + ... )
    1 A1_TAXI    av2          ASC_TAXI * one
                            + B_TT * TAXI_TT
                            + B_COST * TAXI_COST
                            + B_INTL * INTL
    2 A2_TRANSIT av1 ASC_TRANSIT * one 
                            + B_TT * TRANSIT_TT 
                            + B_INTL * INTL
    3 A3_OTHER   av3     ASC_OTHER * one 
                            + B_INTL * INTL
    4 A4_FREE    av4 ASC_FREE * one 
                            + B_INTL * INTL

[Expressions]
one = 1

[Model]
$MNL


    

