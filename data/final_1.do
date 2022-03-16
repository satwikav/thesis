/************************
Household characteristics
- all the required variables at household level are first merged 
- Division code of the household
- Number of children less than 6 years in the HH to calculate siblings
- Number of members between 15-64 years and the HH size to calculate the dependency ratio
- Main occupation of the primary respondent to calculate if he is a trader or not
- Age and education of the primary respondent
- Plot operated by the household to calculate the log of land 
- monthly salary is used to calculate annual salary of the HH, annual remittances receieved by the HH,
annual income from other sources; They are summed and used to get the income tercile of the HH to 
classify if HH falls in richest or poorest tercile
- Sanitary practices by the HH are used to calculate: if water is piped, animal feces found around the HH,
toilet is sealed, child seen eating soil, garbage is disposed openly 
- Farm diveristy is calculated using the number of crop species the HH has grown 
- Distance to the near shop (in kms) from the HH
- Proportion of children between 6-17 years of age in the HH 
- Proportion of girl children between 6-17 years of age in the HH 
- Proportion of children between 6-17 years of age attending school in the HH 
- Annual expenditure of the HH on human resources
************************/
//Division code and siblings
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 dvcode a25 div_name
gen sibling = 1 if a25 > 1
replace sibling = 0 if a25 == 1 | a25 == 0
replace sibling = . if a25 == .
drop a25
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta", replace
//Dependency ratio
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
drop if b1_02 == .
gen dependents = 0
replace dependents = 1 if b1_02 < 15 | b1_02 > 64
replace dependents = . if b1_02 == .
gen hh_size = 0
replace hh_size = 1 if a01 != . & mid != .
collapse (sum) dep hh_size, by(a01)
gen dep_ratio = dependents / hh_size
drop dependents hh_size
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
//Main occupation, age and education of the primary respondent 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep if b1_03 == 1
gen trader_hhh = 0
replace trader_hhh = 1 if b1_10 == 50 | b1_10 == 51 | b1_10 == 52 | b1_10 == 53| b1_10 == 54
rename b1_02 age_hhh
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
keep a01 age_hhh edu_hhh trader_hhh 
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
//Log land operated by the HH
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/020_bihs_r3_male_mod_g.dta",clear
gen land=g02/100 
collapse (sum) land, by(a01) 
gen log_land = ln(land + 1)
keep a01 log_land
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
//Annual income recieved in the form of salaries by the HH
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/012_bihs_r3_male_mod_c.dta", clear
replace c14 = 0 if c14 == .
gen salary = c14 * 12
collapse (sum) salary, by(a01)
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
//Annual income recieved in the form of remittances by the HH
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/073_bihs_r3_male_mod_v2.dta", clear
replace v2_06 = 0 if v2_06 == .
collapse (sum) v2_06, by(a01)
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
//Annual income recieved from other sources by the HH 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/076_bihs_r3_male_mod_v4.dta", clear
egen other = rowtotal(v4_01-v4_12)
keep a01 other
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
//Calculating the richest and poorest terciles
use "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",clear
egen total_income = rowtotal(other v2_06 salary)
replace total_income = . if other == . & v2_06 == . & salary == .
xtile income_3 = total_income, nq(3)
gen poorest_tercile = 0
replace poorest_tercile = 1 if income_3 == 1
replace poorest_tercile = . if income_3 == .
gen richest_tercile = 0
replace richest_tercile = 1 if income_3 == 3
replace richest_tercile = . if income_3 == .
drop other v2_06 salary total_income income_3
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
//Sanitary practices of the HH
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/064_bihs_r3_male_mod_r.dta", clear
keep a01 r01 r05 r10 
gen sealed_toilet = 0
replace sealed_toilet = 1 if r01 == 4 | r01 == 5
drop r01
gen pipe_water = 0
replace pipe_water = 1 if r05 == 1 | r05 == 2 | r05 == 8
drop r05
gen open_garbage = 0
replace open_garbage = 1 if r10 == 6 | r10 == 7 | r10 == 8
drop r10
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta", replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/065_bihs_r3_male_mod_r2.dta", clear
keep a01 r2_01 r2_09 r2_10
gen eat_soil = 0
replace eat_soil = 1 if r2_01 == 1 | r2_01 == 1
gen animal_feces = 0
replace animal_feces = 1 if r2_09 == 1 | r2_10 == 1
keep a01 animal_feces eat_soil
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta", replace
//Farm Diversity of the HH
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/030_bihs_r3_male_mod_i1.dta", clear
keep a01 crop_a_i1 i1_01
rename i1_01 harvested
rename crop_a_i1 crop
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_2.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/034_bihs_r3_male_mod_i3.dta", clear
keep a01 i3_04 i3_03
rename i3_04 harvested
rename i3_03 crop
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/hh_2.dta"
collapse (sum) harvested, by (a01 crop)
gen FD = 1 if harvested > 0
replace FD = 0 if harvested == 0
collapse (sum) FD, by (a01)
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
//Distance to the nearest shop (in kms) from the HH
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/066_bihs_r3_male_mod_s.dta", clear
keep if s_01 == 6
keep a01 s_04 
rename s_04 dist_shop
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
//Proportion of children between 6-17 years of age in the HH 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep mid a01 b1_02 b1_03 b1_10 b1_08a b1_01 b1_04 b1_09
gen children = 0
replace children = 1 if b1_02 > 5 & b1_02 < 18
replace children = 0 if b1_03 == 1 | b1_03 == 2
collapse (sum) children, by(a01)
gen children_dummy = 0
replace children_dummy = 1 if children > 0
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta", replace
//Annual expenditure of the HH on human resources 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/062_bihs_r3_male_mod_p2.dta", clear
keep if inlist(p2_01, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 168, 172, 176, 210, 211, 212, 213, 218)
gen category = 1 if inlist(p2_01, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155)
replace category = 2 if inlist(p2_01, 168, 172)
replace category = 3 if inlist(p2_01, 176, 210, 211, 212, 213, 218)
collapse (sum) p2_03, by(a01 category)
reshape wide p2_03, i(a01) j(category)
rename p2_031 cost_edu
rename p2_032 cost_leisure
rename p2_033 cost_tech
egen inv = rowtotal(cost_edu cost_leisure cost_tech)
gen log_inv = ln(inv)
drop cost_edu cost_leisure cost_tech inv
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta", replace
/************************
WEAI 
- Female empowerment score is calculated in separate do file are merged here with 
other details pertaining them 
- Age if the female respondent
- Years of education of the female respondent
- Merge with household characteristics since only one woman per HH is surveyed for WEAI
************************/
//5DE score of women 
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta", clear
rename ci empw_female
rename mid mid_female
keep a01 empw_female mid_female
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_3.dta", replace
//Age of the women respondents
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_female
rename b1_02 age_female_resp
merge 1:1 a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/hh_3.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_3.dta", replace
//Years of education of the women respondents
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_08
gen edu_female_resp = b1_08
replace edu_female_resp = 0 if b1_08 == 66
replace edu_female_resp = 0 if b1_08 == 99
replace edu_female_resp = 9 if b1_08 == 22
replace edu_female_resp = 11 if b1_08 == 33
replace edu_female_resp = 12 if b1_08 == 75
replace edu_female_resp = 15 if b1_08 == 14
replace edu_female_resp = 16 if b1_08 == 15
replace edu_female_resp = 16 if b1_08 == 72
replace edu_female_resp = 16 if b1_08 == 73
replace edu_female_resp = 16 if b1_08 == 74
replace edu_female_resp = 17 if b1_08 == 16
replace edu_female_resp = 17 if b1_08 == 71
replace edu_female_resp = . if b1_08 == 67
replace edu_female_resp = . if b1_08 == 76
rename mid mid_female
merge 1:1 a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/hh_3.dta"
drop if _m == 1
drop _merge b1_08
//Merge with household characteristics
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
/************************
Anthropometric Scores   
- Anthropometric scores (HAZ, WAZ) of children between 0-59 months of age are 
merged with other details pertaining them 
- Age of the child
- Age sqaured of the child
- Gender of the child
- Age of child's mother
- Years of education of child's mother
- Height of the child's mother
************************/
//haz, waz, age, age2 of the child
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/100_bihs_r3_female_mod_w2.dta", clear
keep a01 mid_w2 w2_14 haz06 waz06 w2_01
rename w2_01 mid_mother
rename w2_14 age_child
gen age_2_child = age_child ^ 2
drop if mid_w2 == 99
rename mid_w2 mid_child
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_4.dta", replace
//gender of the child
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_01
rename mid mid_child
merge 1:1 a01 mid_child using "/Users/satwikav/Documents/GitHub/thesis/data/hh_4.dta"
keep if _m == 3
drop _m
gen girl_child = 1 if b1_01 == 2
replace girl_child = 0 if b1_01 == 1
drop b1_01
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_4.dta", replace
//Age and education of child's mother
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid b1_08
rename mid mid_mother
rename b1_02 age_mother
gen age_2_mother = age_mother ^ 2
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
drop b1_08
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/hh_4.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_4.dta", replace
//Height of child's mother (in cms)
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/099_bihs_r3_female_mod_w1.dta", clear
keep a01 mid_w1 w1_04
rename mid_w1 mid_mother
rename w1_04 height_mother
merge 1:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/hh_4.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_4.dta", replace
//Merge with hh data
use "/Users/satwikav/Documents/GitHub/thesis/data/hh_4.dta", clear 
merge m:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
/************************
Minimum Dietary Diversity Score  
- MDDS of children between 6-23 are calculated 
- MDDS of children between 25-59 are calculated
- They are merged with child level data 
************************/
//MDDS of children between 6-23 months
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/113_bihs_r3_female_mod_y1.dta", clear
keep a01 y1_c1_00 child_age_y1c1 child_id_y1c1 y1_c1_03b1 y1_c1_11 y1_c1_12 y1_c1_13a_1 y1_c1_13b_1 y1_c1_13c_1 y1_c1_13d_1 y1_c1_13e_1 y1_c1_13f_1 y1_c1_13g_1 y1_c1_14_1 y1_c1_15a_1 y1_c1_15b_1 y1_c1_15c_1 y1_c1_15d_1 y1_c1_15e_1 y1_c1_15f_1 y1_c1_15g_1 y1_c1_15h_1 y1_c1_15i_1 y1_c1_15j_1 y1_c1_15k_1 y1_c1_15l_1 y1_c1_15m_1 y1_c1_15n_1 y1_c1_15o_1 y1_c1_15p_1 y1_c1_15q_1 y1_c1_15r_1 y1_c1_15s_1 y1_c1_15t_1 y1_c1_15u_1 y1_c1_15v_1 y1_c1_15w_1 y1_c1_15v1_1 y1_c1_15w1_1 y1_c1_15x_1 y1_c1_15y_1 mot_id_y1c1
drop if y1_c1_00 == 2
drop y1_c1_00
rename child_age_y1c1 age_child
rename child_id_y1c1 mid_child
rename mot_id_y1c1 mid_mother
rename y1_c1* y1* 
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_5.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/113_bihs_r3_female_mod_y1.dta", clear
keep a01 child_id_y1c2 y1_c1_00 child_age_y1c2 y1_c2_03b1 y1_c2_11 y1_c2_12 y1_c2_13a_1 y1_c2_13b_1 y1_c2_13c_1 y1_c2_13d_1 y1_c2_13e_1 y1_c2_13f_1 y1_c2_13g_1 y1_c2_14_1 y1_c2_15a_1 y1_c2_15b_1 y1_c2_15c_1 y1_c2_15d_1 y1_c2_15e_1 y1_c2_15f_1 y1_c2_15g_1 y1_c2_15h_1 y1_c2_15i_1 y1_c2_15j_1 y1_c2_15k_1 y1_c2_15l_1 y1_c2_15m_1 y1_c2_15n_1 y1_c2_15o_1 y1_c2_15p_1 y1_c2_15q_1 y1_c2_15r_1 y1_c2_15s_1 y1_c2_15t_1 y1_c2_15u_1 y1_c2_15v_1 y1_c2_15w_1 y1_c2_15v1_1 y1_c2_15w1_1 y1_c2_15x_1 y1_c2_15y_1 mot_id_y1c2
drop if y1_c1_00 == 2
drop y1_c1_00
drop if child_id_y1c2 == 0 | child_id_y1c2 == .
rename child_age_y1c2 age_child
rename child_id_y1c2 mid_child
rename mot_id_y1c2 mid_mother
rename y1_c2* y1* 
append using "/Users/satwikav/Documents/GitHub/thesis/data/hh_5.dta"
drop if age_child < 6
forvalues j = 1/8 {
	generate foodgroup`j'= 0 
}
replace foodgroup1 = 1 if y1_15a_1 == 1 | y1_15b_1 == 1 | y1_15g_1 == 1
replace foodgroup1 = . if y1_15a_1 == . & y1_15b_1 == . & y1_15g_1 == .
replace foodgroup2 = 1 if y1_15d_1 == 1 | y1_15p_1 == 1 
replace foodgroup2 = . if y1_15d_1 == . & y1_15p_1 == .
replace foodgroup3 = 1 if y1_13d_1 == 1 | y1_15q_1 == 1 | y1_15r_1 == 1 | y1_15c_1 == 1 | y1_13c_1 == 1
replace foodgroup3 = . if y1_13d_1 == . & y1_15q_1 == . & y1_15r_1 == . & y1_15c_1 == . & y1_13c_1 == .
replace foodgroup4 = 1 if y1_15k_1 == 1 | y1_15l_1 == 1 | y1_15m_1 == 1 | y1_15n_1 == 1 
replace foodgroup4 = . if y1_15k_1 == . & y1_15l_1 == . & y1_15m_1 == . & y1_15n_1 == .
replace foodgroup5 = 1 if y1_15o_1 == 1
replace foodgroup5 = . if y1_15o_1 == .
replace foodgroup6 = 1 if y1_15e_1 == 1 | y1_15f_1 == 1 | y1_15h_1 == 1
replace foodgroup6 = . if y1_15e_1 == . & y1_15f_1 == . & y1_15h_1 == .
replace foodgroup7 = 1 if y1_15i_1 == 1 | y1_15j_1 == 1 
replace foodgroup7 = . if y1_15i_1 == . & y1_15j_1 == . 
replace foodgroup8 = 1 if y1_13a_1 == 1 
replace foodgroup8 = . if y1_13a_1 == . 
egen DD_1 = rowtotal(foodgroup1 -foodgroup8)
replace DD_1 = . if foodgroup1 == . & foodgroup2 == . & foodgroup3 == . & foodgroup4 == . & foodgroup5 == . & foodgroup6 == . & foodgroup7 == . & foodgroup8 == . 
keep DD_1 a01 age_child mid_child mid_mother
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_5.dta",replace
//Merge with main data 
use "/Users/satwikav/Documents/GitHub/thesis/data/hh_5.dta", clear 
merge 1:1 a01 mid_child mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
//MDDS of children between 24-59 months
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/105_bihs_r3_female_mod_x1.dta",clear
bys a01 x1_01 x1_dd x1_mm x1_yy rid_x1 x1_02 x1_03 x1_05 x1_09: gen dup=_n
rename x1_07_0*   x1_07_*
rename x1_07 x1_07_0
reshape long x1_07_ , i(a01 x1_01 x1_dd x1_mm x1_yy x1_02 x1_03 x1_05 x1_09 dup) j(ix)
rename x1_07_ ingred
keep if ingred!=.
keep a01 x1_05 ingred 
tab ingred
generate foodgroup1=1 if (ingred>=1 & ingred<=15) | ingred==61 | ingred==76 | ingred==323 | ingred==621 | ingred==901 | ingred==55 | ingred==59 | ingred==284 | ingred==282 | ingred==295 | ingred==296 | ingred==297
generate foodgroup2=1 if (ingred>=21 & ingred<=28) | ingred==270 | ingred==298 | ingred==299 | ingred==301 | ingred==902 | ingred==31 | ingred==259
generate foodgroup3=1 if (ingred>=132 & ingred<=135) | ingred==294 | ingred==34 | ingred==16
generate foodgroup4=1 if (ingred>=121 & ingred<=128)| ingred==131| (ingred>=176 & ingred<=205)|(ingred>=211 & ingred<=223)|(ingred>=225 & ingred<=236)|(ingred>=238 & ingred<=243)| ingred==322| ingred==906| ingred==908| ingred==909
generate foodgroup5=1 if ingred==130
generate foodgroup6=1 if ingred==46 | ingred==52 |ingred==56 |  ingred==60 | ingred==67 | ingred==68 | (ingred>=86 & ingred<=88) | ingred==91 |(ingred>=93 & ingred<=101)|(ingred>=103 & ingred<=107) | ingred==141 | ingred==143| ingred==622 | ingred==905 | (ingred>=109 & ingred<=115)
generate foodgroup7=1 if (ingred>=41 & ingred<=45) | (ingred>=47 & ingred<=51) | ingred==53 | ingred==54 | ingred==57 | ingred==58 | (ingred>=63 & ingred<=66) | (ingred>=69 & ingred<=75) | (ingred>=77 & ingred<=82)| ingred==89| ingred==90| ingred==92| ingred==142| (ingred>=144 & ingred<=147) | (ingred>=149 & ingred<=169) |(ingred>=317 & ingred<=320)| ingred==904|  ingred==907 | ingred==102|  ingred==254|  ingred==255|  ingred==292|  ingred==300
collapse (mean) foodgroup1-foodgroup7, by (a01 x1_05)
rename x1_05 menu
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_6.dta",replace 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/106_bihs_r3_female_mod_x2.dta",clear
rename x2_08 menu
merge m:1 a01 menu using "/Users/satwikav/Documents/GitHub/thesis/data/hh_6.dta"
keep a01 menu x2_01 foodgroup1-foodgroup7
sort a01 x2_01
egen check = rsum (foodgroup1-foodgroup7)
tab menu if check==0 & menu!=.  // curd,Bharta 1,Bharta 4 are not categorised
tab a01 if check==0 & menu==294 //checking which hh have curd missing
replace foodgroup3=1 if a01== 235 & menu==294
tab a01 if check==0 & menu==2871 //checking which hh have bharta 1 missing
//hh 3870 bharta 1 dont fall in food groups
tab a01 if check==0 & menu==2874 //checking which hh have bharta 4 missing
//hh 3685 bharta 4 dont fall in food groups
drop check
collapse (mean) foodgroup1-foodgroup7, by (a01 x2_01)
egen DD_2 =rsum(foodgroup1-foodgroup7)
replace DD_2 = . if foodgroup1 == . & foodgroup2 == . & foodgroup3 == . & foodgroup4 == . & foodgroup5 == . & foodgroup6 == . & foodgroup7 == . 
keep if x2_01<100
rename x2_01 mid_child
keep a01 mid_child DD_2
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_6.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/100_bihs_r3_female_mod_w2.dta", clear
keep a01 mid_w2 w2_14 w2_11 w2_01
drop if mid_w2 == 99
rename mid_w2 mid_child
rename w2_01 mid_mother
rename w2_14 age_child
keep if age_child > 23
merge 1:1 a01 mid_child using "/Users/satwikav/Documents/GitHub/thesis/data/hh_6.dta"
keep if _m == 3
drop _m
replace DD_2 = DD_2 + 1 if w2_11 == 1
replace DD_2 = 1 if w2_11 == 1 & DD_2 == .
drop w2_11
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_6.dta",replace 
//Merge with main data 
use "/Users/satwikav/Documents/GitHub/thesis/data/hh_6.dta", clear 
merge 1:1 a01 mid_child mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
//Creating MDDS for child 6-59 months
use "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta", clear
gen MDDS = DD_1
replace MDDS = DD_2 if DD_1 == .
drop DD_1 DD_2
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
/************************
Instrumental Variables 
- Calculate the freedom of mobility
- Calculate the choice in marriage
- Merge with main data 
************************/
//freedom of mobility
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/121_bihs_r3_female_mod_z1.dta", clear
keep a01 res_id_z12
rename res_id_z12 mid_female
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/122_bihs_r3_female_mod_z2.dta"
keep a01 z2_01_1 z2_02_1 z2_03_1 z2_04_1 z2_05_1 mid_female
forvalues j = 1/5 {
	generate mobility_`j'= 0 
	replace mobility_`j'= 1 if z2_0`j'_1 == 1
	replace mobility_`j'= 0.5 if z2_0`j'_1 == 3
	replace mobility_`j'= . if z2_0`j'_1 == .
}
egen mobility_score = rowtotal(mobility_1-mobility_5)
forvalues j = 1/5 {
	replace mobility_score = . if z2_0`j'_1 == .
}
gen mobility = mobility_score/5
keep a01 mobility mid_female
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_7.dta", replace
//marriage decision 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/126_bihs_r3_female_weai_ind_mod_wa.dta", clear
keep a01 wa04 
rename wa04 mid_female
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/138_bihs_r3_female_weai_ind_mod_we7b.dta"
keep a01 we7b_15 mid_female
gen marr_choice = 0
replace marr_choice = 1 if we7b_15 == 1 | we7b_15 == 2
replace marr_choice = 0.5 if we7b_15 == 3 | we7b_15 == 5
replace marr_choice = . if we7b_15 == .
keep a01 marr_choice mid_female
merge 1:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/hh_7.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/hh_7.dta", replace
//Merge with main data 
use "/Users/satwikav/Documents/GitHub/thesis/data/hh_7.dta", clear 
merge 1:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",replace
/************************
Regressions
************************/
use "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",clear

est clear  // clear the stored estimates
eststo: quietly reg haz06 empw_female age_child age_2_child girl_child sibling age_mother height_mother edu_mother dep_ratio log_land trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage poorest_tercile richest_tercile i.dvcode age_2_mother, vce(robust)
eststo: quietly ivreg2 haz06 age_child age_2_child girl_child sibling age_mother height_mother edu_mother dep_ratio log_land trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage poorest_tercile richest_tercile i.dvcode age_2_mother (empw_female = mobility marr_choice),robust endog (empw_female)
eststo: quietly reg waz06 empw_female age_child age_2_child girl_child sibling age_mother height_mother edu_mother dep_ratio log_land trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage poorest_tercile richest_tercile  i.dvcode age_2_mother, vce(robust)
eststo: quietly ivreg2 waz06 age_child age_2_child girl_child sibling age_mother height_mother edu_mother dep_ratio log_land trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage poorest_tercile richest_tercile i.dvcode age_2_mother (empw_female = mobility marr_choice),robust endog (empw_female)
esttab, stat(N widstat jp estatp, labels("N" "Weak identification" "Over identification" "Endogenity")) b(2) se(2) ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress

est clear  // clear the stored estimates
eststo: quietly reg MDDS empw_female age_child girl_child sibling age_female_resp edu_female_resp dep_ratio log_land trader_hhh dist_shop FD poorest_tercile richest_tercile i.dvcode age_2_mother age_2_child, vce(robust)
eststo: quietly ivreg2 MDDS age_child girl_child sibling age_2_child age_female_resp edu_female_resp dep_ratio log_land trader_hhh dist_shop FD poorest_tercile richest_tercile i.dvcode age_2_mother (empw_female = mobility marr_choice),robust endog (empw_female)
esttab, stat(N widstat jp estatp, labels("N" "Weak identification" "Over identification" "Endogenity")) b(2) se(2) ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress

est clear  
eststo: quietly reg log_inv empw_female children_dummy age_hhh edu_hhh trader_hhh dep_ratio log_land poorest_tercile richest_tercile i.dvcode, vce(robust)
eststo: quietly ivreg2 log_inv children_dummy age_hhh edu_hhh trader_hhh dep_ratio log_land poorest_tercile richest_tercile i.dvcode (empw_female = mobility marr_choice),robust endog (empw_female)
eststo: quietly reg log_inv empw_female children_dummy c.empw_female#children_dummy age_hhh edu_hhh trader_hhh dep_ratio log_land poorest_tercile richest_tercile i.dvcode, vce(robust)
eststo: quietly ivreg2 log_inv children_dummy c.empw_female#children_dummy age_hhh edu_hhh trader_hhh dep_ratio log_land poorest_tercile richest_tercile i.dvcode (empw_female c.empw_female#children_dummy = mobility marr_choice),robust endog (empw_female c.empw_female#children_dummy)
esttab, stat(N widstat jp estatp, labels("N" "Weak identification" "Over identification" "Endogenity")) b(2) se(2) ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress

/*remove prop girls
est clear  
eststo: quietly reg log_inv empw_female girl_child_hh prop_school_child children age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh dep_ratio log_land poorest_tercile richest_tercile i.dvcode, vce(robust)
eststo: quietly ivreg2 log_inv girl_child_hh prop_school_child children age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh dep_ratio log_land poorest_tercile richest_tercile i.dvcode (empw_female = mobility marr_choice),robust endog (empw_female)
esttab, stat(N widstat jp estatp, labels("N" "Weak identification" "Over identification" "Endogenity")) b(2) se(2) ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress

/************************
Magnitudes
************************/
use "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",clear

gen ln_empw = ln(empw_female)
gen ln_mdds= ln(MDDS)
egen z_empw = std(empw_female)
egen z_haz = std(haz06)
egen z_waz = std(waz06)

est clear  // clear the stored estimates
eststo: quietly reg z_haz z_empw age_child age_2_child girl_child sibling age_mother height_mother edu_mother dep_ratio log_land trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage poorest_tercile richest_tercile i.dvcode age_2_mother
eststo: quietly reg z_waz z_empw age_child age_2_child girl_child sibling age_mother height_mother edu_mother dep_ratio log_land trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage poorest_tercile richest_tercile  i.dvcode age_2_mother
eststo: quietly ivreg2 z_haz age_child age_2_child girl_child sibling age_mother height_mother edu_mother dep_ratio log_land trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage poorest_tercile richest_tercile i.dvcode age_2_mother (z_empw = mobility marr_choice), endog (z_empw)
eststo: quietly ivreg2 z_waz age_child age_2_child girl_child sibling age_mother height_mother edu_mother dep_ratio log_land trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage poorest_tercile richest_tercile i.dvcode age_2_mother (z_empw = mobility marr_choice), endog (z_empw)
esttab, stat(N idstat widstat sarganp estatp, labels("N" "Underidentification" "Weak identification" "Over identification" "Endogenity")) b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress

est clear  // clear the stored estimates
eststo: quietly reg ln_mdds ln_empw age_child girl_child sibling age_female_resp edu_female_resp dep_ratio log_land trader_hhh dist_shop FD poorest_tercile richest_tercile i.dvcode age_2_mother age_2_child
eststo: quietly ivreg2 ln_mdds age_child girl_child sibling age_2_child age_female_resp edu_female_resp dep_ratio log_land trader_hhh dist_shop FD poorest_tercile richest_tercile i.dvcode age_2_mother (ln_empw = mobility marr_choice), endog (ln_empw)
esttab, stat(N idstat widstat sarganp estatp, labels("N" "Underidentification" "Weak identification" "Over identification" "Endogenity")) b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
  
est clear  
eststo: quietly reg log_inv ln_empw prop_girl_child prop_school_child children age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh dep_ratio log_land poorest_tercile richest_tercile i.dvcode
eststo: quietly ivreg2 log_inv prop_girl_child prop_school_child children age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh dep_ratio log_land poorest_tercile richest_tercile i.dvcode (ln_empw = mobility marr_choice), endog (ln_empw)
esttab, stat(N idstat widstat sarganp estatp, labels("N" "Underidentification" "Weak identification" "Over identification" "Endogenity")) b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress

/************************
Interaction Regressions
************************/
use "/Users/satwikav/Documents/GitHub/thesis/data/bihs_vysetty.dta",clear

est clear  // clear the stored estimates
eststo: quietly reg haz06 empw_female girl_child c.empw_female#girl_child age_child age_2_child  sibling age_mother height_mother edu_mother dep_ratio log_land trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage poorest_tercile richest_tercile i.dvcode age_2_mother, vce(robust)
eststo: quietly ivreg2 haz06 age_child c.empw_female#girl_child age_2_child girl_child sibling age_mother height_mother edu_mother dep_ratio log_land trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage poorest_tercile richest_tercile i.dvcode age_2_mother (empw_female = mobility marr_choice),robust endog (empw_female)
eststo: quietly reg waz06 empw_female c.empw_female#girl_child age_child age_2_child girl_child sibling age_mother height_mother edu_mother dep_ratio log_land trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage poorest_tercile richest_tercile  i.dvcode age_2_mother, vce(robust)
eststo: quietly ivreg2 waz06 c.empw_female#girl_child age_child age_2_child girl_child sibling age_mother height_mother edu_mother dep_ratio log_land trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage poorest_tercile richest_tercile i.dvcode age_2_mother (empw_female = mobility marr_choice),robust endog (empw_female)
esttab, stat(N widstat jp estatp, labels("N" "Weak identification" "Over identification" "Endogenity")) b(2) se(2) ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress

est clear  // clear the stored estimates
eststo: quietly reg MDDS c.empw_female#girl_child empw_female age_child girl_child sibling age_female_resp edu_female_resp dep_ratio log_land trader_hhh dist_shop FD poorest_tercile richest_tercile i.dvcode age_2_mother age_2_child, vce(robust)
eststo: quietly ivreg2 MDDS c.empw_female#girl_child age_child girl_child sibling age_2_child age_female_resp edu_female_resp dep_ratio log_land trader_hhh dist_shop FD poorest_tercile richest_tercile i.dvcode age_2_mother (empw_female = mobility marr_choice),robust endog (empw_female)
esttab, stat(N widstat jp estatp, labels("N" "Weak identification" "Over identification" "Endogenity")) b(2) se(2) ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
  
//remove prop girls
est clear  
eststo: quietly reg log_inv empw_female girl_child_hh c.empw_female#girl_child_hh prop_school_child children age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh dep_ratio log_land poorest_tercile richest_tercile i.dvcode, vce(robust)
eststo: quietly ivreg2 log_inv c.empw_female#girl_child_hh girl_child_hh prop_school_child children age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh dep_ratio log_land poorest_tercile richest_tercile i.dvcode (empw_female = mobility marr_choice),robust endog (empw_female)
esttab, stat(N widstat jp estatp, labels("N" "Weak identification" "Over identification" "Endogenity")) b(2) se(2) ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress */
