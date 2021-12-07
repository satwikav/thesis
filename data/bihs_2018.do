/////////HHH INFO
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
destring, replace
sort a01 res_id_a
keep a01 res_id_a div_name a13 a23 a24 a25 a26
save "/Users/satwikav/Documents/GitHub/thesis/data/1.dta",replace
/////////HH MEMBER INFO
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
destring, replace
keep a01 mid b1_01 b1_02 b1_03 b1_04 b1_04a b1_04b b1_07 b1_08 b1_09 b1_10 b1_11 b1_10_r3 b1_11_r3
sort a01 mid
save "/Users/satwikav/Documents/GitHub/thesis/data/2.dta",replace
/////////SCHOOLING
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/011_bihs_r3_male_mod_b2.dta", clear
keep a01 mid_b2 b2_01 b2_03 b2_04 b2_05 b2_06a b2_06b b2_08b b2_08c b2_08d b2_11
destring, replace
sort a01 mid_b2
save "/Users/satwikav/Documents/GitHub/thesis/data/3.dta",replace
/////////ASSETS-1 
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/015_bihs_r3_male_mod_d1.dta",clear
keep a01 res_id_d d1_02 d1_02oth d1_03 d1_04 d1_05 d1_06_a d1_06_b d1_06_c d1_07 d1_08 d1_09 d1_10 d1_11 d1_12
destring, replace
sort a01 d1_02
save "/Users/satwikav/Documents/GitHub/thesis/data/4.dta",replace
/////////ASSETS-2
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/016_bihs_r3_male_mod_d2.dta",clear
keep a01 d2_02 d2_03 d2_04 d2_05 d2_06_a d2_06_b d2_06_c d2_07 d2_08 d2_09 d2_10 d2_12
destring, replace
sort a01 d2_02
save "/Users/satwikav/Documents/GitHub/thesis/data/5.dta",replace
/////////SAVINGS
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/017_bihs_r3_male_mod_e.dta",clear
keep a01 e01 e02 mid_e e04 e05 e06 e07
destring, replace
sort a01 mid_e
save "/Users/satwikav/Documents/GitHub/thesis/data/6.dta",replace
/////////LOANS
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/018_bihs_r3_male_mod_f.dta", clear
keep a01 f01 f02 f02_a f02_b f02_c mid_f f04 f06_a f06_b f06_c f07 f08 f09 f10
destring, replace
sort a01 mid_f
save "/Users/satwikav/Documents/GitHub/thesis/data/7.dta",replace
/////////OPINION ON CHILD MARRIAGE
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/019_bihs_r3_male_mod_xxc.dta", clear
keep a01 xxc_01 xxc_02
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/8.dta",replace
/////////LAND OWNERSHIP
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/020_bihs_r3_male_mod_g.dta", clear 
keep a01 plotid g01 g02_1 g02 g20 g03 g06 g21 g08a g08b g08c g09a g09b g09c g11
sort a01 plotid
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/9.dta",replace
/////////LIVESTOCK
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/043_bihs_r3_male_mod_k1.dta",clear
keep a01 livestock k1_01 k1_04 k1_04a k1_05a k1_05b k1_05c
sort a01 livestock
keep if k1_04 != 0
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/10.dta",replace
/////////INCOME
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/012_bihs_r3_male_mod_c.dta",clear
keep a01 mid_c c05 c10 c11 c13 c14
sort a01 mid_c
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/11.dta",replace
replace c14 = 0 if c14 == .
collapse (sum) c14, by (a01 mid_c)
save "/Users/satwikav/Documents/GitHub/thesis/data/12.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/076_bihs_r3_male_mod_v4.dta", clear
keep a01 v4_01 v4_02 v4_03 v4_04 v4_05 v4_06 v4_07 v4_08 v4_09 v4_10 v4_11 v4_12
destring, replace
gen totalincome = v4_01+v4_02+v4_03+v4_04+v4_05+v4_06+v4_07+v4_08+v4_09+v4_10+v4_11+v4_12
save "/Users/satwikav/Documents/GitHub/thesis/data/19.dta",replace
/////////EXPENDITURE
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/061_bihs_r3_male_mod_p1.dta", clear
keep a01 p1_01 p1_02 p1_04
sort a01 p1_01
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/13.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/062_bihs_r3_male_mod_p2.dta", clear
keep a01 p2_01 p2_02 p2_03 p2_04 p2_05 p2_06 p2_07
sort a01 p2_01
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/14.dta",replace
/////////HOUSING
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/063_bihs_r3_male_mod_q.dta", clear
keep a01 q_01 q_10 q_11 q_11c q_12 q_13 q_20 q_20a q_20a_2 q_20b q_20b_2 q_20c q_20c_2
sort a01
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/15.dta",replace
/////////ACCESS
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/066_bihs_r3_male_mod_s.dta", clear
keep a01 s_01 s_02 s_04 s_05 s_06
sort a01 s_01
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/16.dta",replace
/////////MIGRATION
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/072_bihs_r3_male_mod_v1.dta", clear
keep a01 v1_01 pid_v1 mid_v1 v1_02 v1_03 v1_04 v1_05 v1_06 v1_07 v1_08 v1_12 v1_14
keep if v1_01 == 1
sort a01 mid_v1
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/17.dta",replace
/////////REMITTANCE
use "/Users/satwikav/Documents/GitHub/thesis/Satwika Bangladesh/Round3/BIHSRound3/Male/073_bihs_r3_male_mod_v2.dta", clear
keep a01 v2_01 pid_v2 mid_v2 v2_02 v2_05 v2_06 v2_11
keep if v2_01 == 1
sort a01 mid_v2
destring, replace
save "/Users/satwikav/Documents/GitHub/thesis/data/18.dta",replace
/////////havent looked at male responses for WEAI starting from mod 78


