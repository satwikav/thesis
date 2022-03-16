
/////////FEMALE WEAI MODS
//mod 1
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/126_bihs_r3_female_weai_ind_mod_wa.dta", clear
keep a01 wa04 wa05 wa06 
rename wa04 mid
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
//mod 2
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/127_bihs_r3_female_weai_ind_mod_we2.dta", clear
drop hhid2 hh_type round
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta"
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
//mod 3a
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/128_bihs_r3_female_weai_ind_mod_we3a.dta",clear
encode we3a, gen (asset)
rename we3a01a haveasset
rename we3a01b numberofasset
rename we3a02a owner_a
rename  we3a02b owner_b
rename  we3a02c owner_c
rename  we3a03a sell_decision_a
rename  we3a03b sell_decision_b
rename  we3a03c sell_decision_c
rename  we3a04a distribution_decision_a
rename  we3a04b distribution_decision_b
rename  we3a04c distribution_decision_c
rename  we3a05a rent_decision_a
rename  we3a05b rent_decision_b
rename  we3a05c rent_decision_c
rename  we3a06a purchase_decision_a
rename  we3a06b purchase_decision_b
rename  we3a06c purchase_decision_c
keep haveasset numberofasset owner_a owner_b owner_c sell_decision_a sell_decision_b sell_decision_c distribution_decision_a distribution_decision_b distribution_decision_c rent_decision_a rent_decision_b rent_decision_c purchase_decision_a purchase_decision_b purchase_decision_c a01 asset
reshape wide haveasset numberofasset owner_a owner_b owner_c sell_decision_a sell_decision_b sell_decision_c distribution_decision_a distribution_decision_b distribution_decision_c rent_decision_a rent_decision_b rent_decision_c purchase_decision_a purchase_decision_b purchase_decision_c, i (a01) j (asset)
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta"
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
//mod 3b
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/129_bihs_r3_female_weai_ind_mod_we3b.dta"
drop hhid2 hh_type round
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta"
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
//mod 3c
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/130_bihs_r3_female_weai_ind_mod_we3c.dta"
drop hhid2 hh_type round
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta"
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
//mod 3d
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/131_bihs_r3_female_weai_ind_mod_we3d.dta"
drop hhid2 hh_type round
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta"
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
//mod 4
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/132_bihs_r3_female_weai_ind_mod_we4.dta"
drop hhid2 hh_type round
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta"
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
//mod 5a
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/133_bihs_r3_female_weai_ind_mod_we5a.dta"
drop hhid2 hh_type round
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta"
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
//mod 5b
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/134_bihs_r3_female_weai_ind_mod_we5b.dta", clear
drop hhid2 hh_type round
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta"
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
//mod 5c
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/135_bihs_r3_female_weai_ind_mod_we5c.dta",clear
drop hhid2 hh_type round
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta"
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
//mod 6b
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/137_bihs_r3_female_weai_ind_mod_we6b.dta", clear
drop hhid2 hh_type round
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta"
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
//mod 7c
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/139_bihs_r3_female_weai_ind_mod_we7c.dta",clear
drop etime_h_weai etime_m_weai hhid2 hh_type round
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta"
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
//Female mod 6a
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/136_bihs_r3_female_weai_ind_mod_we6a.dta", clear
drop if wps==2
collapse (sum) we6_0400-we6_0345 , by(a01)
foreach x of var  we6_0400-we6_0345 {
	rename `x' sum1_`x'
}
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d_1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/136_bihs_r3_female_weai_ind_mod_we6a.dta", clear
drop if wps==1
collapse (sum) we6_0400-we6_0345 , by(a01)
foreach x of var  we6_0400-we6_0345 {
	rename `x' sum2_`x'
}
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d_2.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/136_bihs_r3_female_weai_ind_mod_we6a.dta", clear
merge m:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d_1.dta"
drop _merge
merge m:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d_2.dta"
drop _merge
foreach x of var we6_0400-we6_0345 {
	qui replace `x'=0 if `x'==.
}	
*Primary activities
gen we6a01_1=0
foreach x of var we6_0400-we6_0345 {
	qui bys a01 wacode: replace we6a01_1=we6a01_1+1 if (`x'==1 & wps==1) ///
	| (`x'==1 & wps==2 & sum1_`x'==0) 
}
gen adjust2=0	
foreach x of var we6_0400-we6_0345 {
	qui bys a01 wacode: replace adjust2=adjust2+1 if `x'==1 & wps==2 ///
	& sum1_`x'==0 & sum2_`x'==2
}	
gen pri_adjust1=adjust2/2
gen adjust3=0	
foreach x of var we6_0400-we6_0345 {
	qui bys a01 wacode: replace adjust3=adjust3+1 if `x'==1 & wps==2 ///
	& sum1_`x'==0 & sum2_`x'==3
}	
gen pri_adjust2=adjust3*2/3
replace we6a01_1=(we6a01_1-pri_adjust1-pri_adjust2)*15
*Secondary activities
gen we6a01_2=0
foreach x of var we6_0400-we6_0345 {
	qui bys a01 wacode: replace we6a01_2=we6a01_2+1 if `x'==1 & wps==2 ///
	& sum1_`x'==1
}
gen sec_adjust1=adjust2/2	
gen sec_adjust2=adjust3/3
qui replace we6a01_2=(we6a01_2+sec_adjust1+sec_adjust2)*15
drop adjust* pri_* sec_*
label variable we6a01_1 "Minutes spent in [ACTIVITY] (as primary)"
label variable we6a01_2 "Minutes spent in [ACTIVITY] (as secondary)"
drop wps-we6_0345 sum*
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5dd.dta",replace

*********************Dimension 1 Indicator 1: Input in productive decisions*********************
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta", clear
//Renaming vars due to addition of more choices in 2018 questionnaire 
rename we2_01_31 we2_01_3
rename we2_02_31 we2_02_3
rename we2_03_31 we2_03_3
rename we2_01_32 we2_01_7
rename we2_02_32 we2_02_7
rename we2_03_32 we2_03_7
rename we2_01_33 we2_01_8
rename we2_02_33 we2_02_8
rename we2_03_33 we2_03_8
//Recode options which are not applicable to . 
qui recode we2_02_* we2_03_* (5 7 = .) 
//Number of activites participated in 
foreach x of num 1/8 {
	gen partact_`x'=(we2_01_`x'==1)
	replace partact_`x'=. if we2_01_`x'==.
} 	
egen partact=rowtotal(partact_*), missing
label var partact "Number of activities in which individual participates" 
egen partactagr=rowtotal(partact_1 partact_2 partact_3 partact_7 partact_8 partact_6), missing
label var partactagr "Number of agricultural activities in which individual participates" 
*Adequate if respondent has at least some decisionmaking power (code 1: 3 or 4)
foreach x of num 1/8{
	gen inputdec_`x'=(we2_02_`x'>2) if partact_`x'==1
	replace inputdec_`x'=. if we2_02_`x'==. & partact_`x'==1
	}
label var inputdec_1 "Has some input in decisions regarding food crop farming" 
label var inputdec_2 "Has some input in decisions regarding cash crop farming"
label var inputdec_3 "Has some input in decisions regarding large livestock raising"
label var inputdec_4 "Has some input in decisions regarding non-farm activity"
label var inputdec_5 "Has some input in decisions regarding wage & salary employment"
label var inputdec_6 "Has some input in decisions regarding fishing"
label var inputdec_7 "Has some input in decisions regarding small livestock raising"
label var inputdec_8 "Has some input in decisions regarding poultry"
qui recode we5a_01a* we5a_01b* we5a_01c* we5a_02* (98=.)
*Adequate if respondent has at least some decisionmaking power (code: 3 or 4)
foreach x in a b c d e f g{
	gen skip_`x'=((we5a_01a_`x'==1)| (we5a_01b_`x'==1)| (we5a_01c_`x'==1))
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
/*AGGREGATION
INPUT IN PRODUCTIVE DECISIONS: adequate if there is AT LEAST TWO domains in which individual has some input in decisions, or makes the decision, or feels he/she could make it if he/she wanted*/
egen feelinputdecagr_sum=rowtotal(feelmakedec_a-feelmakedec_d inputdec_1 inputdec_2 inputdec_3 inputdec_6 inputdec_7 inputdec_8), missing 
gen feelinputdecagr=(feelinputdecagr_sum>1)
replace feelinputdecagr=. if feelinputdecagr_sum==.
label var feelinputdecagr_sum "No. agr. domains individual has some input in decisions or feels can make decisions" 
label var feelinputdecagr "Has some input in decisions or feels can make decisions in AT LEAST TWO domains" 
*********************Dimension 1 Indicator 2: Autonomy in productive decisions*********************
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
/*AGGREGATION 
AUTONOMY IN PRODUCTION: adequate if RAI>1 in AT LEAST ONE domain/activity linked to production*/
egen raiprod_any=rowmax(raiabove_a raiabove_b raiabove_c)
replace raiprod_any=1 if raiprod_any == . & partactagr == 0
label var raiprod_any "Has RAI above one in at least one production activity"
*********************Dimension 2 Indicator 3: Asset ownership*********************
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
/*AGGREGATION
OWNERSHIP: Adequate if selfjoint owns AT LEAST two small assets (chicken,  farming equipment non-mechanized, and small consumer durables)  OR one large asset (all the other). This is the same to say: empowered if owns AT LEAST one assets and that asset is not a small asset. Inadequate if lives in a household that owns no assets*/
foreach x in own{
	egen selfjoint`x'sum=rowtotal(selfjoint`x'_*), missing
	egen j`x'count=rowmax(selfjoint`x'_*)
	replace j`x'count=0 if j`x'count==1 & selfjoint`x'sum==1 &(selfjointown_4==1|selfjointown_6==1|selfjointown_11==1)
	replace j`x'count=0 if own_sum==0
	rename j`x'count j`x'_count
	rename selfjoint`x'sum selfjoint`x'_sum	
}
*********************Dimension 2 Indicator 4: Rights over assets*********************
/*PURCHASE, SALE OR TRANSFER OF ASSETS: Adequate if selfjoint has AT LEAST ONE type of right over AT LEAST ONE type of asset as long as it is not chicken nor farming equipment non-mechanized.Inadequate if living in households with no assets are automatically adequate*/
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
*********************Dimension 2 Indicator 5: Access to and decisions over credit*********************
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
/*AGGREGATION
ACCESS TO AND DECISIONS ON CREDIT: Adequate if self/selfjoint makes dec regarding AT LEAST ONE source of credit AND has at least one source of credit*/
foreach x in anydec {
	egen creditselfjoint`x'any=rowmax(creditselfjoint`x'_*)
	replace creditselfjoint`x'any=0 if creditaccess==0
	rename creditselfjoint`x'any credj`x'_any 
}
label var credjanydec_any "Jointly makes AT LEAST ONE decision regarding AT LEAST ONE source of credit"
*********************Dimension 3 Indicator 6: control over use of income*********************
foreach x of num 1/8{
	gen incomedec_`x'=(we2_03_`x'>2) if partact_`x'==1
	replace incomedec_`x'=. if we2_03_`x'==. & partact_`x'==1
	}
label var incomedec_1 "Has some input in decisions regarding income from food crop farming" 
label var incomedec_2 "Has some input in decisions regarding income from cash crop farming"
label var incomedec_3 "Has some input in decisions regarding income from large livestock raising"
label var incomedec_4 "Has some input in decisions regarding income from non-farm activity"
label var incomedec_5 "Has some input in decisions regarding income from wage & salary employment"
label var incomedec_6 "Has some input in decisions regarding income from fishing"
label var incomedec_7 "Has some input in decisions regarding income from small livestock raisinging"
label var incomedec_8 "Has some input in decisions regarding income from poultry"
/*CONTROL OVER USE OF INCOME: adequate if there is AT LEAST ONE domain in which individual has some input in income decisions or feels she/he can make decisions regarding wage, employment and minor hh expenditures; as long the only domain in which the individual feels that he/she makes decisions IS NOT minor household expenditures*/
egen incomedec_sum=rowtotal(incomedec_1 incomedec_2 incomedec_3 incomedec_4 incomedec_5 incomedec_6 incomedec_7 incomedec_8 feelmakedec_e feelmakedec_f feelmakedec_g), missing
gen incdec_count=(incomedec_sum>0)
replace incdec_count=0 if incdec_count==1 & incomedec_sum==1 & feelmakedec_g==1
replace incdec_count=. if incomedec_sum==.
label var incomedec_sum "No. domains individual has some input in income decisions or feels can make decisions"
label var incdec_count "Has some input in income dec or feels can make dec AND not only minor hh expend"
*********************Dimension 4 Indicator 7: group membership*********************
qui recode we4_08* (.=0)
foreach x in a b c d e f g h i j k {
	gen groupmember_`x'=(we4_08`x'==1)
	replace groupmember_`x'=. if we4_08`x'==.
}
/*AGGREGATION
GROUP MEMBERSHIP: Adequate if individual is part of AT LEAST ONE group*/
egen groupmember_any=rowmax(groupmember_*)
*********************Dimension 4 Indicator 8: speaking in public*********************
qui recode we4* (98=.)
foreach x in 1 2 3{
gen speakpublic_`x'=(we4_0`x'>1)
replace speakpublic_`x'=. if we4_0`x'==.
}
/*AGGREGATION
SPEAK IN PUBLIC: Adequate if comfortable speaking in public in AT LEAST ONE context*/
egen speakpublic_any=rowmax(speakpublic_1 speakpublic_2 speakpublic_3)
*********************Dimension 5 Indicator 9: leisure*********************
*LEISURE TIME: Adequate if does not express any level of dissatisfaction with the amount of leisure time available
gen leisuretime=(we6b_04_b>4)
replace leisuretime=. if we6b_04_b==. 
keep a01 mid wa05 wa06 feelinputdecagr raiprod_any jown_count jrightanyagr credjanydec_any incdec_count groupmember_any speakpublic_any leisuretime 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
*********************Dimension 5 Indicator 10: workload*********************
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5dd.dta", clear
*Define work (w/ commuting/travelling) 
qui gen w=(wacode>=5 & wacode<=13)
drop if w==0
*Calculate total time spent working as primary and secondary activity
collapse (sum) we6a01_1 we6a01_2 , by(a01)
gen work=we6a01_1 + (.5*we6a01_2)
***Define poverty lines
*10.5 hr/day
gen z105=10.5*60
gen poor_z105 = work > z105
gen npoor_z105 = 1-poor_z105
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/time_measure_1.dta",replace
//Merge time poverty measure with all indicators dataset
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta", clear
sort a01 
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/time_measure_1.dta",
keep a01 mid wa05 wa06 feelinputdecagr raiprod_any jown_count jrightanyagr credjanydec_any incdec_count groupmember_any speakpublic_any npoor_z105 leisuretime 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",replace
*/
**************************************************
*******   FIVE DOMAINS EMPOWERMENT (5DE)   *******
**************************************************
// So far all_indicators were defined so 1 identifies adequate.
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/f_5d.dta",clear
*****************************************************************************
********  Create a local variable with all your indicators varlist_emp ******
*****************************************************************************
#delimit;
local varlist_5do feelinputdecagr raiprod_any jown_count jrightanyagr credjanydec_any incdec_count groupmember_any speakpublic_any npoor_z105 leisuretime;

gen sample5do=(feelinputdecagr~=. & raiprod_any~=. & jown_count~=. & jrightanyagr~=.& credjanydec_any~=. & incdec_count~=. & groupmember_any~=. & speakpublic_any~=. & npoor_z105~=. & leisuretime~=.);
#delimit cr
******************************
**** Define the weights.  ****
******************************
foreach var in feelinputdecagr raiprod_any{
	gen w_`var'=1/10
	}
foreach var in jown_count jrightanyagr credjanydec_any {
	gen w_`var'=1/15
	}
foreach var in incdec_count {
	gen w_`var'=1/5
	}
foreach var in groupmember_any speakpublic_any {
	gen w_`var'=1/10
	}
foreach var in npoor_z105 leisuretime{
	gen w_`var'=1/10
	}
**********************************************************
*********     Define the weigted adequacy score      ****
**********************************************************
foreach var in `varlist_5do'{
	gen wg0_`var'= `var' * w_`var'
	}

egen ci=rsum(wg0_*)
label variable ci "Empowerment score"

egen n_missing=rowmiss(wg0_*)
label variable n_missing "Number of missing variables by individual"
gen missing=(n_missing>0)
label variable missing "Individual with missing variables"


*** Check sample drop due to missing values
tab n_missing
//keep if wa06 == 1

replace ci = . if n_missing == 9
//replace ci = . if missing
//drop if missing
//keep if wa06 == 1
keep a01 mid wa05 wa06 feelinputdecagr raiprod_any jown_count jrightanyagr credjanydec_any incdec_count groupmember_any speakpublic_any leisuretime npoor_z105 ci
save "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta",replace
/*
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/5d_score.dta", clear
drop if wa05 == 1
rename ci ci_old
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/empw_score.dta"
drop if _m == 1
assert ci == ci_old
*/



//Pie chart showing contribution of each indicator 
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta",clear
label var feelinputdecagr "Input in productive decisions"
label var raiprod_any "Autonomy in production"
label var jown_count "Ownership of assets"
label var jrightanyagr "Purchase/sale/transter of assets"
label var credjanydec_any "Access to and decisions on credit"
label var incdec_count "Control over use of income"
label var groupmember_any "Group member"
label var speakpublic_any "Speaking in public"
label var leisuretime "Leisure"
label var npoor_z105 "Workload"
graph pie feelinputdecagr raiprod_any jown_count jrightanyagr credjanydec_any incdec_count groupmember_any speakpublic_any leisuretime npoor_z105, sort descending ///
pie(1,color("55 70 90")) pie(2,color("117 71 71")) ///
pie(3,color("98 113 78")) pie(4,color("149 145 179")) ///
pie(5,color("198 193 159")) pie(6,color("76 104 100")) ///
pie(7,color("149 136 105")) pie(8,color("180 164 162")) ///
pie(9,color("242 211 132")) pie(10,color("222 229 231"))  ///
plabel(_all percent, color(white) size(small) format(%4.0g) gap(5)) /// 
legend(color(black) region(lcolor(white)) size(small)) ///
graphregion(fcolor(white))



