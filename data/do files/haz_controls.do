****************************************
//BASELINE DATASET FOR ANTHROPOMETRY 
****************************************
/*haz,whz,waz
- retain child z score, age,mother id
- calculate child's age square
- drop if child < 5 years is absent in hh*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/100_bihs_r3_female_mod_w2.dta", clear
keep a01 mid_w2 w2_14 haz06 waz06 w2_01 w2_01a
rename w2_01 mid_mother
rename w2_01a mid_father
rename w2_14 age_child
gen age_2_child = age_child ^ 2
drop if mid_w2 == 99
rename mid_w2 mid_child
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta", replace
/*gender of child
- get child gender from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_01
rename mid mid_child
merge 1:1 a01 mid_child using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m
gen girl_child = 1 if b1_01 == 2
replace girl_child = 0 if b1_01 == 1
drop b1_01
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta", replace
/*Female empowerment scores
- retain score, type of hh*/
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta", clear
gen empw_female = ci
rename wa06 wa06_female
rename mid mid_female
keep a01 empw_female wa06_female mid_female
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta", replace
/*Male empowerment scores
- retain score, type of hh
- check if type of hh is same for each hh 
- create if hh is deal headed
- calculate empowerment gap between male and female*/
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/male_score.dta", clear
gen empw_male = ci
rename wa06 wa06_male
keep a01 empw_male wa06_male
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m
assert wa06_male == wa06_female
tab wa06_male
gen dual_headed = 1 if wa06_male == 1
replace dual_headed = 0 if wa06_male != 1
drop wa06_male wa06_female
gen gap = empw_male - empw_female
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta", replace
/*Mother's age
- get mother's age from hh info
- create if age square of mother*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_mother
rename b1_02 age_mother
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _merge
gen age_2_mother = age_mother ^ 2
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta", replace
/* Age of the father
- keep the age of members
- merge with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_father
rename b1_02 age_father
merge 1:m a01 mid_father using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _merge
gen age_diff = age_father - age_mother
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/*Mother's height
- get mother's height from hh anthropometry*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/099_bihs_r3_female_mod_w1.dta", clear
keep a01 mid_w1 w1_04
rename mid_w1 mid_mother
rename w1_04 height_mother
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta", replace
/*Mother's years of education
- get mother's highest education from hh info
- calculate years of education depending on the highest class passed*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_08
gen edu_mother = b1_08
replace edu_mother = 0 if b1_08 == 66
replace edu_mother = 0 if b1_08 == 99
replace edu_mother = 9 if b1_08 == 22
replace edu_mother = 11 if b1_08 == 33
replace edu_mother = 12 if b1_08 == 75
replace edu_mother = 15 if b1_08 == 14
replace edu_mother = 16 if b1_08 == 15
replace edu_mother = 16 if b1_08 == 72
replace edu_mother = 16 if b1_08 == 73
replace edu_mother = 16 if b1_08 == 74
replace edu_mother = 17 if b1_08 == 16
replace edu_mother = 17 if b1_08 == 71
replace edu_mother = . if b1_08 == 67
replace edu_mother = . if b1_08 == 76
rename mid mid_mother
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _merge b1_08
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/* No of years of education of the father 
- keep the highest education level of members
- calculate the years of education
- merge with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_08
gen edu_male = b1_08
replace edu_male = 0 if b1_08 == 66
replace edu_male = 0 if b1_08 == 99
replace edu_male = 9 if b1_08 == 22
replace edu_male = 11 if b1_08 == 33
replace edu_male = 12 if b1_08 == 75
replace edu_male = 15 if b1_08 == 14
replace edu_male = 16 if b1_08 == 15
replace edu_male = 16 if b1_08 == 72
replace edu_male = 16 if b1_08 == 73
replace edu_male = 16 if b1_08 == 74
replace edu_male = 17 if b1_08 == 16
replace edu_male = 17 if b1_08 == 71
replace edu_male = . if b1_08 == 67
replace edu_male = . if b1_08 == 76
rename mid mid_father
merge 1:m a01 mid_father using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _merge b1_08
gen edu_diff = edu_male - edu_mother
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/*Household's location
- get hh location and size from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 dvcode a23 community_id
rename a23 hh_size
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/*Household head information
- get hhh occupation,age,highest class passed from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep if b1_03 == 1
keep a01 b1_10 b1_02 b1_08 b1_03
rename b1_02 age_hhh
gen farmer_hhh = 0
replace farmer_hhh = 1 if b1_10 == 64 | b1_10 == 65 | b1_10 == 66 | b1_10 == 67| b1_10 == 68| b1_10 == 69| b1_10 == 70| b1_10 == 71| b1_10 == 72
gen trader_hhh = 0
replace trader_hhh = 1 if b1_10 == 50 | b1_10 == 51 | b1_10 == 52 | b1_10 == 53| b1_10 == 54
gen edu_hhh = b1_08
replace edu_hhh = 0 if b1_08 == 66
replace edu_hhh = 0 if b1_08 == 99
replace edu_hhh = 9 if b1_08 == 22
replace edu_hhh = 11 if b1_08 == 33
replace edu_hhh = 12 if b1_08 == 75
replace edu_hhh = 15 if b1_08 == 14
replace edu_hhh = 16 if b1_08 == 15
replace edu_hhh = 16 if b1_08 == 72
replace edu_hhh = 16 if b1_08 == 73
replace edu_hhh = 16 if b1_08 == 74
replace edu_hhh = 17 if b1_08 == 16
replace edu_hhh = 17 if b1_08 == 71
replace edu_hhh = . if b1_08 == 67
replace edu_hhh = . if b1_08 == 76
keep a01 age_hhh farmer_hhh edu_hhh trader_hhh
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/*Household dependency ratio
- get number of dependents (age less than 15 and greater than 64) in each household from from hh info
- divide the dependents by household size to the dependency ratio*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02
drop if b1_02 == .
gen dependents = 0
replace dependents = 1 if b1_02 < 15 | b1_02 > 64
collapse (sum) dep, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m
gen dep_ratio = dependents / hh_size
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/* cultivable land operated by the household
- keep the land type, operational status and area
- generating operated cultivable land area in acres
- collapse at household level
- generated log tranformed area of land */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/020_bihs_r3_male_mod_g.dta",clear
keep a01 plotid g01 g02
gen land=0
replace land=g02/100 
collapse (sum) land, by(a01) 
gen log_land = ln(land + 1)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/* total income of the household - step 1 
- keep the montly income earned by the members
- obtain the yearly income earned by the members 
- collapse at hh level*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/012_bihs_r3_male_mod_c.dta", clear
replace c14 = 0 if c14 == .
gen salary = c14 * 12
collapse (sum) salary, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/* total income of the household - step 2
- keep the yearly remittances received by the members
- collapse at hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/073_bihs_r3_male_mod_v2.dta", clear
replace v2_06 = 0 if v2_06 == .
collapse (sum) v2_06, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/* total income of the household - step 3
- keep the yearly other incomes received by the households
- sum them at the hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/076_bihs_r3_male_mod_v4.dta", clear
egen other = rowtotal(v4_01-v4_12)
keep a01 other
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m
egen total_income = rowtotal(other v2_06 salary)
drop other v2_06 salary
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/* income terciles
- calculate income terciles */
use "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",clear
xtile income_3 = total_income, nq(3)
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/* distance to local shops
- keep only if the facility is local shops
- merge the distance with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/066_bihs_r3_male_mod_s.dta", clear
keep if s_01 == 5
keep a01 s_04 
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m
rename s_04 dist_shop
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
//age when she has first child
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta", clear
keep b1_04b a01 mid 
rename b1_04b age_pregnant
rename mid mid_mother
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta", replace
//physical or verbal abuse in last 12 months
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/124_bihs_r3_female_mod_z4.dta", clear
keep a01 z4_01c1 z4_01d1 z4_mid 
rename z4_mid mid_mother
gen abuse = 0
replace abuse = 1 if z4_01c1 == 1 | z4_01c1 == 2 | z4_01d1 == 1 | z4_01d1 == 2
replace abuse = . if z4_01c1 == 9 | z4_01d1 == 9 | z4_01c1 == 88 | z4_01d1 == 88 | z4_01c1 == . | z4_01d1 == .
keep a01 mid_mother abuse
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta", replace
//Santiary practices
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/064_bihs_r3_male_mod_r.dta", clear
keep a01 r01 r05 r01k r10 r06a
gen sealed_toilet = 0
replace sealed_toilet = 1 if r01 == 4 | r01 == 5
replace sealed_toilet = . if r01 == .
gen pipe_water = 0
replace pipe_water = 1 if r05 == 1 | r05 == 2 | r05 == 8
/*replace pipe_water = . if r05 == .
gen treated_water = 1
replace treated_water = 0 if r06a == 11 | r06a == 12
replace treated_water = 1 if r05 == 1 | r05 == 2
gen tubewell_water = 0
replace tubewell_water = 1 if r05 == 3 | r05 == 4 | r05 == 6 | r05 == 9 | r05 == 10 | r05 == 12*/

gen hand_wash = 0
replace hand_wash = 1 if r01k == 1 
replace hand_wash = . if r01k == .
gen open_garbage = 0
replace open_garbage = 1 if r10 == 6 | r10 == 7 | r10 == 8
replace open_garbage = . if r10 == .
keep a01 hand_wash open_garbage pipe_water sealed_toilet
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta", replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/065_bihs_r3_male_mod_r2.dta", clear
keep a01 r2_01 r2_09 r2_10
gen eat_soil = 1
replace eat_soil = 0 if r2_01 == 3
replace eat_soil = . if r2_01 == 5
replace eat_soil = . if r2_01 == .
gen animal_feces = 0
replace animal_feces = 1 if r2_09 == 1 | r2_10 == 1
keep a01 animal_feces eat_soil
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta", replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 a25
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
gen sibling = 1 if a25 > 1
replace sibling = 0 if a25 == 1 
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace

use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/030_bihs_r3_male_mod_i1.dta", clear
keep a01 crop_a_i1 i1_01 i1_06 i1_10
rename i1_01 harvested
rename i1_06 consumed
rename i1_10 sold
rename crop_a_i1 crop
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/farmD.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/034_bihs_r3_male_mod_i3.dta", clear
keep a01 i3_03 i3_04 i3_05 i3_06
rename i3_04 harvested
rename i3_05 consumed
rename i3_06 sold
rename i3_03 crop
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/farmD.dta"
drop if crop == . 
collapse (sum) consumed sold harvested, by (a01 crop)
duplicates tag a01 crop, generate(dup_hh)
tab dup_hh
gen FD = 1
collapse (sum) FD, by (a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m



***************************************
//INSTRUMENTS
****************************************
//hh info
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 community_id dvcode
save "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta", replace
//freedom of mobility
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/121_bihs_r3_female_mod_z1.dta", clear
keep a01 res_id_z12
rename res_id_z12 z3_mid
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/122_bihs_r3_female_mod_z2.dta"
keep a01 z2_01_1 z2_02_1 z2_03_1 z2_04_1 z2_05_1 z3_mid
forvalues j = 1/5 {
	generate mobility_`j'= 0 
	replace mobility_`j'= 1 if z2_0`j'_1 == 1
	replace mobility_`j'= 0.5 if z2_0`j'_1 == 3
	replace mobility_`j'= . if z2_0`j'_1 == .
}
egen score = rowtotal(mobility_1-mobility_5)
forvalues j = 1/5 {
	replace score = . if z2_0`j'_1 == .
}
gen mobility_score = score/5
keep a01 mobility_score z3_mid
//reproductive decisions
merge 1:1 a01 z3_mid using "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/123_bihs_r3_female_mod_z3.dta"
rename z3_mid z4_mid
gen repr_dec = 0 
replace repr_dec = 1 if z3_02 == 1
replace repr_dec = 0.5 if z3_02 == 3
replace repr_dec = . if z3_02 == .
keep a01 z4_mid mobility_score repr_dec
//physical or verbal abuse in last 12 months
merge 1:1 a01 z4_mid using  "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/124_bihs_r3_female_mod_z4.dta"
keep a01 z4_01c1 z4_01d1 z4_mid mobility_score repr_dec
rename z4_mid mid
gen abuse = 0
replace abuse = 1 if z4_01c1 == 1 | z4_01c1 == 2 | z4_01d1 == 1 | z4_01d1 == 2
replace abuse = . if z4_01c1 == 9 | z4_01d1 == 9 | z4_01c1 == 88 | z4_01d1 == 88 | z4_01c1 == . | z4_01d1 == .
keep a01 mid mobility_score repr_dec abuse
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta"
keep b1_04a b1_04b a01 mid mobility_score repr_dec abuse
rename b1_04a age_marriage
rename b1_04b age_pregnant
merge m:1 a01 using  "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta", replace
//value of assets brought during marriage
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/125_bihs_r3_female_mod_z5.dta", clear
keep a01 res_id_z5 z5_03 
rename res_id_z5 mid
collapse (sum) z5_03, by(a01 mid)
gen log_dowry = ln(z5_03)
merge 1:1 a01 mid using  "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta"
drop _merge
rename z5_03 dowry_value
rename mid mid_female
save "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta", replace
//community level empowermnet level 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 dvcode community_id
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta"
collapse (mean) ci, by(community_id)
rename ci avg_empw_female
merge 1:m community_id using "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta", replace
//religious diversity at village level
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta", clear
keep a01 a13 community_id a27
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta"
keep a01 mid a13 community_id a27
gen population = 1 if community_id != .
gen muslim = 0
replace muslim = 1 if a13 == 1
gen hindu = 0
replace hindu = 1 if a13 == 2
gen other = 0
replace other = 1 if a13 == 5
collapse (sum) population muslim hindu other, by(community_id)
gen muslim_share = muslim/population
gen hindu_share = hindu/population
gen other_share = other/population
gen muslim_share_sq = muslim_share ^ 2
gen hindu_share_sq = hindu_share  ^ 2
gen other_share_sq = other_share  ^ 2
egen summ_share = rowtotal(muslim_share_sq hindu_share_sq other_share_sq)
gen ELF = 1 - summ_share
keep ELF community_id 
merge 1:m community_id using "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta", replace
****************************************
//merge instruments with baseline
****************************************
use "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",clear
merge m:1 a01 mid_female community_id using "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta"
keep if _m == 3
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/des_iv_1.dta", replace
/****************************************
First stage 
1. freedom of mobility (mobility_score)
2. reproductive decisions (repr_dec)
3. physical or verbal abuse (abuse)
4. value of dowry (dowry_value)
5. religious diversity (ELF)
6. age when married first (age_marriage)
7. age when had child first (age_pregnant)
8. Average Empowerment Score at village level (avg_empw_female)
****************************************/

///RESULTS
log using "/Users/satwikav/Documents/GitHub/thesis/data/jan19.smcl"
use "/Users/satwikav/Documents/GitHub/thesis/data/des_iv_1.dta",clear
//summary stats
tabstat waz06 haz06 empw_female age_child girl_child sibling age_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage income_3 dvcode, c(stat) stat(mean sd min max n)
//prelimnary results
est clear  // clear the stored estimates
eststo: quietly reg haz06 empw_female
eststo: quietly reg waz06 empw_female
eststo: quietly reg haz06 empw_female i.dvcode
eststo: quietly reg waz06 empw_female i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
//main results
est clear  // clear the stored estimates
eststo: quietly reg haz06 empw_female age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode
eststo: quietly reg waz06 empw_female age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress 
pwcorr empw_female mobility_score dowry_value avg_empw_female ELF repr_dec age_marriage, star(0.5)
//Test of relevance with each of the instruments seperately 
est clear  // clear the stored estimates
eststo: quietly reg empw_female mobility_score age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode
eststo: quietly reg empw_female dowry_value age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode
eststo: quietly reg empw_female avg_empw_female age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress 
est clear  // clear the stored estimates
eststo: quietly reg empw_female ELF age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode
eststo: quietly reg empw_female repr_dec age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode
eststo: quietly reg empw_female age_marriage age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress 
//Regressions with each of the relevant instruments seperately
est clear  // clear the stored estimates
eststo: quietly ivregress 2sls haz06 age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode (empw_female = mobility_score)
estat endogenous
eststo: quietly ivregress 2sls haz06 age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode (empw_female = dowry_value)
estat endogenous
eststo: quietly ivregress 2sls haz06 age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode (empw_female = avg_empw_female)
estat endogenous
eststo: quietly ivregress 2sls haz06 age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode (empw_female = age_marriage)
estat endogenous
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress 
est clear  // clear the stored estimates
eststo: quietly ivregress 2sls waz06 age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode (empw_female = mobility_score)
estat endogenous
eststo: quietly ivregress 2sls waz06 age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode (empw_female = dowry_value)
estat endogenous
eststo: quietly ivregress 2sls waz06 age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode (empw_female = avg_empw_female)
estat endogenous
eststo: quietly ivregress 2sls waz06 age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode (empw_female = age_marriage)
estat endogenous
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress 
//Regressions with multiple instruments
ivregress 2sls haz06 age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode (empw_female = avg_empw_female dowry_value mobility_score age_marriage), first
estat firststage 
estat overid
estat endogenous
ivregress 2sls waz06 age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode (empw_female = avg_empw_female dowry_value mobility_score age_marriage), first
estat firststage 
estat overid
estat endogenous
log off


//variables for which tests more or less work 
ivregress 2sls waz06 age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode (empw_female = mobility_score age_marriage)
//, vce(robust)
estat firststage 
estat overid
estat endogenous
ivregress 2sls haz06 age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode (empw_female = mobility_score age_marriage)
//, vce(robust)
estat firststage 
estat overid
estat endogenous



