************************************************************************
//DATASET FOR ANTHROPOMETRY, DD FOR 6-23, DD FOR 24-59, CONTROLS 
************************************************************************
/*haz,waz
- retain child z score, age,mother id
- calculate child's age square
- drop if child < 5 years is absent in hh*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/100_bihs_r3_female_mod_w2.dta", clear
keep a01 mid_w2 w2_14 haz06 waz06 w2_01
rename w2_01 mid_mother
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
rename ci empw_female
rename mid mid_female
keep a01 empw_female mid_female
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m
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
/*Household's location
- get hh location and size from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 dvcode a23
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
keep a01 age_hhh edu_hhh trader_hhh farmer_hhh
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
drop dependents hh_size
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
drop _merge land
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
drop total_income
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/*physical or verbal abuse in last 12 months
- if the wiea respondent was abused*/
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
/*Santiary practices
- sealed toilet = 1 if water sealed
- pipe water = 1 if water is piped and not from tubewell
- open garbage = 1 if garbage is openly discarded and not in a pit
- eat soil = 1 if child is observed to be eating soil
- animal feces = 1 if there are animal or poultry feces lying around the house*/
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta", replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/065_bihs_r3_male_mod_r2.dta", clear
keep a01 r2_01 r2_09 r2_10
gen eat_soil = 1
replace eat_soil = 0 if r2_01 == 3
replace eat_soil = . if r2_01 == 4
gen animal_feces = 0
replace animal_feces = 1 if r2_09 == 1 | r2_10 == 1
keep a01 animal_feces eat_soil
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta", replace
/*sibling
- Number of children less than 6 years old in a house (a25)
- If more than 1 child, they have siblings*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 a25
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
gen sibling = 1 if a25 > 1
replace sibling = 0 if a25 == 1 
drop _m a25
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
/*Farm diversity: Number of crop species including vegetables and fruits produced by the household in the last year*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/030_bihs_r3_male_mod_i1.dta", clear
keep a01 crop_a_i1 i1_01
rename i1_01 harvested
rename crop_a_i1 crop
save "/Users/satwikav/Documents/GitHub/thesis/data/farmD.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/034_bihs_r3_male_mod_i3.dta", clear
keep a01 i3_04 i3_03
rename i3_04 harvested
rename i3_03 crop
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/farmD.dta"
collapse (sum) harvested, by (a01 crop)
gen FD = 1 if harvested > 0
replace FD = 0 if harvested == 0
collapse (sum) FD, by (a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/* OUTCOME - Nutrition for 6-23 month olds
- Calculating diteary diversity for 6-23 month olds
Group 1: grains, roots, tuber
Group 2: legumes and nuts
Group 3: dairy
Group 4: flesh 
Group 5: eggs
Group 6: vit A rich fruits and veggies
Group 7: other fruits and veggies
Group 8: breastmilk 
*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/113_bihs_r3_female_mod_y1.dta", clear
keep a01 y1_c1_00 child_age_y1c1 child_id_y1c1 y1_c1_03b1 y1_c1_11 y1_c1_12 y1_c1_13a_1 y1_c1_13b_1 y1_c1_13c_1 y1_c1_13d_1 y1_c1_13e_1 y1_c1_13f_1 y1_c1_13g_1 y1_c1_14_1 y1_c1_15a_1 y1_c1_15b_1 y1_c1_15c_1 y1_c1_15d_1 y1_c1_15e_1 y1_c1_15f_1 y1_c1_15g_1 y1_c1_15h_1 y1_c1_15i_1 y1_c1_15j_1 y1_c1_15k_1 y1_c1_15l_1 y1_c1_15m_1 y1_c1_15n_1 y1_c1_15o_1 y1_c1_15p_1 y1_c1_15q_1 y1_c1_15r_1 y1_c1_15s_1 y1_c1_15t_1 y1_c1_15u_1 y1_c1_15v_1 y1_c1_15w_1 y1_c1_15v1_1 y1_c1_15w1_1 y1_c1_15x_1 y1_c1_15y_1 mot_id_y1c1
drop if y1_c1_00 == 2
drop y1_c1_00
rename child_age_y1c1 age_child
rename child_id_y1c1 mid_child
rename mot_id_y1c1 mid_mother
rename y1_c1* y1* 
save "/Users/satwikav/Documents/GitHub/thesis/data/child1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/113_bihs_r3_female_mod_y1.dta", clear
keep a01 child_id_y1c2 y1_c1_00 child_age_y1c2 y1_c2_03b1 y1_c2_11 y1_c2_12 y1_c2_13a_1 y1_c2_13b_1 y1_c2_13c_1 y1_c2_13d_1 y1_c2_13e_1 y1_c2_13f_1 y1_c2_13g_1 y1_c2_14_1 y1_c2_15a_1 y1_c2_15b_1 y1_c2_15c_1 y1_c2_15d_1 y1_c2_15e_1 y1_c2_15f_1 y1_c2_15g_1 y1_c2_15h_1 y1_c2_15i_1 y1_c2_15j_1 y1_c2_15k_1 y1_c2_15l_1 y1_c2_15m_1 y1_c2_15n_1 y1_c2_15o_1 y1_c2_15p_1 y1_c2_15q_1 y1_c2_15r_1 y1_c2_15s_1 y1_c2_15t_1 y1_c2_15u_1 y1_c2_15v_1 y1_c2_15w_1 y1_c2_15v1_1 y1_c2_15w1_1 y1_c2_15x_1 y1_c2_15y_1 mot_id_y1c2
drop if y1_c1_00 == 2
drop y1_c1_00
drop if child_id_y1c2 == 0 | child_id_y1c2 == .
rename child_age_y1c2 age_child
rename child_id_y1c2 mid_child
rename mot_id_y1c2 mid_mother
rename y1_c2* y1* 
append using "/Users/satwikav/Documents/GitHub/thesis/data/child1.dta"
save "/Users/satwikav/Documents/GitHub/thesis/data/child1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/data/child1.dta",clear
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
egen DD = rowtotal(foodgroup1 -foodgroup8)
replace DD = . if foodgroup1 == . & foodgroup2 == . & foodgroup3 == . & foodgroup4 == . & foodgroup5 == . & foodgroup6 == . & foodgroup7 == . & foodgroup8 == . 
keep DD a01 age_child mid_child mid_mother
save "/Users/satwikav/Documents/GitHub/thesis/data/child1.dta",replace
merge 1:1 a01 mid_child mid_mother age_child using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace
/* OUTCOME - Nutrition for 24-59 month olds
- Calculating diteary diversity for 24-59 month olds
Group 1: grains, roots, tuber
Group 2: legumes and nuts
Group 3: dairy
Group 4: flesh 
Group 5: eggs
Group 6: vit A rich fruits and veggies
Group 7: other fruits and veggies
Group 8: breastmilk 
*/
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
save "/Users/satwikav/Documents/GitHub/thesis/data/hhds.dta",replace 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/106_bihs_r3_female_mod_x2.dta",clear
rename x2_08 menu
merge m:1 a01 menu using "/Users/satwikav/Documents/GitHub/thesis/data/hhds.dta"
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
egen DD_7=rsum(foodgroup1-foodgroup7)
replace DD_7 = . if foodgroup1 == . & foodgroup2 == . & foodgroup3 == . & foodgroup4 == . & foodgroup5 == . & foodgroup6 == . & foodgroup7 == . 
keep if x2_01<100
rename x2_01 mid_child
keep a01 mid_child DD_7
save "/Users/satwikav/Documents/GitHub/thesis/data/hhds.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/100_bihs_r3_female_mod_w2.dta", clear
keep a01 mid_w2 w2_14 w2_11 w2_01
drop if mid_w2 == 99
rename mid_w2 mid_child
rename w2_01 mid_mother
rename w2_14 age_child
keep if age_child > 23
merge 1:1 a01 mid_child using "/Users/satwikav/Documents/GitHub/thesis/data/hhds.dta"
keep if _m == 3
drop _m
gen DD_1 = DD_7 
replace DD_1 = DD_7 + 1 if w2_11 == 1
replace DD_1 = 1 if w2_11 == 1 & DD_7 == .
drop DD_7 w2_11
save "/Users/satwikav/Documents/GitHub/thesis/data/hhds.dta",replace 
merge 1:1 a01 mid_child mid_mother age_child using "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",replace

************************************************************************
//Regression results for child nutrition and growth (0-59 months)
************************************************************************
use "/Users/satwikav/Documents/GitHub/thesis/data/controls.dta",clear
//main results regression 1 
est clear  // clear the stored estimates
eststo: quietly reg haz06 empw_female age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode
//main results regression 2
eststo: quietly reg waz06 empw_female age_child age_2_child girl_child sibling age_mother age_2_mother height_mother edu_mother abuse dep_ratio log_land edu_hhh age_hhh trader_hhh animal_feces pipe_water sealed_toilet eat_soil open_garbage i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress 
//merge DD for 6-59
gen DD_new = DD
replace DD_new = DD_1 if DD == .
//main results for regression 3
est clear  // clear the stored estimates
eststo: quietly reg DD empw_female age_2_child age_2_mother age_child girl_child age_mother age_hhh dep_ratio dist_shop edu_hhh edu_mother farmer_hhh log_land FD i.income_3 i.dvcode 
//main results for regression 4
eststo: quietly reg DD_1 empw_female age_child age_2_child girl_child age_2_mother age_mother age_hhh dep_ratio dist_shop  edu_hhh edu_mother farmer_hhh log_land FD i.income_3 i.dvcode 
//main results for regression 5
eststo: quietly reg DD_new empw_female age_child age_2_child girl_child age_2_mother age_mother age_hhh dep_ratio dist_shop  edu_hhh edu_mother farmer_hhh log_land FD i.income_3 i.dvcode 
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress 











