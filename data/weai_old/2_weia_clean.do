*******************************
***  PREPARATION OF DATASET  ***
*******************************
/////////Module WE2: Role in household decision-making around production and income generation
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/weia.dta", clear
rename we2_01_31 we2_01_3
rename we2_02_31 we2_02_3
rename we2_03_31 we2_03_3
rename we2_01_32 we2_01_7
rename we2_02_32 we2_02_7
rename we2_03_32 we2_03_7
rename we2_01_33 we2_01_8
rename we2_02_33 we2_02_8
rename we2_03_33 we2_03_8
qui recode we2_02_* we2_03_* (5 7 = .) 
foreach x of num 1/8 {
	gen partact_`x'=(we2_01_`x'==1)
	replace partact_`x'=. if we2_01_`x'==.
} 	
egen partact=rowtotal(partact_*), missing
label var partact "Number of activities in which individual participates" // generating number of activities participated in 
egen partactagr=rowtotal(partact_1 partact_2 partact_3 partact_7 partact_8 partact_6), missing
label var partactagr "Number of agricultural activities in which individual participates" //generating number of agricultural activities participated in
*Adequate if respondent has at least some decisionmaking power
foreach x of num 1/8{
	gen inputdec_`x'=(we2_02_`x'>2) if partact_`x'==1
	replace inputdec_`x'=. if we2_02_`x'==. & partact_`x'==1
	}
label var inputdec_1 "Has some input in decisions regarding food crop farming" //decision making regarding activity
label var inputdec_2 "Has some input in decisions regarding cash crop farming"
label var inputdec_3 "Has some input in decisions regarding large livestock raising"
label var inputdec_4 "Has some input in decisions regarding non-farm activity"
label var inputdec_5 "Has some input in decisions regarding wage & salary employment"
label var inputdec_6 "Has some input in decisions regarding fishing"
label var inputdec_7 "Has some input in decisions regarding small livestock raising"
label var inputdec_8 "Has some input in decisions regarding poultry"
foreach x of num 1/8{
	gen incomedec_`x'=(we2_03_`x'>2) if partact_`x'==1
	replace incomedec_`x'=. if we2_03_`x'==. & partact_`x'==1
	}
label var incomedec_1 "Has some input in decisions regarding income from food crop farming" // decision regarding income from activity
label var incomedec_2 "Has some input in decisions regarding income from cash crop farming"
label var incomedec_3 "Has some input in decisions regarding income from large livestock raising"
label var incomedec_4 "Has some input in decisions regarding income from non-farm activity"
label var incomedec_5 "Has some input in decisions regarding income from wage & salary employment"
label var incomedec_6 "Has some input in decisions regarding income from fishing"
label var incomedec_7 "Has some input in decisions regarding income from small livestock raisinging"
label var incomedec_8 "Has some input in decisions regarding income from poultry"
/////////Module WE5a: Decision Making
qui recode we5a_01a* we5a_01b* we5a_01c* we5a_02* (98=.)
foreach x in a b c d e f g{
	gen skip_`x'=((we5a_01a_`x'==1)| (we5a_01b_`x'==1)| (we5a_01c_`x'==1))
	*Adequate if feel can make decisions to some extent (g02) 
	*or actually makes decision	(g01)
	gen feelmakedec_`x'=(we5a_02_`x'>2)
	replace feelmakedec_`x'=1 if skip_`x'==1
	replace feelmakedec_`x'=. if skip_`x'!=1 & we5a_02_`x'==.
	replace feelmakedec_`x'=. if we5a_01a_`x'== . & we5a_01b_`x'== . & we5a_01c_`x'== . & we5a_02_`x'== .
	}
drop skip*	
label var feelmakedec_a "Feels can make decisions regarding purchasing inputs for agricultural production"
label var feelmakedec_b "Feels can make decisions regarding types of crops to grow"
label var feelmakedec_c "Feels can make decisions regarding taking crops to the market"
label var feelmakedec_d "Feels can make decisions regarding livestock raising"
label var feelmakedec_e "Feels can make decisions regarding wage or salary employment"
label var feelmakedec_f "Feels can make decisions regarding major household expenditures"
label var feelmakedec_g "Feels can make decisions regarding minor household expenditures"
*AGGREGATION
*INPUT IN PRODUCTIVE DECISIONS: adequate if there is AT LEAST TWO domains in which individual has some input in decisions, 
*or makes the decision, or feels he/she could make it if he/she wanted
egen feelinputdecagr_sum=rowtotal(feelmakedec_a-feelmakedec_d inputdec_1 inputdec_2 inputdec_3 inputdec_6 inputdec_7 inputdec_8), missing 
gen feelinputdecagr=(feelinputdecagr_sum>1)
replace feelinputdecagr=. if feelinputdecagr_sum==.
label var feelinputdecagr_sum "No. agr. domains individual has some input in decisions or feels can make decisions" // number of domains woman has input in decision making
label var feelinputdecagr "Has some input in decisions or feels can make decisions in AT LEAST TWO domains" // whether she feels empowered enough to make decisions in two domains at least
*CONTROL OVER USE OF INCOME: adequate if there is AT LEAST ONE domain in which individual has some input in income decisions or feels she/he can make decisions regarding wage, employment and minor hh 
*expenditures; as long the only domain in which the individual feels that he/she makes decisions IS NOT minor household expenditures
egen incomedec_sum=rowtotal(incomedec_1 incomedec_2 incomedec_3 incomedec_4 incomedec_5 incomedec_6 incomedec_7 incomedec_8 feelmakedec_e feelmakedec_f feelmakedec_g), missing
gen incdec_count=(incomedec_sum>0)
replace incdec_count=0 if incdec_count==1 & incomedec_sum==1 & feelmakedec_g==1
replace incdec_count=. if incomedec_sum==.
label var incomedec_sum "No. domains individual has some input in income decisions or feels can make decisions"
label var incdec_count "Has some input in income dec or feels can make dec AND not only minor hh expend"


/////////Module WE5b: Motivation for decision-making
label define motivationind_lab 1 "Never true" 2 "Not very true" 3 "Somewhat true" 4 "Always true"
foreach x in 01 02 03 04 {
	foreach v in we5ba we5bb we5bc {
		recode `v'_`x'_2 (98=.) (2=3) (1=4) /*recode: somewhat true, always true */
		gen v_`v'_`x'=`v'_`x'_3 /*pick up response from q3, codes already match: never true, not very true */
		replace v_`v'_`x'=`v'_`x'_2 if `v'_`x'_1==1
		label values v_`v'_`x' motivationind_lab
		tab v_`v'_`x' `v'_`x'_3 if `v'_`x'_1==2, miss
		tab v_`v'_`x' `v'_`x'_2 if `v'_`x'_1==1, miss
		tab v_`v'_`x', miss
		}
	}
foreach x in a b c {
	gen rai_`x' = -2*v_we5b`x'_02 - v_we5b`x'_03 + 3*v_we5b`x'_04
	gen raiabove_`x'=( rai_`x'>1)
	replace raiabove_`x'=. if rai_`x'==.
	}
label var raiabove_a "RAI above 1 regarding types of crops to grow for consumption and sale at market"
label var raiabove_b "RAI above 1 regarding taking crops to the market"
label var raiabove_c "RAI above 1 regarding livestock raising"
*AGGREGATION 
** AUTONOMY IN PRODUCTION: adequate if RAI>1 in AT LEAST ONE domain/activity linked to production
*egen raiprod_any=rowmax(raiabove_a raiabove_b raiabove_c raiabove_d raiabove_e)
*replace raiprod_any=1 if raiprod_any==.&partactagr==0
*label var raiprod_any "Has RAI above one in at least on production activity"
egen raiprod_any=rowmax(raiabove_a raiabove_b raiabove_c)
replace raiprod_any=1 if raiprod_any == . & partactagr == 0
label var raiprod_any "Has RAI above one in at least on production activity"
/////////Module WE3a: Access to productive capital 
qui recode haveasset* owner_* sell_decision_* distribution_decision_* rent_decision_* purchase_decision_* (98=.)
qui recode haveasset* (2=0)
foreach x in 1 2 3 4 5 6 7 8 9 10 11 12 13 14{
	gen own_`x'=(haveasset`x'==1 & numberofasset`x'!=0)
	replace own_`x'=. if haveasset`x'==. 
	}
label var own_1 "Household owns agricultural land"
label var own_2 "Household owns large livestock"
label var own_3 "Household owns small livestock"
label var own_4 "Household owns chickens, ducks, turkeys, pigeons"
label var own_5 "Household owns agricultural fish pond or fishing equipment"
label var own_6 "Household owns farm equipment (non-mechanized)"
label var own_7 "Household owns farm equipment (mechanized)"
label var own_8 "Household owns non-farm business equipment"
label var own_9 "Household owns house (or other structures)"
label var own_10 "Household owns large consumer durables (fridge, TV)"
label var own_11 "Household owns small consumer durables (radio, cookware)"
label var own_12 "Household owns cell phone"
label var own_13 "Household owns non-agricultural land"
label var own_14 "Household owns means of transportation"
*Aggregation
*Sum types of assets hh owns
egen own_sum=rowtotal(own_1-own_14), missing
egen ownagr_sum=rowtotal(own_1-own_7), missing
label var own_sum "No. of types of assets household owns"
label var ownagr_sum "No. of types of agricultural assets household owns"
foreach x in 1 2 3 4 5 6 7 8 9 10 11 12 13 14{
	*Self or joint own most
	gen selfjointown_`x'=(owner_a`x'==1 | owner_b`x'==1 | owner_c`x'==1) if own_`x'==1
	replace selfjointown_`x'=. if owner_a`x'==. & owner_b`x'==. & owner_c`x'==. & own_`x'==1
	
	*Self or joint decide to sell
	gen selfjointsell_`x'=(sell_decision_a`x'==1 | sell_decision_b`x'==1 | sell_decision_c`x'==1) if own_`x'==1
	replace selfjointsell_`x'=. if sell_decision_a`x'==. & sell_decision_b`x'==. & sell_decision_c`x'==. & own_`x'==1
	
	*Self or joint decide to give away
	gen selfjointgive_`x'=(distribution_decision_a`x'==1 | distribution_decision_b`x'==1 | distribution_decision_c`x'==1) if own_`x'==1
	replace selfjointgive_`x'=. if distribution_decision_a`x'==. & distribution_decision_b`x'==. & distribution_decision_c`x'==. & own_`x'==1
	
	*Self or joint mortgage or rent	
	gen selfjointrent_`x'=(rent_decision_a`x'==1 | rent_decision_b`x'==1 | rent_decision_c`x'==1) if own_`x'==1
	replace selfjointrent_`x'=. if rent_decision_a`x'==. & rent_decision_b`x'==. & rent_decision_c`x'==. & own_`x'==1
	
	*Self or joint buy
	gen selfjointbuy_`x'=(purchase_decision_a`x'==1 | purchase_decision_b`x'==1 | purchase_decision_c`x'==1) if own_`x'==1
	replace selfjointbuy_`x'=. if purchase_decision_a`x'==. & purchase_decision_b`x'==. & purchase_decision_c`x'==. & own_`x'==1


	*Rights
	**Makes AT LEAST ONE type of decision
	egen selfjointrightany_`x'=rowmax(selfjointsell_`x' selfjointgive_`x' selfjointrent_`x' selfjointbuy_`x')
	replace selfjointrightany_`x'=. if own_`x'==.
}
foreach x in own{
	label var selfjoint`x'_1 "Jointly `x's most of agricultural land"
	label var selfjoint`x'_2 "Jointly `x's most of large livestock"
	label var selfjoint`x'_3 "Jointly `x's most of small livestock"
	label var selfjoint`x'_4 "Jointly `x's most of chickens, turkeys, ducks"
	label var selfjoint`x'_5 "Jointly `x's most of fish pond or fishing equipment"
	label var selfjoint`x'_6 "Jointly `x's most of farm equipment (non-mechanized)"
	label var selfjoint`x'_7 "Jointly `x's most of farm equipment (mechanized)"
	label var selfjoint`x'_8 "Jointly `x's most of non-farm business equipment"
	label var selfjoint`x'_9 "Jointly `x's most of the house (or other structures)"
	label var selfjoint`x'_10 "Jointly `x's most of large consumer durables"
	label var selfjoint`x'_11 "Jointly `x's most of small consumer durables"
	label var selfjoint`x'_12 "Jointly `x's most of cell phone"
	label var selfjoint`x'_13 "Jointly `x's most of non-agricultural land"
	label var selfjoint`x'_14 "Jointly `x's most of means of transportation "
}
foreach x in sell give rent buy{
	label var selfjoint`x'_1 "Jointly can `x' agricultural land"
	label var selfjoint`x'_2 "Jointly can `x' large livestock"
	label var selfjoint`x'_3 "Jointly can `x' small livestock"
	label var selfjoint`x'_4 "Jointly can `x' chickens, turkeys, ducks"
	label var selfjoint`x'_5 "Jointly can `x' fish pond or fishing equipment"
	label var selfjoint`x'_6 "Jointly can `x' farm equipment (non-mechanized)"
	label var selfjoint`x'_7 "Jointly can `x' farm equipment (mechanized)"
	label var selfjoint`x'_8 "Jointly can `x' non-farm business equipment"
	label var selfjoint`x'_9 "Jointly can `x' the house (or other structures)"
	label var selfjoint`x'_10 "Jointly can `x' large consumer durables"
	label var selfjoint`x'_11 "Jointly can `x' small consumer durables"
	label var selfjoint`x'_12 "Jointly can `x' cell phone"
	label var selfjoint`x'_13 "Jointly can `x' non-agricultural land"
	label var selfjoint`x'_14 "Jointly can `x' means of transportation "
}
label var selfjointrightany_1 "Jointly has AT LEAST ONE right over agricultural land"
label var selfjointrightany_2 "Jointly has AT LEAST ONE right over large livestock"
label var selfjointrightany_3 "Jointly has AT LEAST ONE right over small livestock"
label var selfjointrightany_4 "Jointly has AT LEAST ONE right over chickens, turkeys, ducks"
label var selfjointrightany_5 "Jointly has AT LEAST ONE right over fishing equipment"
label var selfjointrightany_6 "Jointly has AT LEAST ONE right over farm equipment (non-mechanized)"
label var selfjointrightany_7 "Jointly has AT LEAST ONE right over farm equipment (mechanized)"
label var selfjointrightany_8 "Jointly has AT LEAST ONE right over non-farm business equipment"
label var selfjointrightany_9 "Jointly has AT LEAST ONE right over house (or other structures)"
label var selfjointrightany_10 "Jointly has AT LEAST ONE right over large consumer durables"
label var selfjointrightany_11 "Jointly has AT LEAST ONE right over small consumer durables"
label var selfjointrightany_12 "Jointly has AT LEAST ONE right over cell phone"
label var selfjointrightany_13 "Jointly has AT LEAST ONE right over non agricultural land"
label var selfjointrightany_14 "Jointly as AT LEAST ONE right over means of transportation"
*AGGREGATION
*OWNERSHIP: Adequate if selfjoint owns AT LEAST two small assets (chicken,  farming equipment non-mechanized, and small consumer durables)  OR one large asset (all the other). 
	* This is the same to say: empowered if owns AT LEAST one assets and that asset is not a small asset.
	* Inadequate if lives in a household that owns no assets
foreach x in own{
	egen selfjoint`x'sum=rowtotal(selfjoint`x'_*), missing
	egen j`x'count=rowmax(selfjoint`x'_*)
	replace j`x'count=0 if j`x'count==1 & selfjoint`x'sum==1 &(selfjointown_4==1|selfjointown_6==1|selfjointown_11==1)
	replace j`x'count=0 if own_sum==0
	rename j`x'count j`x'_count
	rename selfjoint`x'sum selfjoint`x'_sum	
}
*PURCHASE, SALE OR TRANSFER OF ASSETS: Adequate if selfjoint has AT LEAST ONE type of right
*over AT LEAST ONE type of asset as long as it is not chicken nor farming equipment non-mechanized.
*Inadequate if living in households with no assets are automatically adequate	
foreach x in rightany{
	*Agricultural assets
	egen selfjoint`x'agrsum=rowtotal(selfjoint`x'_1 selfjoint`x'_2 selfjoint`x'_3 selfjoint`x'_4 selfjoint`x'_5 selfjoint`x'_6 selfjoint`x'_7), missing
	egen selfjoint`x'agrcount=rowmax(selfjoint`x'_1 selfjoint`x'_2 selfjoint`x'_3 selfjoint`x'_4 selfjoint`x'_5 selfjoint`x'_6 selfjoint`x'_7)
	replace selfjoint`x'agrcount=0 if selfjoint`x'agrcount==1 & selfjoint`x'agrsum==1 & (selfjoint`x'_4==1|selfjoint`x'_6==1)
	replace selfjoint`x'agrcount=0 if ownagr_sum==0
	rename selfjoint`x'agrsum selfjoint`x'agr_sum
	rename selfjoint`x'agrcount j`x'agr
}
label var jrightanyagr "Jointly has AT LEAST ONE right in AT LEAST ONE agricultural asset the hh owns"
/////////Module WE3D: Access to loans
foreach x in a b c d e{
	gen creditaccess_`x'=(we3d_17`x'>=1 & we3d_17`x'<=3)
	replace creditaccess_`x'=. if we3d_17`x'==.| we3d_17`x'==97
}
egen creditaccess=rowtotal(creditaccess_*), missing
label var creditaccess "No. of credit sources that the hh uses"
foreach y in a b c d e{
	*Self or joint decide to borrow
	gen creditselfjointborrow_`y'=(we3d_18a_`y'==1 | we3d_18b_`y'==1 | we3d_18c_`y'==1) if creditaccess_`y'==1
	replace creditselfjointborrow_`y'=. if we3d_18a_`y'==. & we3d_18b_`y'==. & we3d_18c_`y'==. & creditaccess_`y'==1
	
	*Self or joint decide how to use
	gen creditselfjointuse_`y'=(we3d_19a_`y'==1 | we3d_19b_`y'==1 | we3d_19c_`y'==1) if creditaccess_`y'==1 
	replace creditselfjointuse_`y'=. if we3d_19a_`y'==. & we3d_19b_`y'==. & we3d_19c_`y'==. & creditaccess_`y'==1
	
	*Self or joint makes AT LEAST ONE decision regarding credit
	egen creditselfjointanydec_`y'=rowmax(creditselfjointborrow_`y' creditselfjointuse_`y')
}
foreach x in borrow use {
	label var creditselfjoint`x'_a "Jointly made decision about `x' credit from NGO"
	label var creditselfjoint`x'_b " Jointly made decision about `x' credit from informal lender"
	label var creditselfjoint`x'_c " Jointly made decision about `x' credit from formal lender"
	label var creditselfjoint`x'_d " Jointly made decision about `x' credit from friends & relatives"
}
label var creditselfjointanydec_a "Jointly made AT LEAST ONE decision regarding credit from NGO"
label var creditselfjointanydec_b "Jointly made AT LEAST ONE decision regarding credit from informal lender"
label var creditselfjointanydec_c "Jointly made AT LEAST ONE decision regarding credit from formal lender"
label var creditselfjointanydec_d "Jointly made AT LEAST ONE decision regarding credit from friends & relatives"
*AGGREGATION
*ACCESS TO AND DECISIONS ON CREDIT: Adequate if self/selfjoint makes dec regarding AT LEAST ONE source of credit AND has at least one source of credit
foreach x in anydec {
	egen creditselfjoint`x'any=rowmax(creditselfjoint`x'_*)
	replace creditselfjoint`x'any=0 if creditaccess==0
	rename creditselfjoint`x'any credj`x'_any 
}
label var credjanydec_any "Jointly makes AT LEAST ONE decision regarding AT LEAST ONE source of credit"
/////////Module WE4: Individual Leadership and Influence in the Community 
qui recode we4* (98=.)
foreach x in 1 2 3{
gen speakpublic_`x'=(we4_0`x'>1)
replace speakpublic_`x'=. if we4_0`x'==.
}
*AGGREGATION
*SPEAK IN PUBLIC: Adequate if comfortable speaking in public in AT LEAST ONE context
egen speakpublic_any=rowmax(speakpublic_1 speakpublic_2 speakpublic_3)
qui recode we4_08* (.=0)
foreach x in a b c d e f g h i j k {
	*Active group member
	capture gen groupmember_`x'=(we4_08`x'==1)
	capture replace groupmember_`x'=. if we4_08`x'==.
}
*AGGREGATION
*GROUP MEMBERSHIP: Adequate if individual is part of AT LEAST ONE group
egen groupmember_any=rowmax(groupmember_*)
/////////Module WE6b: Satisfaction with Time Allocation
*LEISURE TIME: Adequate if does not express any level of dissatisfaction with the amount of leisure time available
gen leisuretime=(we6b_04_b>4)
replace leisuretime=. if we6b_04_b==. 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/all_indicators.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/weia_6a6b.dta", clear
*Define work (w/ commuting/travelling) 
qui gen w=(wacode>=5 & wacode<=13)
drop if w==0
*Calculate total time spent working as primary and secondary activity
collapse (sum) we6a01_1 we6a01_2 , by(a01 file)
gen work=we6a01_1 + (.5*we6a01_2)
***Define poverty lines
*10.5 hr/day
gen z105=10.5*60
gen poor_z105 = work > z105
gen npoor_z105 = 1-poor_z105
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/time_measure.dta",replace
//Merge time poverty measure with all indicators dataset
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/all_indicators.dta", clear
sort a01 file
merge 1:1 a01 file using "/Users/satwikav/Documents/GitHub/thesis/data/weai/time_measure.dta",
keep a01 mid b1_01 b1_03 wa05 wa06 feelinputdecagr raiprod_any jown_count jrightanyagr credjanydec_any incdec_count groupmember_any speakpublic_any npoor_z105 leisuretime file
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/all_indicators.dta",replace
