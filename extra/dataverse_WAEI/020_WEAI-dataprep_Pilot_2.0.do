** DO FILE HAS BEEN PREPARED BY ANA VAZ AND SABINA ALKIRE AT WWW.OPHI.ORG.UK //
** FOR THE CALCULATION OF THE WOMEN'S EMPOWERMENT IN AGRICULTURE INDEX OF USAID.
** THERE ARE TWO FILES YOU NEED TO MAKE THE INDEX; THIS ONE (DATAPREP) AND WEAI. 
** LAST UPDATE: HAZEL MALAPIT / MARCH 2015

cd "D:\Users\ksproule\Dropbox\WEAI_Pilot\Public Release" // IMPORTANT: Change directory
capture log close
clear all
set more off
log using "logs\dataprep_Pilot_2.0_24hr.txt", text replace 


*******************************
***  PREPARATION OF DATASET ***  
*******************************

use "clean data\ind_allcountries_merged_2.0_clean.dta", clear
renvars, subst(_p2) // harmonize varnames across pilot types

********************************************************
*** Production and Income Domains: Modules G2 and G4 *** 
********************************************************

qui recode g2_0* (98=.)	// code as missing: 98=decision not made/not applicable

***g2.01***

foreach x in a b c d e f {
	gen partact_`x'=(g2_01_`x'==1)
	replace partact_`x'=. if g2_01_`x'==.
	} 	
egen partact=rowtotal(partact_*), missing
label var partact "Number of activities in which individual participates"
egen partactagr=rowtotal(partact_a partact_b partact_c partact_f), missing
label var partactagr "Number of agricultural activities in which individual participates"
	
***g2.03, g2.05***

*Adequate if respondent has at least some decisionmaking power
foreach x in a b c d e f {
	gen skip_`x'=((g2_02a_`x'==1) | (g2_02b_`x'==1) | (g2_02c_`x'==1) ) /*up to 3 decisionmakers mentioned */
	gen inputdec_`x'=(g2_03_`x'>2) if partact_`x'==1
	replace inputdec_`x'=1 if skip_`x'==1 & partact_`x'==1
	replace inputdec_`x'=. if g2_03_`x'==. & partact_`x'==0
	replace inputdec_`x'=. if g2_02a_`x'==. & g2_02b_`x'==. & g2_02c_`x'==. & g2_03_`x'==. & partact_`x'==.
	}
drop skip*
	
label var inputdec_a "Has some input in decisions regarding food crop farming"
label var inputdec_b "Has some input in decisions regarding cash crop farming"
label var inputdec_c "Has some input in decisions regarding livestock raising"
label var inputdec_d "Has some input in decisions regarding non-farm activity"
label var inputdec_e "Has some input in decisions regarding wage & salary employment"
label var inputdec_f "Has some input in decisions regarding fishing"

foreach x in a b c d e f {
	gen incomedec_`x'=(g2_05_`x'>2) if partact_`x'==1
	replace incomedec_`x'=. if g2_05_`x'==. & partact_`x'==1
	}

label var incomedec_a "Has some input in decisions regarding income from food crop farming"
label var incomedec_b "Has some input in decisions regarding income from cash crop farming"
label var incomedec_c "Has some input in decisions regarding income from livestock raising"
label var incomedec_d "Has some input in decisions regarding income from non-farm activity"
label var incomedec_e "Has some input in decisions regarding income from wage & salary employment"
label var incomedec_f "Has some input in decisions regarding income from fishing"

***g2.02, g2.04***

foreach x in a b c d e f g h {
	gen skip_`x'=((g2_02a_`x'==1) | (g2_02b_`x'==1) | (g2_02c_`x'==1)) /*up to 3 decisionmakers mentioned */ 
	*Adequate if feel can make decisions to a medium extent (g2_04) 
	*or actually makes decision	(g2_02)
	gen feelmakedec_`x'=(g2_04_`x'>2)
	replace feelmakedec_`x'=1 if skip_`x'==1
	replace feelmakedec_`x'=. if skip_`x'!=1 & g2_04_`x'==.
	replace feelmakedec_`x'=. if g2_02a_`x'==. & g2_02b_`x'==. & g2_02c_`x'==. & g2_04_`x'==.
	}
drop skip*	

label var feelmakedec_a "Feels can make decisions regarding food crop farming"
label var feelmakedec_b "Feels can make decisions regarding cash crop farming"
label var feelmakedec_c "Feels can make decisions regarding livestock raising"
label var feelmakedec_d "Feels can make decisions regarding nonfarm economic activities"
label var feelmakedec_e "Feels can make decisions regarding own wage or salary employment"
label var feelmakedec_f "Feels can make decisions regarding fishing"
label var feelmakedec_g "Feels can make decisions regarding major household expenditures"
label var feelmakedec_h "Feels can make decisions regarding minor household expenditures"


*AGGREGATION
*INPUT IN PRODUCTIVE DECISIONS: adequate if there is AT LEAST TWO domains in which individual has some input in decisions, 
*or makes the decision, or feels he/she could make it if he/she wanted
egen feelinputdecagr_sum=rowtotal(feelmakedec_a feelmakedec_b feelmakedec_c feelmakedec_f inputdec_a inputdec_b inputdec_c inputdec_f), missing 
gen feelinputdecagr=(feelinputdecagr_sum>1)
replace feelinputdecagr=. if feelinputdecagr_sum==.
label var feelinputdecagr_sum "No. agr. domains individual has some input in decisions or feels can make decisions"
label var feelinputdecagr "Has some input in decisions or feels can make decisions in AT LEAST TWO domains"

*CONTROL OVER USE OF INCOME: adequate if there is AT LEAST ONE domain in which individual has some input in income decisions or feels she/he can make decisions regarding wage, employment and minor hh 
*expenditures; as long the only domain in which the individual feels that he/she makes decisions IS NOT minor household expenditures
egen incomedec_sum=rowtotal(incomedec_a incomedec_b incomedec_c incomedec_d incomedec_e incomedec_f feelmakedec_d feelmakedec_e feelmakedec_g feelmakedec_h), missing
gen incdec_count=(incomedec_sum>0)
replace incdec_count=0 if incdec_count==1 & incomedec_sum==1 & feelmakedec_h==1
replace incdec_count=. if incomedec_sum==.
label var incomedec_sum "No. domains individual has some input in income decisions or feels can make decisions"
label var incdec_count "Has some input in income dec or feels can make dec AND not only minor hh expend"

*drop partact_* inputdec_1-incomedec_6 feelmakedec_a-feelmakedec_m	

***g4A, g4B, g4C***

qui recode g4* (98=.)

label define motivationind_lab 1 "Never true" 2 "Not very true" 3 "Somewhat true" 4 "Always true"

foreach x in a1 a2 a3 a4 {
	foreach v in g4a g4b g4c {
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
	gen rai_`x' = -2*v_g4`x'_a2 - v_g4`x'_a3 + 3*v_g4`x'_a4
	gen raiabove_`x'=( rai_`x'>1)
	replace raiabove_`x'=. if rai_`x'==.
	}
	

label var raiabove_a "RAI above 1 regarding types of crops to grow for consumption and sale at market"
label var raiabove_b "RAI above 1 regarding taking crops to the market"
label var raiabove_c "RAI above 1 regarding livestock raising"


*AGGREGATION 

** AUTONOMY IN PRODUCTION: adequate if RAI>1 in AT LEAST ONE domain/activity linked to production
egen raiprod_any=rowmax(raiabove_a raiabove_b raiabove_c)
replace raiprod_any=1 if raiprod_any==. & partactagr==0
label var raiprod_any "Has RAI above one in at least on production activity"



***********************************
*** Resources Domain: Module G3 ***
***********************************

qui recode g3a_0* g3b_0* (98=.)

***g3.01***

foreach x in a b c d e f g h i j k l m n {
	gen own_`x'=(g3a_01_`x'==1)
	replace own_`x'=. if g3a_01_`x'==. 
	}
label var own_a "Household owns agricultural land"
label var own_b "Household owns large livestock"
label var own_c "Household owns small livestock"
label var own_d "Household owns chickens, ducks, turkeys, pigeons"
label var own_e "Household owns agricultural fish pond or fishing equipment"
label var own_f "Household owns farm equipment (non-mechanized)"
label var own_g "Household owns farm equipment (mechanized)"
label var own_h "Household owns non-farm business equipment"
label var own_i "Household owns house (or other structures)"
label var own_j "Household owns large consumer durables (fridge, TV)"
label var own_k "Household owns small consumer durables (radio, cookware)"
label var own_l "Household owns cell phone"
label var own_m "Household owns non-agricultural land"
label var own_n "Household owns means of transportation"


*Aggregation
*Sum types of assets hh owns
egen own_sum=rowtotal(own_a-own_n), missing
egen ownagr_sum=rowtotal(own_a-own_g), missing

label var own_sum "No. of types of assets household owns"
label var ownagr_sum "No. of types of agricultural assets household owns"


***g3.02 - g3.04***
foreach x in a b c d e f g h i j k l m n{
	*Self or joint own ANY
	gen selfjointown_`x'=(g3a_02_`x'<3) if own_`x'==1
	replace selfjointown_`x'=. if g3a_02_`x'==. & own_`x'==1
	
	*Self or joint decide to sell, give away, mortgage or rent
	gen selfjointsell_`x'=(g3a_03a_`x'==1 | g3a_03b_`x'==1 | g3a_03c_`x'==1) if own_`x'==1
	replace selfjointsell_`x'=. if g3a_03a_`x'==. & g3a_03b_`x'==. & g3a_03c_`x'==. & own_`x'==1
	
	*Self or joint buy
	gen selfjointbuy_`x'=(g3a_04a_`x'==1 | g3a_04b_`x'==1 | g3a_04c_`x'==1) if own_`x'==1
	replace selfjointbuy_`x'=. if g3a_04a_`x'==. & g3a_04b_`x'==. & g3a_04c_`x'==.  & own_`x'==1


	*Rights
	**Makes AT LEAST ONE type of decision
	egen selfjointrightany_`x'=rowmax(selfjointsell_`x' selfjointbuy_`x')
	replace selfjointrightany_`x'=. if own_`x'==.
	}
	
**Labels
foreach x in own{
	label var selfjoint`x'_a "Jointly `x's any of agricultural land"
	label var selfjoint`x'_b "Jointly `x's any of large livestock"
	label var selfjoint`x'_c "Jointly `x's any of small livestock"
	label var selfjoint`x'_d "Jointly `x's any of chickens, turkeys, ducks"
	label var selfjoint`x'_e "Jointly `x's any of fish pond or fishing equipment"
	label var selfjoint`x'_f "Jointly `x's any of farm equipment (non-mechanized)"
	label var selfjoint`x'_g "Jointly `x's any of farm equipment (mechanized)"
	label var selfjoint`x'_h "Jointly `x's any of non-farm business equipment"
	label var selfjoint`x'_i "Jointly `x's any of the house (or other structures)"
	label var selfjoint`x'_j "Jointly `x's any of large consumer durables"
	label var selfjoint`x'_k "Jointly `x's any of small consumer durables"
	label var selfjoint`x'_l "Jointly `x's any of cell phone"
	label var selfjoint`x'_m "Jointly `x's any of non-agricultural land"
	label var selfjoint`x'_n "Jointly `x's any of means of transportation "
}
foreach x in sell buy{
	label var selfjoint`x'_a "Jointly can `x' agricultural land"
	label var selfjoint`x'_b "Jointly can `x' large livestock"
	label var selfjoint`x'_c "Jointly can `x' small livestock"
	label var selfjoint`x'_d "Jointly can `x' chickens, turkeys, ducks"
	label var selfjoint`x'_e "Jointly can `x' fish pond or fishing equipment"
	label var selfjoint`x'_f "Jointly can `x' farm equipment (non-mechanized)"
	label var selfjoint`x'_g "Jointly can `x' farm equipment (mechanized)"
	label var selfjoint`x'_h "Jointly can `x' non-farm business equipment"
	label var selfjoint`x'_i "Jointly can `x' the house (or other structures)"
	label var selfjoint`x'_j "Jointly can `x' large consumer durables"
	label var selfjoint`x'_k "Jointly can `x' small consumer durables"
	label var selfjoint`x'_l "Jointly can `x' cell phone"
	label var selfjoint`x'_m "Jointly can `x' non-agricultural land"
	label var selfjoint`x'_n "Jointly can `x' means of transportation "
}

label var selfjointrightany_a "Jointly has AT LEAST ONE right over agricultural land"
label var selfjointrightany_b "Jointly has AT LEAST ONE right over large livestock"
label var selfjointrightany_c "Jointly has AT LEAST ONE right over small livestock"
label var selfjointrightany_d "Jointly has AT LEAST ONE right over chickens, turkeys, ducks"
label var selfjointrightany_e "Jointly has AT LEAST ONE right over fishing equipment"
label var selfjointrightany_f "Jointly has AT LEAST ONE right over farm equipment (non-mechanized)"
label var selfjointrightany_g "Jointly has AT LEAST ONE right over farm equipment (mechanized)"
label var selfjointrightany_h "Jointly has AT LEAST ONE right over non-farm business equipment"
label var selfjointrightany_i "Jointly has AT LEAST ONE right over house (or other structures)"
label var selfjointrightany_j "Jointly has AT LEAST ONE right over large consumer durables"
label var selfjointrightany_k "Jointly has AT LEAST ONE right over small consumer durables"
label var selfjointrightany_l "Jointly has AT LEAST ONE right over cell phone"
label var selfjointrightany_m "Jointly has AT LEAST ONE right over non agricultural land"
label var selfjointrightany_n "Jointly as AT LEAST ONE right over means of transportation"

*AGGREGATION
*OWNERSHIP: Adequate if selfjoint owns AT LEAST two small assets (chicken,  farming equipment non-mechanized, and small consumer durables)  OR one large asset (all the other). 
	* This is the same to say: empowered if owns AT LEAST one asset and that asset is not a small asset.
	* Inadequate if lives in a household that owns no assets
foreach x in own {
	egen selfjoint`x'sum=rowtotal(selfjoint`x'_*), missing
	egen j`x'count=rowmax(selfjoint`x'_*)
	replace j`x'count=0 if j`x'count==1 & selfjoint`x'sum==1 &(selfjointown_d==1|selfjointown_f==1|selfjointown_k==1)
	replace j`x'count=0 if own_sum==0

	rename j`x'count j`x'_count
	rename selfjoint`x'sum selfjoint`x'_sum
	
	}

*PURCHASE, SALE OR TRANSFER OF ASSETS: Adequate if selfjoint has AT LEAST ONE type of right
*over AT LEAST ONE type of asset as long as it is not chicken nor farming equipment non-mechanized.
*Inadequate if living in households with no assets are automatically adequate
		
foreach x in rightany {
	*Agricultural assets
	egen selfjoint`x'agrsum=rowtotal(selfjoint`x'_a selfjoint`x'_b selfjoint`x'_c selfjoint`x'_d selfjoint`x'_e selfjoint`x'_f selfjoint`x'_g), missing
	egen selfjoint`x'agrcount=rowmax(selfjoint`x'_a selfjoint`x'_b selfjoint`x'_c selfjoint`x'_d selfjoint`x'_e selfjoint`x'_f selfjoint`x'_g)
	replace selfjoint`x'agrcount=0 if selfjoint`x'agrcount==1 & selfjoint`x'agrsum==1 & (selfjoint`x'_d==1|selfjoint`x'_f==1)
	replace selfjoint`x'agrcount=0 if ownagr_sum==0
		
	rename selfjoint`x'agrsum selfjoint`x'agr_sum
	rename selfjoint`x'agrcount j`x'agr
	
	}

label var jrightanyagr "Jointly has AT LEAST ONE right in AT LEAST ONE agricultural asset the hh owns"


***g3.06***
foreach x in a b c d e f {
	gen creditaccess_`x'=(g3b_06_`x'>=1 & g3b_06_`x'<=3)
	replace creditaccess_`x'=. if g3b_06_`x'==. | g3b_06_`x'==97
	gen creditconstrained_`x'=(g3b_05_`x'==2)
	replace creditconstrained_`x'=. if g3b_05_`x'==.
	label var creditconstrained_`x' "Unable to borrow from source `x'"
	}
egen creditaccess=rowtotal(creditaccess_*), missing
label var creditaccess "No. of credit sources that the hh uses”
egen creditconstrained=rowtotal(creditconstrained_*), missing
label var creditconstrained "No. of credit sources that the hh cannot borrow from"


***g3.07, g3.08***
foreach y in a b c d e f {
	*Self or joint decide to borrow
	gen creditselfjointborrow_`y'=(g3b_07a_`y'==1 | g3b_07b_`y'==1 | g3b_07c_`y'==1) if creditaccess_`y'==1
	replace creditselfjointborrow_`y'=. if g3b_07a_`y'==. & g3b_07b_`y'==. & g3b_07c_`y'==. & creditaccess_`y'==1
	
	*Self or joint decide how to use
	gen creditselfjointuse_`y'=(g3b_08a_`y'==1 | g3b_08b_`y'==1 | g3b_08c_`y'==1) if creditaccess_`y'==1
	replace creditselfjointuse_`y'=. if g3b_08a_`y'==. & g3b_08b_`y'==. & g3b_08c_`y'==. & creditaccess_`y'==1
	
	*Self or joint makes AT LEAST ONE decision regarding credit
	egen creditselfjointanydec_`y'=rowmax(creditselfjointborrow_`y' creditselfjointuse_`y')

	}

foreach x in borrow use {
	label var creditselfjoint`x'_a "Jointly made decision about `x' credit from NGO"
	label var creditselfjoint`x'_b " Jointly made decision about `x' credit from formal lender"
	label var creditselfjoint`x'_c " Jointly made decision about `x' credit from informal lender"
	label var creditselfjoint`x'_d " Jointly made decision about `x' credit from friends & relatives"
	label var creditselfjoint`x'_e " Jointly made decision about `x' credit from group-based MFI"
	label var creditselfjoint`x'_f " Jointly made decision about `x' credit from informal group-based"
	}

label var creditselfjointanydec_a "Jointly made AT LEAST ONE decision regarding credit from NGO"
label var creditselfjointanydec_b "Jointly made AT LEAST ONE decision regarding credit from formal lender"
label var creditselfjointanydec_c "Jointly made AT LEAST ONE decision regarding credit from informal lender"
label var creditselfjointanydec_d "Jointly made AT LEAST ONE decision regarding credit from friends & relatives"
label var creditselfjointanydec_e "Jointly made AT LEAST ONE decision regarding credit from group-based MFI"
label var creditselfjointanydec_f "Jointly made AT LEAST ONE decision regarding credit from informal group-based"

*AGGREGATION
*ACCESS TO AND DECISIONS ON CREDIT: Adequate if self/selfjoint makes dec regarding AT LEAST ONE source of credit AND has at least one source of credit
foreach x in anydec {
	egen creditselfjoint`x'any=rowmax(creditselfjoint`x'_*)
	replace creditselfjoint`x'any=0 if creditaccess==0 
	rename creditselfjoint`x'any credj`x'_any 
	}

label var credjanydec_any "Jointly makes AT LEAST ONE decision regarding AT LEAST ONE source of credit"



***********************************
***Leadership Domain: Module G6 ***
***********************************

qui recode g6* (97 98=.)


***g6a.01, g6a.02***
*empowered if comfortable speaking in public OR have spoke up in public in last 3 months
gen speakpublic_1=(g6a_01==2 | g6a_01==3)
replace speakpublic_1=. if g6a_01==. 

gen speakpublic_2=(g6a_02==1)
replace speakpublic_2=. if g6a_02==.
	
	
*AGGREGATION
*SPEAK IN PUBLIC: Adequate if comfortable speaking in public OR have spoken up in public in last 3 months
egen speakpublic_any=rowmax(speakpublic_1 speakpublic_2)


***g6.03, g6.04***
foreach x in a b c d e f g h i j {
	*Active group member 
	gen groupmember_`x'=(g6b_04_`x'==1)
	replace groupmember_`x'=. if g6b_04_`x'==.
	gen nogroup_`x'=(g6b_03_`x'==2 | g6b_03_`x'==.)
	}

*AGGREGATION
*GROUP MEMBERSHIP: Adequate if individual is part of AT LEAST ONE group
egen groupmember_any=rowmax(groupmember_*)
replace groupmember_any=0 if groupmember_any==. /*Inadequate if no groups in community*/


******************************
*** Time Domain: Module G5 ***
******************************

***g5.04***
*LEISURE TIME: Adequate if does not express any level of dissatisfaction with the amount of leisure time available
gen leisuretime=(g5_04>4)
replace leisuretime=. if g5_04==.

rename g1_02 mid
rename g1_03 sex
save "modifieddata\all_indicators_2.0.dta", replace


***g5.01***

**********************************************
** 24 HOUR RECALL - PRIMARY ACTIVITES ONLY ***
** Create time poverty measure ***************
**********************************************

// Open dataset with time use information //

use "clean data\ind_time_public_release_2.0.dta", clear
renvars, subst(_p2) // harmonize varnames across pilot types
rename g1_02 mid
rename g1_03 sex


*Define work (w/ commuting/travelling) 
qui gen w=(act=="E" | act=="F" | act=="G" | act=="J" | act=="K" | ///
		   act=="L" | act=="M" | act=="N" | act=="P")
drop if w==0

*Calculate total time spent working as primary and secondary activity
collapse (sum) time24_1 (mean) sex, by(country hhid mid) 
gen work=time24_1 



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
	foreach y in 1 2 {
		*Headcount
		qui sum poor_`x' if country==`y'
		local q=r(sum)
		qui sum work if country==`y'
		local n=r(N)
		qui replace H_`x'=`q'/`n' if country==`y'
		foreach z in 1 2{
			*Headcount
			qui sum poor_`x' if country==`y' & sex==`z'
			local q=r(sum)
			qui sum work if country==`y' & sex==`z'
			qui replace H_`x'_`z'=`q'/r(N) if country==`y'
			}
		}
	}


	
foreach y in 1 2 {
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

save "modifieddata\time measure_2.0_24hr.dta", replace 


// Merge time poverty measure with all indicators dataset //

use "modifieddata\all_indicators_2.0.dta", clear

merge 1:1 country hhid mid using "modifieddata\time measure_2.0_24hr.dta", keepusing(work poor_z10 poor_z105 poor_z75 poor_z11)

foreach x in 10 105 75 11 {
	gen npoor_z`x'=1-poor_z`x'
	}

drop _merge 
save "modifieddata\all_indicators_2.0_24hr.dta", replace 


log close

