/////////OUTCOME - Nutrition for <23 months olds
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/113_bihs_r3_female_mod_y1.dta", clear
keep a01 y1_c1_00 child_age_y1c1 child_id_y1c1 y1_c1_03b1 y1_c1_11 y1_c1_12 y1_c1_13a_1 y1_c1_13b_1 y1_c1_13c_1 y1_c1_13d_1 y1_c1_13e_1 y1_c1_13f_1 y1_c1_13g_1 y1_c1_14_1 y1_c1_15a_1 y1_c1_15b_1 y1_c1_15c_1 y1_c1_15d_1 y1_c1_15e_1 y1_c1_15f_1 y1_c1_15g_1 y1_c1_15h_1 y1_c1_15i_1 y1_c1_15j_1 y1_c1_15k_1 y1_c1_15l_1 y1_c1_15m_1 y1_c1_15n_1 y1_c1_15o_1 y1_c1_15p_1 y1_c1_15q_1 y1_c1_15r_1 y1_c1_15s_1 y1_c1_15t_1 y1_c1_15u_1 y1_c1_15v_1 y1_c1_15w_1 y1_c1_15v1_1 y1_c1_15w1_1 y1_c1_15x_1 y1_c1_15y_1 mot_id_y1c1
drop if y1_c1_00 == 2
drop y1_c1_00
rename child_age_y1c1 child_age
gen child_2_age = child_age ^ 2
rename child_id_y1c1 child_mid
rename mot_id_y1c1 mid_mother
rename y1_c1* y1* 
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/113_bihs_r3_female_mod_y1.dta", clear
keep a01 child_id_y1c2 y1_c1_00 child_age_y1c2 y1_c2_03b1 y1_c2_11 y1_c2_12 y1_c2_13a_1 y1_c2_13b_1 y1_c2_13c_1 y1_c2_13d_1 y1_c2_13e_1 y1_c2_13f_1 y1_c2_13g_1 y1_c2_14_1 y1_c2_15a_1 y1_c2_15b_1 y1_c2_15c_1 y1_c2_15d_1 y1_c2_15e_1 y1_c2_15f_1 y1_c2_15g_1 y1_c2_15h_1 y1_c2_15i_1 y1_c2_15j_1 y1_c2_15k_1 y1_c2_15l_1 y1_c2_15m_1 y1_c2_15n_1 y1_c2_15o_1 y1_c2_15p_1 y1_c2_15q_1 y1_c2_15r_1 y1_c2_15s_1 y1_c2_15t_1 y1_c2_15u_1 y1_c2_15v_1 y1_c2_15w_1 y1_c2_15v1_1 y1_c2_15w1_1 y1_c2_15x_1 y1_c2_15y_1 mot_id_y1c2
drop if y1_c1_00 == 2
drop y1_c1_00
drop if child_id_y1c2 == 0 | child_id_y1c2 == .
rename child_age_y1c2 child_age
gen child_2_age = child_age ^ 2
rename child_id_y1c2 child_mid
rename mot_id_y1c2 mid_mother
rename y1_c2* y1* 
append using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
//gender of the child
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_01 mid
gen child_gender = 0
replace child_gender = 1 if b1_01 == 2
drop b1_01
rename mid child_mid
merge 1:1 a01 child_mid using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
keep if _m == 3
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
/*
/////////OUTCOME - Nutrition for < 6 months olds
use "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
//keep if child_age < 6
gen earlybf = 0 
replace earlybf = 1 if y1_03b1 == 0 | y1_03b1 == 1 
gen exbf = 1 
foreach i in y1_13b_1 y1_13c_1 y1_13d_1 y1_13e_1 y1_13f_1 y1_13g_1 y1_14_1 y1_15a_1 y1_15b_1 y1_15c_1 y1_15d_1 y1_15e_1 y1_15f_1 y1_15g_1 y1_15h_1 y1_15i_1 y1_15j_1 y1_15k_1 y1_15l_1 y1_15m_1 y1_15n_1 y1_15o_1 y1_15p_1 y1_15q_1 y1_15r_1 y1_15s_1 y1_15t_1 y1_15u_1 y1_15v_1 y1_15w_1 y1_15v1_1 y1_15w1_1 y1_15x_1 y1_15y_1{
		replace exbf = 0 if `i' == 1 
}
replace exbf = 0 if y1_13a_1 == .
egen DD = rowtotal(earlybf exbf)
keep DD a01 child_age child_gender child_mid earlybf exbf mid_mother child_2_age
*/
/////////OUTCOME - Nutrition for 6 - 23 months olds
use "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if child_age < 6
forvalues j = 1/8 {
	generate foodgroup`j'= 0 
}
replace foodgroup1 = 1 if y1_15a_1 == 1 | y1_15b_1 == 1 | y1_15g_1 == 1
replace foodgroup2 = 1 if y1_15d_1 == 1 | y1_15p_1 == 1 
replace foodgroup3 = 1 if y1_13d_1 == 1 | y1_15q_1 == 1 | y1_15r_1 == 1
replace foodgroup4 = 1 if y1_15k_1 == 1 | y1_15l_1 == 1 | y1_15m_1 == 1 | y1_15n_1 == 1 
replace foodgroup5 = 1 if y1_15o_1 == 1
replace foodgroup6 = 1 if y1_15e_1 == 1 | y1_15f_1 == 1 | y1_15h_1 == 1
replace foodgroup7 = 1 if y1_15i_1 == 1 | y1_15j_1 == 1 
replace foodgroup8 = 1 if y1_13a_1 == 1 
egen DD = rowtotal(foodgroup1 -foodgroup8)
keep DD a01 child_age child_gender child_mid mid_mother child_2_age
/*Female empowerment scores
- retain score, type of hh*/
merge m:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta"
keep if _m == 3
drop _m 
gen empw_female = ci
rename mid mid_female
keep DD a01 child_age child_gender child_mid mid_mother empw_female mid_female child_2_age
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
/*Mother's age
- get mother's age from hh info
- create if age square of mother*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_mother
rename b1_02 age_mother
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if _m == 1
drop _merge
gen age_2_mother = age_mother ^ 2
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta", replace
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
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if _m == 1
drop _merge b1_08
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
/*Household's location
- get hh location and size from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 dvcode a23 community_id
rename a23 hh_size
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
/*Household dependency ratio
- get number of dependents (age less than 15 and greater than 64) in each household from from hh info
- divide the dependents by household size to the dependency ratio*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02
drop if b1_02 == .
gen dependents = 0
replace dependents = 1 if b1_02 < 15 | b1_02 > 64
collapse (sum) dep, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if _m == 1
drop _m
gen dep_ratio = dependents / hh_size
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
/* total income of the household - step 1 
- keep the montly income earned by the members
- obtain the yearly income earned by the members 
- collapse at hh level*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/012_bihs_r3_male_mod_c.dta", clear
replace c14 = 0 if c14 == .
gen salary = c14 * 12
collapse (sum) salary, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
/* total income of the household - step 2
- keep the yearly remittances received by the members
- collapse at hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/073_bihs_r3_male_mod_v2.dta", clear
replace v2_06 = 0 if v2_06 == .
collapse (sum) v2_06, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
/* total income of the household - step 3
- keep the yearly other incomes received by the households
- sum them at the hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/076_bihs_r3_male_mod_v4.dta", clear
egen other = rowtotal(v4_01-v4_12)
keep a01 other
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if _m == 1
drop _m
egen total_income = rowtotal(other v2_06 salary)
drop other v2_06 salary
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
/* income terciles
- calculate income terciles */
use "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",clear
xtile income_3 = total_income, nq(3)
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
/* distance to local shops
- keep only if the facility is local shops
- merge the distance with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/066_bihs_r3_male_mod_s.dta", clear
keep if s_01 == 5 
keep a01 s_04 
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if _m == 1
drop _m
rename s_04 dist_shop
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
/* distance to weekly bazaar
- keep only if the facility is weekly market
- merge the distance with previous data
- save in out_1.dta 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/066_bihs_r3_male_mod_s.dta", clear
keep if s_01 == 6
keep a01 s_04 
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if _m == 1
drop _m
rename s_04 dist_bazaar
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace*/
//Farm diversity: Number of crop species including vegetables and fruits produced by the household in the last year 
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace



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
keep a01 res_id_z5 z5_03 z5_01
rename res_id_z5 mid
collapse (sum) z5_03 (max) z5_01, by(a01 mid)
gen log_dowry = ln(z5_03)
merge 1:1 a01 mid using  "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta"
drop _merge
rename z5_03 dowry_value
rename z5_01 dowry
rename mid mid_female
replace dowry = 0 if dowry == 2
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
use "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",clear
merge m:1 a01 mid_female community_id using "/Users/satwikav/Documents/GitHub/thesis/data/iv_1.dta"
keep if _m == 3
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1_iv.dta", replace


///RESULTS
//log using "/Users/satwikav/Documents/GitHub/thesis/data/jan19.smcl"
use "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1_iv.dta",clear
//summary stats
tabstat DD empw_female child_age child_gender age_mother age_hhh dep_ratio dist_shop edu_hhh edu_mother farmer_hhh log_land income_3 dvcode FD, c(stat) stat(mean sd min max n)
//prelimnary results
est clear  // clear the stored estimates
eststo: quietly reg DD empw_female
eststo: quietly reg DD empw_female i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
//main results
est clear  // clear the stored estimates
eststo: quietly reg DD empw_female child_2_age child_age child_gender age_2_mother age_mother age_hhh dep_ratio dist_shop  edu_hhh edu_mother farmer_hhh log_land FD i.income_3 i.dvcode 
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress 
//using instruments
pwcorr empw_female mobility_score dowry_value dowry avg_empw_female ELF repr_dec age_marriage, star(0.5)
//Test of relevance with each of the instruments seperately 
est clear  // clear the stored estimates
eststo: quietly reg empw_female mobility_score child_2_age child_age child_gender age_2_mother age_mother age_hhh dep_ratio dist_shop  edu_hhh edu_mother farmer_hhh log_land FD i.income_3 i.dvcode
eststo: quietly reg empw_female dowry_value child_2_age child_age child_gender age_2_mother age_mother age_hhh dep_ratio dist_shop  edu_hhh edu_mother farmer_hhh log_land FD i.income_3 i.dvcode
eststo: quietly reg empw_female dowry child_2_age child_age child_gender age_2_mother age_mother age_hhh dep_ratio dist_shop  edu_hhh edu_mother farmer_hhh log_land FD i.income_3 i.dvcode
eststo: quietly reg empw_female avg_empw_female child_2_age child_age child_gender age_2_mother age_mother age_hhh dep_ratio dist_shop  edu_hhh edu_mother farmer_hhh log_land FD i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress 
est clear  // clear the stored estimates
eststo: quietly reg empw_female ELF child_2_age child_age child_gender age_2_mother age_mother age_hhh dep_ratio dist_shop  edu_hhh edu_mother farmer_hhh log_land FD i.income_3 i.dvcode
eststo: quietly reg empw_female repr_dec child_2_age child_age child_gender age_2_mother age_mother age_hhh dep_ratio dist_shop  edu_hhh edu_mother farmer_hhh log_land FD i.income_3 i.dvcode
eststo: quietly reg empw_female age_marriage child_2_age child_age child_gender age_2_mother age_mother age_hhh dep_ratio dist_shop  edu_hhh edu_mother farmer_hhh log_land FD i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress 
