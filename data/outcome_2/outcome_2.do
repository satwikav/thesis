/////////OUTCOME - Nutrition for <23 months olds
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/113_bihs_r3_female_mod_y1.dta", clear
keep a01 y1_c1_00 child_age_y1c1 child_id_y1c1 y1_c1_03b1 y1_c1_11 y1_c1_12 y1_c1_13a_1 y1_c1_13b_1 y1_c1_13c_1 y1_c1_13d_1 y1_c1_13e_1 y1_c1_13f_1 y1_c1_13g_1 y1_c1_14_1 y1_c1_15a_1 y1_c1_15b_1 y1_c1_15c_1 y1_c1_15d_1 y1_c1_15e_1 y1_c1_15f_1 y1_c1_15g_1 y1_c1_15h_1 y1_c1_15i_1 y1_c1_15j_1 y1_c1_15k_1 y1_c1_15l_1 y1_c1_15m_1 y1_c1_15n_1 y1_c1_15o_1 y1_c1_15p_1 y1_c1_15q_1 y1_c1_15r_1 y1_c1_15s_1 y1_c1_15t_1 y1_c1_15u_1 y1_c1_15v_1 y1_c1_15w_1 y1_c1_15v1_1 y1_c1_15w1_1 y1_c1_15x_1 y1_c1_15y_1 mot_id_y1c1
drop if y1_c1_00 == 2
drop y1_c1_00
rename child_age_y1c1 child_age
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
rename child_id_y1c2 child_mid
rename mot_id_y1c2 mid_mother
rename y1_c2* y1* 
append using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
//gender of the child
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep if b1_02 <= 1 
keep a01 b1_01 mid
rename b1_01 child_gender
rename mid child_mid
merge 1:1 a01 child_mid using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
/////////OUTCOME - Nutrition for < 6 months olds
use "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
keep if child_age < 6
gen earlybf = 0 
replace earlybf = 1 if y1_03b1 == 0 | y1_03b1 == 1 
gen exbf = 1 
foreach i in y1_13b_1 y1_13c_1 y1_13d_1 y1_13e_1 y1_13f_1 y1_13g_1 y1_14_1 y1_15a_1 y1_15b_1 y1_15c_1 y1_15d_1 y1_15e_1 y1_15f_1 y1_15g_1 y1_15h_1 y1_15i_1 y1_15j_1 y1_15k_1 y1_15l_1 y1_15m_1 y1_15n_1 y1_15o_1 y1_15p_1 y1_15q_1 y1_15r_1 y1_15s_1 y1_15t_1 y1_15u_1 y1_15v_1 y1_15w_1 y1_15v1_1 y1_15w1_1 y1_15x_1 y1_15y_1{
		replace exbf = 0 if `i' == 1 
}
replace exbf = 0 if y1_13a_1 == .
egen DD = rowtotal(earlybf exbf)
keep DD a01 child_age child_gender child_mid earlybf exbf mid_mother
/*Female empowerment scores
- retain score, type of hh*/
merge m:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta"
keep if _m == 3
drop _m 
gen empw_female = ci
rename mid mid_female
keep DD a01 child_age child_gender child_mid earlybf exbf mother_mid empw_female mid_female
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta",replace
/*Mother's age
- get mother's age from hh info
- create if age square of mother*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_mother
rename b1_02 age_mother
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta"
keep if _m == 3
drop _merge
gen age_2_mother = age_mother ^ 2
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child1.dta", replace







