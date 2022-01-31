****************************************
//BASELINE DATASET FOR ANTHROPOMETRY 
****************************************
/*haz,whz,waz
- retain child z score, age,mother id
- calculate child's age square
- drop if child < 5 years is absent in hh*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/100_bihs_r3_female_mod_w2.dta", clear
keep a01 mid_w2 w2_14 haz06 waz06 whz06 w2_01
rename w2_01 mid_mother
rename w2_14 age_child
gen age_2_child = age_child ^ 2
drop if mid_w2 == 99
rename mid_w2 mid_child
/*gen stunting = .
replace stunting = 1 if haz06 <= -2
gen wasting = .
replace wasting = 1 if whz06 <= -2
gen underweight = .
replace underweight = 1 if waz06 <= -2*/
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta", replace
/*gender of child
- get child gender from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_01
rename mid mid_child
merge 1:1 a01 mid_child using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
gen girl_child = 1 if b1_01 == 2
replace girl_child = 0 if b1_01 == 1
drop b1_01
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta", replace
/*Female empowerment scores
- retain score, type of hh*/
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta", clear
gen empw_female = ci
rename wa06 wa06_female
rename mid mid_female
keep a01 empw_female wa06_female mid_female
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta", replace
/*Male empowerment scores
- retain score, type of hh
- check if type of hh is same for each hh 
- create if hh is deal headed
- calculate empowerment gap between male and female*/
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/male_score.dta", clear
gen empw_male = ci
rename wa06 wa06_male
keep a01 empw_male wa06_male
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
assert wa06_male == wa06_female
tab wa06_male
gen dual_headed = 1 if wa06_male == 1
replace dual_headed = 0 if wa06_male != 1
drop wa06_male wa06_female
gen gap = empw_male - empw_female
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta", replace
/*Mother's age
- get mother's age from hh info
- create if age square of mother*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_mother
rename b1_02 age_mother
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _merge
gen age_2_mother = age_mother ^ 2
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta", replace
/*Mother's height
- get mother's height from hh anthropometry*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/099_bihs_r3_female_mod_w1.dta", clear
keep a01 mid_w1 w1_04
rename mid_w1 mid_mother
rename w1_04 height_mother
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta", replace
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
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _merge b1_08
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
/*Household's location
- get hh location and size from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 dvcode div_name a23 community_id
rename a23 hh_size
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
/*Household head information
- get hhh occupation,age,highest class passed from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep if b1_03 == 1
keep a01 b1_10 b1_02 b1_08 b1_03
rename b1_02 age_hhh
gen farmer_hhh = 0
replace farmer_hhh = 1 if b1_10 == 64 | b1_10 == 65 | b1_10 == 66 | b1_10 == 67| b1_10 == 68| b1_10 == 69| b1_10 == 70| b1_10 == 71| b1_10 == 72
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
keep a01 age_hhh farmer_hhh edu_hhh
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
/*Household dependency ratio
- get number of dependents (age less than 15 and greater than 64) in each household from from hh info
- divide the dependents by household size to the dependency ratio*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02
drop if b1_02 == .
gen dependents = 0
replace dependents = 1 if b1_02 < 15 | b1_02 > 64
collapse (sum) dep, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
gen dep_ratio = dependents / hh_size
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
/* cultivable land operated by the household
- keep the land type, operational status and area
- generating operated cultivable land area in acres
- collapse at household level
- generated log tranformed area of land */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/020_bihs_r3_male_mod_g.dta",clear
keep a01 plotid g01 g02 g06
gen cultland=0
replace cultland=g02/100 if [g01==2 & (g06==2| g06==3|g06==4|g06==5|g06==9|g06==11|g06==12|g06==13)]| [g01==8 & (g06==2| g06==3|g06==4|g06==5|g06==9|g06==11|g06==12|g06==13)]  
collapse (sum) cultland, by(a01) 
gen log_land = ln(cultland + 1)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
/* total income of the household - step 1 
- keep the montly income earned by the members
- obtain the yearly income earned by the members 
- collapse at hh level*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/012_bihs_r3_male_mod_c.dta", clear
replace c14 = 0 if c14 == .
gen salary = c14 * 12
collapse (sum) salary, by(a01)
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
/* total income of the household - step 2
- keep the yearly remittances received by the members
- collapse at hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/073_bihs_r3_male_mod_v2.dta", clear
replace v2_06 = 0 if v2_06 == .
collapse (sum) v2_06, by(a01)
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
/* total income of the household - step 3
- keep the yearly other incomes received by the households
- sum them at the hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/076_bihs_r3_male_mod_v4.dta", clear
egen other = rowtotal(v4_01-v4_12)
keep a01 other
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
egen total_income = rowtotal(other v2_06 salary)
drop other v2_06 salary
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
/* income terciles
- calculate income terciles */
use "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",clear
xtile income_3 = total_income, nq(3)
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
***************************************
//INSTRUMENTS
****************************************
//hh info
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 community_id
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
merge 1:1 a01 mid using  "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta"
drop _merge
rename z5_03 dowry_value
rename mid mid_female
save "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta", replace
//community level empowermnet level 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 community_id
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
use "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",clear
merge m:1 a01 mid_female community_id using "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta"
keep if _m == 3
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/des_iv_1.dta", replace
/****************************************
Names of the instruments   
1. freedom of mobility (mobility_score)
2. reproductive decisions (repr_dec)
3. physical or verbal abuse (abuse)
4. value of dowry (dowry_value)
5. religious diversity (ELF)
6. age when married first (age_marriage)
7. age when had child first (age_pregnant)
8. Average Empowerment Score at village level (avg_empw_female)
****************************************/

****************************************
//BASELINE regressions with empowerment scores and gap
****************************************
log using "/Users/satwikav/Documents/GitHub/thesis/data/result_1.smcl"
use "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",clear
tabstat waz06 whz06 haz06 empw_female gap age_child girl_child age_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land income_3, c(stat) stat(mean sd min max n)
est clear  // clear the stored estimates
eststo: quietly reg haz06 empw_female
eststo: quietly reg waz06 empw_female
eststo: quietly reg whz06 empw_female
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
est clear  // clear the stored estimates
eststo: quietly reg haz06 empw_female age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3
eststo: quietly reg waz06 empw_female age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3
eststo: quietly reg whz06 empw_female age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
est clear  // clear the stored estimates
eststo: quietly reg haz06 empw_female age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
eststo: quietly reg waz06 empw_female age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
eststo: quietly reg whz06 empw_female age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
est clear  // clear the stored estimates
eststo: quietly reg haz06 gap
eststo: quietly reg waz06 gap
eststo: quietly reg whz06 gap
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
est clear  // clear the stored estimates
eststo: quietly reg haz06 gap age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3
eststo: quietly reg waz06 gap age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3
eststo: quietly reg whz06 gap age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
est clear  // clear the stored estimates
eststo: quietly reg haz06 gap age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
eststo: quietly reg waz06 gap age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
eststo: quietly reg whz06 gap age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
log off
****************************************
//correlation of endo with IVs
****************************************
log on
use "/Users/satwikav/Documents/GitHub/thesis/data/des_iv_1.dta",clear
tabstat mobility_score repr_dec abuse dowry_value ELF age_marriage age_pregnant avg_empw_female, c(stat) stat(mean sd min max n)
pwcorr empw_female mobility_score repr_dec abuse dowry_value ELF age_marriage age_pregnant avg_empw_female, star(0.5)
pwcorr gap mobility_score repr_dec abuse dowry_value ELF age_marriage age_pregnant avg_empw_female, star(0.5)
****************************************
//first stage
****************************************
est clear  // clear the stored estimates
eststo: quietly reg empw_female repr_dec age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
eststo: quietly reg empw_female abuse age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
est clear  // clear the stored estimates
eststo: quietly reg empw_female ELF age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
eststo: quietly reg empw_female age_marriage age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
eststo: quietly reg empw_female age_pregnant age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
est clear  // clear the stored estimates
eststo: quietly reg empw_female mobility_score age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
eststo: quietly reg empw_female dowry_value age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
eststo: quietly reg empw_female avg_empw_female age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
log close


/*

ivregress 2sls haz06 age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode (empw_female = mobility_score), first


ivregress liml haz06 age_child age_2_child girl_child age_mother age_2_mother height_mother edu_mother dual_headed age_hhh edu_hhh farmer_hhh dep_ratio log_land i.income_3 i.dvcode (empw_female = mobility_score)


*/


