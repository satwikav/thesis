

*******************************
***  PREPARATION OF DATASET  ***
*******************************

****"male_female_weai_BIHS5503_appended_clean_March28.dta"
*use "male_female_weai_BIHS5503_appended_clean_March28.dta", clear
 
*cd "Z:\PHN\SHARED\Farha\WEA_NR_R2\Final data files_WEAI_NR\hh_male"

set more off

global p1="U:\BIHS2015\Round 2\Household\Dataset"
global p3="U:\BIHS2015\Round 2\Household\Dataset\updated"
global p3="U:\BIHS2015\temp"

use "$p3\male_female_weai_NR_appended_round2.dta", clear
save "$p3\male_female_weai_NR_appended_round2_updated.dta", replace


use "$p3\male_female_weai_NR_appended_round2_updated.dta", clear

/*
merge n:1 a01 using "Z:\PHN\SHARED\Farha\WEA_NR_R2\FarmHH_WEAI\farmer_R2_NR.dta"
keep if _merge==3
drop _m
*/

***********************
*** Modules B and G ***
***********************
qui recode we2_02_* we2_03_* (4 98=.)	
qui recode we2_01* (98=.)
***we2_01***

foreach x of num 1/6{
	gen partact_`x'=(we2_01_`x'==1)
	replace partact_`x'=. if we2_01_`x'==.
	} 	
egen partact=rowtotal(partact_*), missing
label var partact "Number of activities in which individual participates" // generating number of activities participated in 
egen partactagr=rowtotal(partact_1 partact_2 partact_3 partact_6), missing
label var partactagr "Number of agricultural activities in which individual participates" //generating number of agricultural activities participated in 
	
***b02,b03***

*Adequate if respondent has at least some decisionmaking power
foreach x of num 1/6{
	gen inputdec_`x'=(we2_02_`x'>2) if partact_`x'==1
	replace inputdec_`x'=. if we2_02_`x'==. & partact_`x'==1
	}

label var inputdec_1 "Has some input in decisions regarding food crop farming" //decision making regarding activity
label var inputdec_2 "Has some input in decisions regarding cash crop farming"
label var inputdec_3 "Has some input in decisions regarding livestock raising"
label var inputdec_4 "Has some input in decisions regarding non-farm activity"
label var inputdec_5 "Has some input in decisions regarding wage & salary employment"
label var inputdec_6 "Has some input in decisions regarding fishing"

foreach x of num 1/6{
	gen incomedec_`x'=(we2_03_`x'>1) if partact_`x'==1
	replace incomedec_`x'=. if we2_03_`x'==. & partact_`x'==1
	}

label var incomedec_1 "Has some input in decisions regarding income from food crop farming" // decision regarding income from activity
label var incomedec_2 "Has some input in decisions regarding income from cash crop farming"
label var incomedec_3 "Has some input in decisions regarding income from livestock raising"
label var incomedec_4 "Has some input in decisions regarding income from non-farm activity"
label var incomedec_5 "Has some input in decisions regarding income from wage & salary employment"
label var incomedec_6 "Has some input in decisions regarding income from fishing"

**********************
***we5a_01,we5a_02***

qui recode we5a_01a* we5a_01b* we5a_01c* we5a_02* (98=.)


foreach x in a b c d e f g{
	gen skip_`x'=(we5a_01a_`x'==1|we5a_01b_`x'==1| we5a_01c_`x'==1)
	*Adequate if feel can make decisions to some extent (g02) 
	*or actually makes decision	(g01)
	gen feelmakedec_`x'=(we5a_02_`x'>2)
	replace feelmakedec_`x'=1 if skip_`x'==1
	replace feelmakedec_`x'=. if skip_`x'!=1 & we5a_02_`x'==.
	replace feelmakedec_`x'=. if (we5a_01a_`x'==.& we5a_01b_`x'==.& we5a_01c_`x'==.) & we5a_02_`x'==.
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
egen feelinputdecagr_sum=rowtotal(feelmakedec_a-feelmakedec_d inputdec_1 inputdec_2 inputdec_3 inputdec_6), missing 
gen feelinputdecagr=(feelinputdecagr_sum>1)
replace feelinputdecagr=. if feelinputdecagr_sum==.
label var feelinputdecagr_sum "No. agr. domains individual has some input in decisions or feels can make decisions" // number of domains woman has input in decision making
label var feelinputdecagr "Has some input in decisions or feels can make decisions in AT LEAST TWO domains" // whether she feels empowered enough to make decisions in two domains at least

*CONTROL OVER USE OF INCOME: adequate if there is AT LEAST ONE domain in which individual has some input in income decisions or feels she/he can make decisions regarding wage, employment and minor hh 
*expenditures; as long the only domain in which the individual feels that he/she makes decisions IS NOT minor household expenditures
egen incomedec_sum=rowtotal(incomedec_1 incomedec_2 incomedec_3 incomedec_4 incomedec_5 incomedec_6 feelmakedec_e feelmakedec_g), missing
gen incdec_count=(incomedec_sum>0)
replace incdec_count=0 if incdec_count==1 & incomedec_sum==1 & (feelmakedec_g==1)
replace incdec_count=. if incomedec_sum==.
label var incomedec_sum "No. domains individual has some input in income decisions or feels can make decisions"
label var incdec_count "Has some input in income dec or feels can make dec AND not only minor hh expend"

*drop partact_* inputdec_1-incomedec_6 feelmakedec_a-feelmakedec_m	

***we5c_03 & we5c_05***
*******************next day
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
replace raiprod_any=1 if raiprod_any==.&partactagr==0
label var raiprod_any "Has RAI above one in at least on production activity"


*foreach x in a b c d e f g h i j k l m{
*	drop rai_`x' raiabove_`x'
*	}
************************

****************
*** Module C ***
****************
*qui recode wc0* wc1* (98=.)
sum haveasset* numberofasset* owner_* sell_decision_* distribution_decision_* rent_decision_* purchase_decision_*
qui recode haveasset* owner_* sell_decision_* distribution_decision_* rent_decision_* purchase_decision_* (98=.)
qui recode haveasset* (2=0)
***c01***
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


***we3a_02a- we3a_06c***
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
	
**Labels
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

*drop own_a- selfjointexchall_n	



******2015 08 25
***we3d_17***
foreach x in a b c d e{
	gen creditaccess_`x'=(we3d_17`x'>=1 & we3d_17`x'<=3)
	replace creditaccess_`x'=. if we3d_17`x'==.| we3d_17`x'==97
	}
egen creditaccess=rowtotal(creditaccess_*), missing
label var creditaccess "No. of credit sources that the hh uses"

***we3d_18, we3d_19***
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

*****keeping creditaccess/selfjointborrow/jointuse etc for the time being
/*
foreach y in a b c d e{
	drop creditaccess_`y' creditselfjointborrow_`y' creditselfjointuse_`y' creditselfjointanydec_`y' 
	}
*/
***************************
***Dimension 4: Module E***
***************************

qui recode we4* (98=.)


***we4_01 we4_02 we4_03 ***
*empowered if comfortable speaking in public
foreach x in 1 2 3{
gen speakpublic_`x'=(we4_0`x'>1)
replace speakpublic_`x'=. if we4_0`x'==.
	}

*AGGREGATION
*SPEAK IN PUBLIC: Adequate if comfortable speaking in public in AT LEAST ONE context
egen speakpublic_any=rowmax(speakpublic_1 speakpublic_2 speakpublic_3)

qui recode we4_08* (.=0)
***e07***
foreach x in a b c d e f g h i j k {
	*Active group member
	capture gen groupmember_`x'=(we4_08`x'==1)
	capture replace groupmember_`x'=. if we4_08`x'==.
	}

*AGGREGATION
*GROUP MEMBERSHIP: Adequate if individual is part of AT LEAST ONE group
egen groupmember_any=rowmax(groupmember_*)


*drop groupmember_a-groupinput_k


****************
*** Module F ***
****************

***f04***
*LEISURE TIME: Adequate if does not express any level of dissatisfaction with the amount of leisure time available

gen leisuretime=(we6b_04_b>4)
replace leisuretime=. if we6b_04_b==.

saveold "$p3\WEAI_all_indicators_NR_R2_2016 06 06.dta", replace

*"V:\PHN\SHARED\Nusrat\BIHS round 2\WEAI_Round II_USB\hh_Male\male_female_weai_ind_mod_we6a6b.dta"
*we6b_02
*use "male_female_weai_ind_mod_f01f02_5503March28.dta", clear
use "$p3\male_female_weai_ind_mod_we6a6b_NR.dta", clear

foreach x in we6b_02 we6b_07 we6b_10 we6b_11{
	qui recode `x' (2=0)
	}
*Define work (w/ commuting/travelling) 


qui gen w=(wacode>=5 & wacode<=16)
drop if w==0

*Calculate total time spent working as primary and secondary activity
//collapse (sum) f01_1 f01_2 (mean)  gendered_hh_type- wf11, by(wa01 file country)

collapse (sum) we6a01_1 we6a01_2 , by(a01 file country)


gen work=we6a01_1 + (.5*we6a01_2)

***Define poverty lines
*10 hr/day
qui gen z10=10*60
*10.5 hr/day
qui gen z105=10.5*60
*11 hr/day
qui gen z11=11*60
*75 hr/week
qui gen z75=(75/7)*60

foreach x of var z*{
	qui gen H_`x'=.
	foreach y in 1 2{
		qui gen H_`x'_`y'=.
		}
	}
	
foreach x of var z*{
	qui gen poor_`x'=(work>`x')
	foreach y in 1 2 3{
		*Headcount
		qui sum poor_`x' if country==`y'
		local q=r(sum)
		qui sum work if country==`y'
		local n=r(N)
		qui replace H_`x'=`q'/`n' if country==`y'
		foreach z in 1 2{
			*Headcount
			qui sum poor_`x' if country==`y' & file==`z'
			local q=r(sum)
			qui sum work if country==`y' & file==`z'
			qui replace H_`x'_`z'=`q'/r(N) if country==`y'
			}
		}
	}


	
foreach y in 1 2 3{
	foreach x in 10 105 11 75{
		qui sum H_z`x' if country==`y'
		local overall=r(mean)
		qui sum H_z`x'_1 if country==`y'
		local men=r(mean)
		qui sum H_z`x'_2 if country==`y'
		local women=r(mean)
*		post stats3 (5) (`y') (`x') (`overall') (`men') (`women')
		}
	}

saveold "$p3\Time_measure_NR_2016 06 06.dta", replace

// Merge time poverty measure with all indicators dataset //

use "$p3\WEAI_all_indicators_NR_R2_2016 06 06.dta", clear
//drop _m
sort a01 file
merge 1:1 a01 file using "$p3\Time_measure_NR_2016 06 06.dta", keepusing(poor_z10 poor_z105 poor_z75 poor_z11)
keep if _m!=2
drop _m

foreach x in 10 105 75 11 {
	gen npoor_z`x'=1-poor_z`x'
	}
	

gen country=1
//drop _m
saveold "$p3\WEAI_all_indicators_NR_R2_2016 06 06_V1.dta", replace


use "$p1\003_r2_mod_b1_male.dta", clear

merge n:1 a01 using "$p1\002_r2_mod_a_female.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

tab hh_type
keep if hh_type==2 | hh_type==3
sort  a01 mid  b1_03

tab  b1_01

gen aux11=1 if b1_01==1 &  b1_02>17
gen aux22=2 if b1_01==2 &  b1_02>17
gen aux33=4 if b1_02<18

replace aux1=0 if aux1==.

sort a01

by a01:egen aux111=max(aux11) 
by a01:egen aux222=max(aux22) 
by a01:egen aux333=max(aux33) 

egen float aux5 = rowtotal(aux111 aux222)
tab aux5 

gen gendered_hh_type=.
replace gendered_hh_type=1 if aux5==2
replace gendered_hh_type=2 if aux5==3
replace gendered_hh_type=3 if aux5==1
replace gendered_hh_type=4 if aux5==4

tab gendered_hh_type
inspect gendered_hh_type

//label variable gendered_hh_type "gendered household type"
//label define gendered_hh_type 1 "ad fem no ad male" 2 "ad male&female" 3 "ad male no adfem"  4 "child no adult"
//label values gendered_hh_type gendered_hh_type

collapse (max) gendered_hh_type, by (a01)

label variable gendered_hh_type "gendered household type"
label define gendered_hh_type 1 "ad fem no ad male" 2 "ad male&female" 3 "ad male no adfem"  4 "child no adult"
label values gendered_hh_type gendered_hh_type
tab gendered_hh_type

//rename a01 wa01
saveold "$p3\gendered_hhtype_NR_R2.dta", replace

use "$p3\gendered_hhtype_NR_R2.dta", clear
merge 1:n a01 using "$p3\WEAI_all_indicators_NR_R2_2016 06 06_V1.dta"
keep if _m==3
drop _m


tab b1_02, m
drop if b1_02<18 //too young
drop if b1_02>90 //too old

tab b1_03, m
ta b1_03, nol
drop if b1_03>2 //keeping only household heads and spouses

*merge m:1 a01 using "Z:\PHN\SHARED\Farha\Adhoc analysis\USAID FTF2 project\data files\FTFhh_quintles_R2.dta"
*keep if _m==3
*keep if quintile==5

*merge m:1 a01 using "Z:\PHN\SHARED\Farha\Adhoc analysis\USAID FTF2 project\data files\farm_sizeFTF2.dta"
*keep if _m==3 
*keep if farmer==4

saveold "$p3\WEAI_all_indicators_NR_R2_2016 06 06_V2.dta", replace










