/////////HHH INFO
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
destring, replace
sort a01 res_id_a
keep a01 res_id_a div_name a13 a23 a24 a25 a26
rename res_id_a mid
save "/Users/satwikav/Documents/GitHub/thesis/data/1.dta",replace
/////////HH MEMBER INFO
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
destring, replace
keep a01 mid b1_01 b1_02 b1_03 b1_04 b1_04a b1_04b b1_07 b1_08 b1_09 b1_10 b1_11 b1_10_r3 b1_11_r3
sort a01 mid
save "/Users/satwikav/Documents/GitHub/thesis/data/2.dta",replace
/////////SCHOOLING
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/011_bihs_r3_male_mod_b2.dta", clear
keep a01 mid_b2 b2_01 b2_03 b2_04 b2_05 b2_06a b2_06b b2_08b b2_08c b2_08d b2_11
destring, replace
sort a01 mid_b2
rename mid_b2 mid
save "/Users/satwikav/Documents/GitHub/thesis/data/3.dta",replace
/////////ASSETS-1 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/015_bihs_r3_male_mod_d1.dta",clear
keep a01 res_id_d d1_02 d1_02oth d1_03 d1_04 d1_05 d1_06_a d1_06_b d1_06_c d1_07 d1_08 d1_09 d1_10 d1_11 d1_12
destring, replace
sort a01 d1_02
save "/Users/satwikav/Documents/GitHub/thesis/data/4.dta",replace
/////////ASSETS-2
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/016_bihs_r3_male_mod_d2.dta",clear
keep a01 d2_02 d2_03 d2_04 d2_05 d2_06_a d2_06_b d2_06_c d2_07 d2_08 d2_09 d2_10 d2_12
destring, replace
sort a01 d2_02
save "/Users/satwikav/Documents/GitHub/thesis/data/5.dta",replace
/////////SAVINGS
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/017_bihs_r3_male_mod_e.dta",clear
keep a01 e01 e02 mid_e e04 e05 e06 e07
destring, replace
sort a01 mid_e
save "/Users/satwikav/Documents/GitHub/thesis/data/6.dta",replace
/////////LOANS
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/018_bihs_r3_male_mod_f.dta", clear
keep a01 f01 f02 f02_a f02_b f02_c mid_f f04 f06_a f06_b f06_c f07 f08 f09 f10
destring, replace
sort a01 mid_f
save "/Users/satwikav/Documents/GitHub/thesis/data/7.dta",replace
/////////OPINION ON CHILD MARRIAGE - MALE
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/019_bihs_r3_male_mod_xxc.dta", clear
keep a01 xxc_01 xxc_02
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/8.dta",replace
/////////LAND OWNERSHIP
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/020_bihs_r3_male_mod_g.dta", clear 
keep a01 plotid g01 g02_1 g02 g20 g03 g06 g21 g08a g08b g08c g09a g09b g09c g11
sort a01 plotid
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/9.dta",replace
/////////LIVESTOCK
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/043_bihs_r3_male_mod_k1.dta",clear
keep a01 livestock k1_01 k1_04 k1_04a k1_05a k1_05b k1_05c
sort a01 livestock
keep if k1_04 != 0
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/10.dta",replace
/////////INCOME
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/012_bihs_r3_male_mod_c.dta",clear
keep a01 mid_c c05 c10 c11 c13 c14
sort a01 mid_c
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/11.dta",replace
replace c14 = 0 if c14 == .
collapse (sum) c14, by (a01 mid_c)
save "/Users/satwikav/Documents/GitHub/thesis/data/12.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/076_bihs_r3_male_mod_v4.dta", clear
keep a01 v4_01 v4_02 v4_03 v4_04 v4_05 v4_06 v4_07 v4_08 v4_09 v4_10 v4_11 v4_12
destring, replace
gen totalincome = v4_01+v4_02+v4_03+v4_04+v4_05+v4_06+v4_07+v4_08+v4_09+v4_10+v4_11+v4_12
save "/Users/satwikav/Documents/GitHub/thesis/data/19.dta",replace
/////////EXPENDITURE
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/061_bihs_r3_male_mod_p1.dta", clear
keep a01 p1_01 p1_02 p1_04
sort a01 p1_01
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/13.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/062_bihs_r3_male_mod_p2.dta", clear
keep a01 p2_01 p2_02 p2_03 p2_04 p2_05 p2_06 p2_07
sort a01 p2_01
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/14.dta",replace
/////////HOUSING
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/063_bihs_r3_male_mod_q.dta", clear
keep a01 q_01 q_10 q_11 q_11c q_12 q_13 q_20 q_20a q_20a_2 q_20b q_20b_2 q_20c q_20c_2
sort a01
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/15.dta",replace
/////////ACCESS
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/066_bihs_r3_male_mod_s.dta", clear
keep a01 s_01 s_02 s_04 s_05 s_06
sort a01 s_01
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/16.dta",replace
/////////MIGRATION
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/072_bihs_r3_male_mod_v1.dta", clear
keep a01 v1_01 pid_v1 mid_v1 v1_02 v1_03 v1_04 v1_05 v1_06 v1_07 v1_08 v1_12 v1_14
keep if v1_01 == 1
sort a01 mid_v1
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/17.dta",replace
/////////REMITTANCE
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/073_bihs_r3_male_mod_v2.dta", clear
keep a01 v2_01 pid_v2 mid_v2 v2_02 v2_05 v2_06 v2_11
keep if v2_01 == 1
sort a01 mid_v2
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/18.dta",replace
/////////havent looked at male responses for WEAI starting from mod 78
/////////OPINION ON CHILD MARRIAGE - FEMALE
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/093_bihs_r3_female_mod_xxc.dta", clear
keep a01 xxc_01 xxc_02
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/20.dta",replace
/////////EARLY MARRIAGE
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/094_bihs_r3_female_mod_xxa.dta", clear
sort a01 
keep a01 xxa_mid res_id_xxa xxa_pid xxa_04 xxa_07 xxa_15a xxa_15b xxa_15c xxa_16 xxa_17a xxa_17b xxa_17c
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/21.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/095_bihs_r3_female_mod_xxb.dta", clear
keep a01 xxb_mid xxb_04 xxb_07 xxb_15a xxb_15b xxb_15c xxb_16 xxb_17a xxb_17b xxb_17c
sort a01
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/22.dta",replace
/////////ANTHROPOMETRY
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/099_bihs_r3_female_mod_w1.dta", clear
keep a01 mid_w1 sex age1 w1_03 w1_04 w1_31 w1_32 w1_33
sort a01 mid_w1
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/23.dta",replace
/////////ILLNESS
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/104_bihs_r3_female_mod_w5a.dta", clear
keep a01 mid_w5a age_w5a w5_05 w5_06 w5_07 w5_08 w5_09 w5_10 w5_11 w5_12 w5_13
sort a01 mid_w5a
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/25.dta",replace


/////////OUTCOME - z scores for <5 year olds
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/100_bihs_r3_female_mod_w2.dta", clear
keep a01 mid_w2 w2_14 haz06 waz06 whz06 bmiz06
sort a01 mid_w2
rename mid_w2 mid
drop if mid == 99
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/zscore.dta",replace
/////////OUTCOME - Nutrition for <2 year olds
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/113_bihs_r3_female_mod_y1.dta", clear
keep a01 y1_c1_00 child_age_y1c1 child_id_y1c1 y1_c1_03b1 y1_c1_11 y1_c1_12 y1_c1_13a_1 y1_c1_13b_1 y1_c1_13c_1 y1_c1_13d_1 y1_c1_13e_1 y1_c1_13f_1 y1_c1_13g_1 y1_c1_14_1 y1_c1_15a_1 y1_c1_15b_1 y1_c1_15c_1 y1_c1_15d_1 y1_c1_15e_1 y1_c1_15f_1 y1_c1_15g_1 y1_c1_15h_1 y1_c1_15i_1 y1_c1_15j_1 y1_c1_15k_1 y1_c1_15l_1 y1_c1_15m_1 y1_c1_15n_1 y1_c1_15o_1 y1_c1_15p_1 y1_c1_15q_1 y1_c1_15r_1 y1_c1_15s_1 y1_c1_15t_1 y1_c1_15u_1 y1_c1_15v_1 y1_c1_15w_1 y1_c1_15v1_1 y1_c1_15w1_1 y1_c1_15x_1 y1_c1_15y_1 
rename child_id_y1c1 mid
drop if y1_c1_00 == 2
drop y1_c1_00
gen earlybf = 0 
replace earlybf = 1 if y1_c1_03b1 == 0 | y1_c1_03b1 == 1 
gen exbf = 1 if child_age_y1c1 < 6
foreach i in y1_c1_13b_1 y1_c1_13c_1 y1_c1_13d_1 y1_c1_13e_1 y1_c1_13f_1 y1_c1_13g_1 y1_c1_14_1 y1_c1_15a_1 y1_c1_15b_1 y1_c1_15c_1 y1_c1_15d_1 y1_c1_15e_1 y1_c1_15f_1 y1_c1_15g_1 y1_c1_15h_1 y1_c1_15i_1 y1_c1_15j_1 y1_c1_15k_1 y1_c1_15l_1 y1_c1_15m_1 y1_c1_15n_1 y1_c1_15o_1 y1_c1_15p_1 y1_c1_15q_1 y1_c1_15r_1 y1_c1_15s_1 y1_c1_15t_1 y1_c1_15u_1 y1_c1_15v_1 y1_c1_15w_1 y1_c1_15v1_1 y1_c1_15w1_1 y1_c1_15x_1 y1_c1_15y_1{
		replace exbf = 0 if `i' == 1 & child_age_y1c1 < 6
}
replace exbf = 0 if y1_c1_13a_1 == .
replace exbf = . if child_age_y1c1 >= 6
forvalues j = 1/10 {
	generate foodgroup`j'= 0 
}
replace foodgroup1 = 1 if y1_c1_15a_1 == 1 | y1_c1_15b_1 == 1 | y1_c1_15g_1 == 1
replace foodgroup2 = 1 if y1_c1_15d_1 == 1 | y1_c1_15p_1 == 1 
replace foodgroup3 = 1 if y1_c1_13d_1 == 1 | y1_c1_15q_1 == 1 | y1_c1_15r_1 == 1
replace foodgroup4 = 1 if y1_c1_15k_1 == 1 | y1_c1_15l_1 == 1 | y1_c1_15m_1 == 1 | y1_c1_15n_1 == 1 
replace foodgroup5 = 1 if y1_c1_15o_1 == 1
replace foodgroup6 = 1 if y1_c1_15e_1 == 1 | y1_c1_15f_1 == 1 | y1_c1_15h_1 == 1
replace foodgroup7 = 1 if y1_c1_15i_1 == 1 | y1_c1_15j_1 == 1 
replace foodgroup8 = 1 if y1_c1_13a_1 == 1 
replace foodgroup9 = 1 if y1_c1_15u_1 == 1 | y1_c1_13c_1 == 1 |y1_c1_15s_1 == 1 |y1_c1_13e_1== 1 | y1_c1_13f_1== 1 | y1_c1_13g_1== 1 | y1_c1_15c_1 == 1 |y1_c1_15t_1 == 1 |y1_c1_15v_1 == 1 |y1_c1_15v1_1== 1
replace foodgroup10 = 1 if y1_c1_15w_1 == 1 |y1_c1_15w1_1== 1 
egen DDscore = rowtotal(foodgroup1 foodgroup2 foodgroup3 foodgroup4 foodgroup5 foodgroup6 foodgroup7 foodgroup8)
gen minDD = 0
replace minDD = 1 if DDscore >= 4
replace minDD = . if child_age_y1c1 < 6
replace y1_c1_12 = 0 if y1_c1_12 == 99
replace y1_c1_11 = 0 if y1_c1_11 == 99
gen minfrq = 0
gen totalfrq = y1_c1_12 + y1_c1_11
replace minfrq = 1 if y1_c1_13a_1 == 1 & child_age_y1c1 < 8 & y1_c1_12 >= 2
replace minfrq = 1 if y1_c1_13a_1 == 1 & child_age_y1c1 >= 8 & y1_c1_12 >= 3
replace minfrq = 1 if y1_c1_13a_1 == 2 & totalfrq >= 4	
replace minfrq = . if child_age_y1c1 < 6
keep a01 mid child_age_y1c1 earlybf exbf foodgroup1 foodgroup2 foodgroup3 foodgroup4 foodgroup5 foodgroup6 foodgroup7 foodgroup8 foodgroup9 foodgroup10 DDscore minDD minfrq totalfrq
sort a01 mid
rename child_age_y1c1 age
save "/Users/satwikav/Documents/GitHub/thesis/data/child1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/113_bihs_r3_female_mod_y1.dta", clear
keep a01 child_id_y1c2 child_age_y1c2 y1_c2_03b1 y1_c2_11 y1_c2_12 y1_c2_13a_1 y1_c2_13b_1 y1_c2_13c_1 y1_c2_13d_1 y1_c2_13e_1 y1_c2_13f_1 y1_c2_13g_1 y1_c2_14_1 y1_c2_15a_1 y1_c2_15b_1 y1_c2_15c_1 y1_c2_15d_1 y1_c2_15e_1 y1_c2_15f_1 y1_c2_15g_1 y1_c2_15h_1 y1_c2_15i_1 y1_c2_15j_1 y1_c2_15k_1 y1_c2_15l_1 y1_c2_15m_1 y1_c2_15n_1 y1_c2_15o_1 y1_c2_15p_1 y1_c2_15q_1 y1_c2_15r_1 y1_c2_15s_1 y1_c2_15t_1 y1_c2_15u_1 y1_c2_15v_1 y1_c2_15w_1 y1_c2_15v1_1 y1_c2_15w1_1 y1_c2_15x_1 y1_c2_15y_1
rename child_id_y1c2 mid
drop if child_age_y1c2 == .
gen earlybf = 0 
replace earlybf = 1 if y1_c2_03b1 == 0 | y1_c2_03b1 == 1 
gen exbf = 1 if child_age_y1c2 < 6
foreach i in y1_c2_13b_1 y1_c2_13c_1 y1_c2_13d_1 y1_c2_13e_1 y1_c2_13f_1 y1_c2_13g_1 y1_c2_14_1 y1_c2_15a_1 y1_c2_15b_1 y1_c2_15c_1 y1_c2_15d_1 y1_c2_15e_1 y1_c2_15f_1 y1_c2_15g_1 y1_c2_15h_1 y1_c2_15i_1 y1_c2_15j_1 y1_c2_15k_1 y1_c2_15l_1 y1_c2_15m_1 y1_c2_15n_1 y1_c2_15o_1 y1_c2_15p_1 y1_c2_15q_1 y1_c2_15r_1 y1_c2_15s_1 y1_c2_15t_1 y1_c2_15u_1 y1_c2_15v_1 y1_c2_15w_1 y1_c2_15v1_1 y1_c2_15w1_1 y1_c2_15x_1 y1_c2_15y_1{
		replace exbf = 0 if `i' == 1 & child_age_y1c2 < 6
}
replace exbf = 0 if y1_c2_13a_1 == .
replace exbf = . if child_age_y1c2 >= 6
forvalues j = 1/10 {
	generate foodgroup`j'= 0 
}
replace foodgroup1 = 1 if y1_c2_15a_1 == 1 | y1_c2_15b_1 == 1 | y1_c2_15g_1 == 1
replace foodgroup2 = 1 if y1_c2_15d_1 == 1 | y1_c2_15p_1 == 1 
replace foodgroup3 = 1 if y1_c2_13d_1 == 1 | y1_c2_15q_1 == 1 | y1_c2_15r_1 == 1
replace foodgroup4 = 1 if y1_c2_15k_1 == 1 | y1_c2_15l_1 == 1 | y1_c2_15m_1 == 1 | y1_c2_15n_1 == 1 
replace foodgroup5 = 1 if y1_c2_15o_1 == 1
replace foodgroup6 = 1 if y1_c2_15e_1 == 1 | y1_c2_15f_1 == 1 | y1_c2_15h_1 == 1
replace foodgroup7 = 1 if y1_c2_15i_1 == 1 | y1_c2_15j_1 == 1 
replace foodgroup8 = 1 if y1_c2_13a_1 == 1 
replace foodgroup9 = 1 if y1_c2_15u_1 == 1 | y1_c2_13c_1 == 1 |y1_c2_15s_1 == 1 |y1_c2_13e_1== 1 | y1_c2_13f_1== 1 | y1_c2_13g_1== 1 | y1_c2_15c_1 == 1 |y1_c2_15t_1 == 1 |y1_c2_15v_1 == 1 |y1_c2_15v1_1== 1
replace foodgroup10 = 1 if y1_c2_15w_1 == 1 |y1_c2_15w1_1== 1 
egen DDscore = rowtotal(foodgroup1 foodgroup2 foodgroup3 foodgroup4 foodgroup5 foodgroup6 foodgroup7 foodgroup8)
gen minDD = 0
replace minDD = 1 if DDscore >= 4
replace minDD = . if child_age_y1c2 < 6
replace y1_c2_12 = 0 if y1_c2_12 == 99
replace y1_c2_11 = 0 if y1_c2_11 == 99
gen minfrq = 0
gen totalfrq = y1_c2_12 + y1_c2_11
replace minfrq = 1 if y1_c2_13a_1 == 1 & child_age_y1c2 < 8 & y1_c2_12 >= 2
replace minfrq = 1 if y1_c2_13a_1 == 1 & child_age_y1c2 >= 8 & y1_c2_12 >= 3
replace minfrq = 1 if y1_c2_13a_1 == 2 & totalfrq >= 4	
replace minfrq = . if child_age_y1c2 < 6
keep a01 mid child_age_y1c2 earlybf exbf foodgroup1 foodgroup2 foodgroup3 foodgroup4 foodgroup5 foodgroup6 foodgroup7 foodgroup8 foodgroup9 foodgroup10 DDscore minDD minfrq totalfrq
sort a01 mid
rename child_age_y1c2 age
append using "/Users/satwikav/Documents/GitHub/thesis/data/child1.dta"
sort a01 mid
save "/Users/satwikav/Documents/GitHub/thesis/data/nutrition.dta",replace //9 var, 925 obs
/////////OUTCOME - Nutrition for >2 year olds
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/105_bihs_r3_female_mod_x1.dta",clear
keep a01 x1_05 x1_07 x1_07_01 x1_07_02  x1_07_04 x1_07_05 x1_07_06 x1_07_07 x1_07_08 x1_07_09 x1_07_10 x1_07_11 x1_07_12 x1_07_13 x1_07_14 x1_07_15
//duplicates tag a01 x1_05, generate(dup_hh)
//duplicates drop a01 x1_05, force
rename x1_05 menucode
sort a01
//label drop x1_05
//rename x1_07* (=_)
//reshape wide x1_07_ x1_07_01_ x1_07_02_, i(a01) j(x1_05)
save "/Users/satwikav/Documents/GitHub/thesis/data/hhds.dta",replace 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/106_bihs_r3_female_mod_x2.dta",clear
keep a01 x2_01 x2_08
drop if x2_01 == 101 | x2_01 == 201 | x2_01 == 301 | x2_01 == 401
drop if x2_08 == .
rename x2_08 menucode
//duplicates drop a01 x2_01 menucode, force
merge m:m a01 menucode using "/Users/satwikav/Documents/GitHub/thesis/data/hhds.dta"
drop _merge

decode menucode, gen(foodString) 
drop if foodString == "Ghee" | foodString == "Butter" //group 14 dropped
drop if foodString == "Sugar"|foodString == "Gur"|foodString == "Misri/tal mistri"|foodString == "Honey"|foodString =="Coke/ Seven-up etc/Pepci/RC/Urocola etc"|foodString =="Packaged Juice"|foodString =="Horlicks/Bournvita/Tang"|foodString =="Sugarcane/palm/date juice"|foodString =="Paes/firni/cooked firni"|foodString =="Pitha"|foodString =="Halua"|foodString =="Sweets"|foodString =="Biscuit"|foodString =="Cake"|foodString =="Chocolate"|foodString =="Gaja"|foodString =="Murali"|foodString =="Mowa (muri/chira)"|foodString =="Chewing gum"|foodString =="Ice Cream" //group 15 dropped
drop if foodString == "mustard"|foodString =="green chilli"|foodString =="Dried chili"|foodString =="Tea ?prepared" //group 16 dropped
forvalues j = 1/16 {
	generate foodgroup`j'= 0 
}






















/////////MERGE
use "/Users/satwikav/Documents/GitHub/thesis/data/1.dta", clear
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/2.dta"
drop _merge 
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/24.dta"
drop _merge 

use "/Users/satwikav/Documents/GitHub/thesis/data/4.dta", clear




//////extraaa
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/113_bihs_r3_female_mod_y1.dta", clear
keep a01 child_id_y1c1 child_age_y1c1 y1_c1_03b1 y1_c1_00
drop if y1_c1_00 == 2
drop y1_c1_00
rename child_id_y1c1 mid
gen earlybf = 0
replace earlybf = 1 if y1_c1_03b1 == 0 | y1_c1_03b1 == 1 
count if child_age_y1c1 < 12
gen child_n = 464
count if child_age_y1c1 >= 12
replace child_n = 444 if child_age_y1c1 >= 12
gen ebr = earlybf / child_n
/////////OUTCOME - minimum dietary diversity 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/113_bihs_r3_female_mod_y1.dta", clear
keep a01 y1_c1_00 child_id_y1c1 child_age_y1c1 y1_c1_13a_1 y1_c1_13a_2 y1_c1_13b_1 y1_c1_13b_2 y1_c1_13c_1 y1_c1_13c_2 y1_c1_13d_1 y1_c1_13d_2 y1_c1_13e_1 y1_c1_13e_2 y1_c1_13f_1 y1_c1_13f_2 y1_c1_13g_1 y1_c1_13g_2 y1_c1_14_1 y1_c1_14_2 y1_c1_15a_1 y1_c1_15a_2 y1_c1_15b_1 y1_c1_15b_2 y1_c1_15c_1 y1_c1_15c_2 y1_c1_15d_1 y1_c1_15d_2 y1_c1_15e_1 y1_c1_15e_2 y1_c1_15f_1 y1_c1_15f_2 y1_c1_15g_1 y1_c1_15g_2 y1_c1_15h_1 y1_c1_15h_2 y1_c1_15i_1 y1_c1_15i_2 y1_c1_15j_1 y1_c1_15j_2 y1_c1_15k_1 y1_c1_15k_2 y1_c1_15l_1 y1_c1_15l_2 y1_c1_15m_1 y1_c1_15m_2 y1_c1_15n_1 y1_c1_15n_2 y1_c1_15o_1 y1_c1_15o_2 y1_c1_15p_1 y1_c1_15p_2 y1_c1_15q_1 y1_c1_15q_2 y1_c1_15r_1 y1_c1_15r_2 y1_c1_15s_1 y1_c1_15s_2 y1_c1_15t_1 y1_c1_15t_2 y1_c1_15u_1 y1_c1_15u_2 y1_c1_15v_1 y1_c1_15v_2 y1_c1_15w_1 y1_c1_15w_2 y1_c1_15v1_1 y1_c1_15v1_2 y1_c1_15w1_1 y1_c1_15w1_2 y1_c1_15x_1 y1_c1_15x_2 y1_c1_15y_1 y1_c1_15y_2 y1_c1_15_1 y1_c1_06 y1_c1_07 y1_c1_03b1 y1_c1_05
drop if y1_c1_00 == 2
drop y1_c1_00
rename child_id_y1c1 mid
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/113_bihs_r3_female_mod_y1.dta", clear
keep a01 y1_c1_00 child_id_y1c1 child_age_y1c1 y1_c1_03b1 y1_c1_05 y1_c1_13a_1 
drop if y1_c1_00 == 2
drop y1_c1_00
rename child_id_y1c1 mid
gen earlybf = 0
replace earlybf = 1 if y1_c1_03b1 == 0 | y1_c1_03b1 == 1 
gen colostrum = 0
replace colostrum = 1 if y1_c1_05 == 1 
gen bf = 0
replace bf = 1 if y1_c1_13a_1 == 1 
gen score = earlybf+ colostrum+ bf
gen lnscore = log(score)
label drop y1_c1_13a_1
label drop y1_c1_13b_1
label drop y1_c1_13c_1
label drop y1_c1_13d_1
label drop y1_c1_13e_1
label drop y1_c1_13f_1
label drop y1_c1_13g_1
label drop y1_c1_14_1
label drop y1_c1_15a_1
label drop y1_c1_15b_1
label drop y1_c1_15c_1
label drop y1_c1_15d_1
label drop y1_c1_15e_1
label drop y1_c1_15f_1
label drop y1_c1_15g_1
label drop y1_c1_15h_1
label drop y1_c1_15i_1
label drop y1_c1_15j_1
label drop y1_c1_15k_1
label drop y1_c1_15l_1
label drop y1_c1_15m_1
label drop y1_c1_15n_1
label drop y1_c1_15o_1
label drop y1_c1_15p_1
label drop y1_c1_15q_1
label drop y1_c1_15r_1
label drop y1_c1_15s_1
label drop y1_c1_15t_1
label drop y1_c1_15u_1
label drop y1_c1_15v1_1
label drop y1_c1_15v_1
label drop y1_c1_15w1_1
label drop y1_c1_15w_1
label drop y1_c1_15y_1
replace foodgroup1 = -1 if y1_c1_03d1 != 7 
replace foodgroup1 = 0 if y1_c1_03d1 == .
drop y1_c1_03d1
replace foodgroup2 = -1 if y1_c1_03d2 != 7
replace foodgroup2 = 0 if y1_c1_03d2 == .
drop y1_c1_03d2
replace foodgroup3 = -1 if y1_c1_03d3 != 7
replace foodgroup3 = 0 if y1_c1_03d3 == .
drop y1_c1_03d3
replace foodgroup4 = -1 if y1_c1_04_1 != 7
replace foodgroup4 = 0 if y1_c1_04_1 == .
drop y1_c1_04_1
replace foodgroup5 = -1 if y1_c1_04_2 != 7
replace foodgroup5 = 0 if y1_c1_04_2 == .
drop y1_c1_04_2
replace foodgroup6 = -1 if y1_c1_04_3 != 7
replace foodgroup6 = 0 if y1_c1_04_3 == .
drop y1_c1_04_3
foreach i in y1_c1_05 y1_c1_13a_1 y1_c1_13b_1 y1_c1_13c_1 y1_c1_13d_1 y1_c1_13e_1 y1_c1_13f_1 y1_c1_13g_1 y1_c1_14_1 y1_c1_15a_1 y1_c1_15b_1 y1_c1_15c_1 y1_c1_15d_1 y1_c1_15e_1 y1_c1_15f_1 y1_c1_15g_1 y1_c1_15h_1 y1_c1_15i_1 y1_c1_15j_1 y1_c1_15k_1 y1_c1_15l_1 y1_c1_15m_1 y1_c1_15n_1 y1_c1_15o_1 y1_c1_15p_1 y1_c1_15q_1 y1_c1_15r_1 y1_c1_15s_1 y1_c1_15t_1 y1_c1_15u_1 y1_c1_15v_1 y1_c1_15w_1 y1_c1_15v1_1 y1_c1_15w1_1 y1_c1_15x_1 y1_c1_15y_1{
	replace `i' = 0 if 
		}
replace foodgroup3 = 0 if inlist(y1_c1_03d3, 7, .)
replace foodgroup4 = 0 if inlist(y1_c1_04_1, 7, .)
replace foodgroup5 = 0 if inlist(y1_c1_04_2, 7, .)
replace foodgroup6 = 0 if inlist(y1_c1_04_3, 7, .)
forvalues j = 1/37 {
	generate foodgroup`j'= 0
}
foreach i in y1_c1_05 y1_c1_13a_1 y1_c1_13b_1 y1_c1_13c_1 y1_c1_13d_1 y1_c1_13e_1 y1_c1_13f_1 y1_c1_13g_1 y1_c1_14_1 y1_c1_15a_1 y1_c1_15b_1 y1_c1_15c_1 y1_c1_15d_1 y1_c1_15e_1 y1_c1_15f_1 y1_c1_15g_1 y1_c1_15h_1 y1_c1_15i_1 y1_c1_15j_1 y1_c1_15k_1 y1_c1_15l_1 y1_c1_15m_1 y1_c1_15n_1 y1_c1_15o_1 y1_c1_15p_1 y1_c1_15q_1 y1_c1_15r_1 y1_c1_15s_1 y1_c1_15t_1 y1_c1_15u_1 y1_c1_15v_1 y1_c1_15w_1 y1_c1_15v1_1 y1_c1_15w1_1 y1_c1_15x_1 y1_c1_15y_1 {
	label drop `i'
		}
foreach i in y1_c1_05 y1_c1_13a_1 y1_c1_13c_1 y1_c1_14_1 y1_c1_15v1_1 y1_c1_15w1_1 {
	replace `i' = 0 if `i' == 2
}	
foreach i in y1_c1_13b_1 y1_c1_13d_1 y1_c1_13e_1 y1_c1_13f_1 y1_c1_13g_1 y1_c1_15a_1 y1_c1_15b_1 y1_c1_15c_1 y1_c1_15d_1 y1_c1_15e_1 y1_c1_15f_1 y1_c1_15g_1 y1_c1_15h_1 y1_c1_15i_1 y1_c1_15j_1 y1_c1_15k_1 y1_c1_15l_1 y1_c1_15m_1 y1_c1_15n_1 y1_c1_15o_1 y1_c1_15p_1 y1_c1_15q_1 y1_c1_15r_1 y1_c1_15s_1 y1_c1_15t_1 y1_c1_15u_1 y1_c1_15v_1 y1_c1_15w_1 y1_c1_15x_1 y1_c1_15y_1 {
		replace `i' = 0 if `i' == 1
		replace `i' = 1 if `i' == 2

}
egen score = rowtotal(y1_c1_05 y1_c1_13a_1 y1_c1_13b_1 y1_c1_13c_1 y1_c1_13d_1 y1_c1_13e_1 y1_c1_13f_1 y1_c1_13g_1 y1_c1_14_1 y1_c1_15a_1 y1_c1_15b_1 y1_c1_15c_1 y1_c1_15d_1 y1_c1_15e_1 y1_c1_15f_1 y1_c1_15g_1 y1_c1_15h_1 y1_c1_15i_1 y1_c1_15j_1 y1_c1_15k_1 y1_c1_15l_1 y1_c1_15m_1 y1_c1_15n_1 y1_c1_15o_1 y1_c1_15p_1 y1_c1_15q_1 y1_c1_15r_1 y1_c1_15s_1 y1_c1_15t_1 y1_c1_15u_1 y1_c1_15v_1 y1_c1_15w_1 y1_c1_15v1_1 y1_c1_15w1_1 y1_c1_15x_1 y1_c1_15y_1 earlybf)

decode x1_05, gen(foodString) 

label drop x1_05
duplicates drop a01 x1_05, force
rename x1_07* (=_)
reshape wide x1_07 x1_07_01 x1_07_02 x1_07_03, i(a01) j(x1_05)

//duplicates tag a01 x2_01 x2_08, generate(dup_hh)
//tab dup_hh
duplicates drop a01 x2_01 menucode, force
sort a01 x2_01
//drop dup_hh
reshape wide foodString, i(x2_01 a01) j(menucode)



     
