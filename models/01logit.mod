// File: 01logit.mod
// Author: Michel Bierlaire, EPFL
// Date: Fri Nov 12 16:43:52 2010
//
// Logit model
// Three alternatives: Train, Car and Swissmetro
// SP data

[ModelDescription]
"Example of a logit model for a transportation mode choice with 3 alternatives:"
"- Train"
"- Car"
"- Swissmetro, an hypothetical high-speed train"

[Choice]
CHOICE   

[Beta]
// Name Value  LowerBound UpperBound  status (0=variable, 1=fixed)
ASC_CAR 	0 -10              10              0
ASC_TRAIN  	0 -10              10              0
ASC_SM	        0 -10              10              1
B_TIME		0 -10              10              0
B_COST		0 -10              10              0

[LaTeX]
ASC_CAR "Cte. car"
ASC_SBB "Cte. train"
ASC_SM	"Cte. Swissmetro"
B_TIME	"$\beta_\text{time}$"
B_COST	"$\beta_\text{cost}$"

[Utilities]
// Id Name     Avail       linear-in-parameter expression (beta1*x1 + beta2*x2 + ... )
    1 A1_TRAIN TRAIN_AV_SP ASC_TRAIN * one 
                            + B_TIME * TRAIN_TT_SCALED 
                            + B_COST * TRAIN_COST_SCALED
    2 A2_SM    SM_AV          ASC_SM * one
                            + B_TIME * SM_TT_SCALED
                            + B_COST * SM_COST_SCALED
    3 A3_Car   CAR_AV_SP     ASC_CAR * one 
                            + B_TIME * CAR_TT_SCALED
                            + B_COST * CAR_CO_SCALED

[Expressions] 
// Define here arithmetic expressions for name that are not directly 
// available from the data
one = 1
CAR_AV_SP =  CAR_AV   * (  SP   !=  0  )
TRAIN_AV_SP =  TRAIN_AV   * (  SP   !=  0  )
//If the person has a GA (season ticket) her incremental cost is actually 0 
//rather than the cost value gathered from the
// network data. 
SM_COST =  SM_CO   * (  GA   ==  0  ) 
TRAIN_COST =  TRAIN_CO   * (  GA   ==  0  )
// For numerical reasons, it is good practice to scale the data to
// that the values of the parameters are around 1.0. 
// A previous estimation with the unscaled data has generated
// parameters around -0.01 for both cost and time. Therefore, time and
// cost are multipled my 0.01.
TRAIN_TT_SCALED = TRAIN_TT / 100.0
TRAIN_COST_SCALED = TRAIN_COST / 100
SM_TT_SCALED = SM_TT / 100.0
SM_COST_SCALED = SM_COST / 100
CAR_TT_SCALED = CAR_TT / 100
CAR_CO_SCALED = CAR_CO / 100

[Exclude]
// All observations verifying the following expression will not be
// considered for estimation
// The modeler here has developed the model only for work trips.  
// Observations such that the dependent variable CHOICE is 0 are also removed.
(( PURPOSE != 1 ) * (  PURPOSE   !=  3  ) + ( CHOICE == 0 )) 

[Model]
// $MNL stands for "multinomial logit model", 
$MNL
