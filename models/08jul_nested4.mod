//Four alternatives: taxi or FHV, transit, other, and free

//V_1 = V_TAXI = ASC_TAXI + B_TT1 * TAXI_TT
//V_2 = V_TRANSIT = ASC_TRANSIT + B_TT2 * TRANSIT_TT + B_HYP * HYPERP
//V_3 = V_OTHER = ASC_OTHER + B_TT3 * TAXI_TT 
//V_4 = V_FREE = ASC_FREE 

[ModelDescription]
"Nothing here"

[Beta]
// Name Value LowerBound UpperBound status (0=variable, 1=fixed)
ASC_OTHER	0	-1000	1000	0
ASC_TRANSIT	0	-1000	1000	0
ASC_TAXI	0	-1000	1000	1
ASC_FREE	0	-1000	1000	0
B_HYP	0	-1000	1000	0
B_TT1	0	-1000	1000	0
B_TT2  	0	-1000	1000	0
B_TT3  	0	-1000	1000	0

[Choice]
CHOICE

[Utilities]
// Id Name     Avail       linear-in-parameter expression (beta1*x1 + beta2*x2 + ... )
    1 A1_TAXI    av2          ASC_TAXI * one
                            + B_TT1 * TAXI_TT
    2 A2_TRANSIT av1 ASC_TRANSIT * one 
                            + B_TT2 * TRANSIT_TT 
                            + B_HYP * HYPERP
    3 A3_OTHER   av3     ASC_OTHER * one
                            + B_TT3 * TAXI_TT
    4 A4_FREE    av4 ASC_FREE * one 

[Expressions]
one = 1

[Model]
// $NL stands for "nested logit model", 
$NL

[NLNests]
// Name Paramvalue  lb  ub   status   list_of_alt
NOTFREE    1.0     1.0   10.0   0     1  2  3
NOCOST      1.0     1.0   10.0   1     4
