/////////HHH INFO
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 res_id_a div_name a13 a23 a24 a25 a26 a16_1_yy
rename res_id_a mid
save "/Users/satwikav/Documents/GitHub/thesis/data/1.dta",replace
/////////HH MEMBER INFO
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_01 b1_02 b1_03 b1_04 b1_04a b1_04b b1_07 b1_08 b1_09 b1_10
save "/Users/satwikav/Documents/GitHub/thesis/data/2.dta",replace
/////////OUTCOME - z scores for <5 year olds
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/100_bihs_r3_female_mod_w2.dta", clear
keep a01 mid_w2 w2_14 haz06 waz06 whz06 bmiz06
sort a01 mid_w2
rename mid_w2 mid
drop if mid == 99
save "/Users/satwikav/Documents/GitHub/thesis/data/3.dta",replace
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
egen child_DD = rowtotal(foodgroup1 -foodgroup8)
gen minDD = 0
replace minDD = 1 if child_DD >= 4
replace minDD = . if child_age_y1c1 < 6
replace y1_c1_12 = 0 if y1_c1_12 == 99
replace y1_c1_11 = 0 if y1_c1_11 == 99
gen minfrq = 0
gen totalfrq = y1_c1_12 + y1_c1_11
replace minfrq = 1 if y1_c1_13a_1 == 1 & child_age_y1c1 < 8 & y1_c1_12 >= 2
replace minfrq = 1 if y1_c1_13a_1 == 1 & child_age_y1c1 >= 8 & y1_c1_12 >= 3
replace minfrq = 1 if y1_c1_13a_1 == 2 & totalfrq >= 4	
replace minfrq = . if child_age_y1c1 < 6
keep a01 mid  earlybf exbf foodgroup1 -foodgroup10 child_DD minDD minfrq totalfrq
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
egen child_DD = rowtotal(foodgroup1 -foodgroup8)
gen minDD = 0
replace minDD = 1 if child_DD >= 4
replace minDD = . if child_age_y1c2 < 6
replace y1_c2_12 = 0 if y1_c2_12 == 99
replace y1_c2_11 = 0 if y1_c2_11 == 99
gen minfrq = 0
gen totalfrq = y1_c2_12 + y1_c2_11
replace minfrq = 1 if y1_c2_13a_1 == 1 & child_age_y1c2 < 8 & y1_c2_12 >= 2
replace minfrq = 1 if y1_c2_13a_1 == 1 & child_age_y1c2 >= 8 & y1_c2_12 >= 3
replace minfrq = 1 if y1_c2_13a_1 == 2 & totalfrq >= 4	
replace minfrq = . if child_age_y1c2 < 6
keep a01 mid earlybf exbf foodgroup1 - foodgroup10 child_DD minDD minfrq totalfrq
append using "/Users/satwikav/Documents/GitHub/thesis/data/child1.dta"
drop foodgroup1 foodgroup2 foodgroup3 foodgroup4 foodgroup5 foodgroup6 foodgroup7 foodgroup8 foodgroup9 foodgroup10
save "/Users/satwikav/Documents/GitHub/thesis/data/4.dta",replace //9 var, 925 obs
/////////OUTCOME - Nutrition for >2 year olds
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/105_bihs_r3_female_mod_x1.dta",clear
bys a01 x1_01 x1_dd x1_mm x1_yy rid_x1 x1_02 x1_03 x1_05 x1_09: gen dup=_n
rename x1_07_0*   x1_07_*
rename x1_07 x1_07_0
reshape long x1_07_ , i(a01 x1_01 x1_dd x1_mm x1_yy x1_02 x1_03 x1_05 x1_09 dup) j(ix)
rename x1_07_ ingred
keep if ingred!=.
keep a01 x1_05 ingred 
tab ingred
generate foodgroup1=1 if (ingred>=1 & ingred<=15) | ingred==61 | ingred==76 | ingred==323 | ingred==621 | ingred==901 | ingred==55 | ingred==59 | ingred==284
generate foodgroup2=1 if (ingred>=21 & ingred<=28) | ingred==270 | ingred==298 | ingred==299 | ingred==301 | ingred==902 | ingred==31 | ingred==259
generate foodgroup3=1 if (ingred>=132 & ingred<=135) | ingred==294 | ingred==34
generate foodgroup4=1 if (ingred>=121 & ingred<=128)| ingred==131| (ingred>=176 & ingred<=205)|(ingred>=211 & ingred<=223)|(ingred>=225 & ingred<=236)|(ingred>=238 & ingred<=243)| ingred==322| ingred==906| ingred==908| ingred==909
generate foodgroup5=1 if ingred==130
generate foodgroup6=1 if ingred==46 | ingred==52 |ingred==56 |  ingred==60 | ingred==67 | ingred==68 | (ingred>=86 & ingred<=88) | ingred==91 |(ingred>=93 & ingred<=101)|(ingred>=103 & ingred<=107) | ingred==141 | ingred==143| ingred==622 | ingred==905 | (ingred>=109 & ingred<=115)
generate foodgroup7=1 if (ingred>=41 & ingred<=45) | (ingred>=47 & ingred<=51) | ingred==53 | ingred==54 | ingred==57 | ingred==58 | (ingred>=63 & ingred<=66) | (ingred>=69 & ingred<=75) | (ingred>=77 & ingred<=82)| ingred==89| ingred==90| ingred==92| ingred==142| (ingred>=144 & ingred<=147) | (ingred>=149 & ingred<=169) |(ingred>=317 & ingred<=320)| ingred==904|  ingred==907 | ingred==102|  ingred==254|  ingred==255|  ingred==292|  ingred==300
generate foodgroup9=1 if  ingred==16|ingred==33 |ingred==35|ingred==36 | ingred==266| ingred>=273 & ingred<=275|ingred==282|ingred==283|ingred==285| ingred==286| ingred==293|ingred>=295 & ingred<=297|ingred>=302 & ingred<=312 | ingred==903| ingred==321
collapse (mean) foodgroup1-foodgroup9, by (a01 x1_05)
rename x1_05 menu
save "/Users/satwikav/Documents/GitHub/thesis/data/hhds.dta",replace 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/106_bihs_r3_female_mod_x2.dta",clear
rename x2_08 menu
merge m:1 a01 menu using "/Users/satwikav/Documents/GitHub/thesis/data/hhds.dta"
keep a01 menu x2_01 foodgroup1-foodgroup9
sort a01 x2_01
egen check = rsum (foodgroup1-foodgroup7)
tab menu if check==0 & menu!=.  // curd,Bharta 1,Bharta 4 are not categorised
tab a01 if check==0 & menu==294 //checking which hh have curd missing
replace foodgroup7=1 if a01== 235 & menu==294
tab a01 if check==0 & menu==2871 //checking which hh have bharta 1 missing
//hh 3870 bharta 1 dont fall in food groups
tab a01 if check==0 & menu==2874 //checking which hh have bharta 4 missing
//hh 3685 bharta 4 dont fall in food groups
drop check
collapse (mean) foodgroup1-foodgroup9, by (a01 x2_01)
egen DD=rsum(foodgroup1-foodgroup7)
foreach x of varlist foodgroup1-foodgroup9{
recode `x' .=0 if DD!=0 & DD!=.
}
keep if x2_01<100
rename x2_01 mid
drop foodgroup1 foodgroup2 foodgroup3 foodgroup4 foodgroup5 foodgroup6 foodgroup7 foodgroup9
save "/Users/satwikav/Documents/GitHub/thesis/data/5.dta",replace 
/////////OUTCOME - Assets
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/015_bihs_r3_male_mod_d1.dta", clear
drop if d1_03==2
collapse (sum) d1_03, by(a01)
save "/Users/satwikav/Documents/GitHub/thesis/data/assets.dta",replace 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/015_bihs_r3_male_mod_d1.dta", clear
bys a01 d1_02 res_id_d: gen dup=_n
rename d1_06_a d1_06_1
rename d1_06_b d1_06_2
rename d1_06_c d1_06_3
reshape long d1_06_, i(a01 d1_02 res_id_d dup) j(ix)
keep a01 d1_02 d1_06_ d1_03
drop if d1_06_ == 71 | d1_06_ == 72 | d1_06_ == 73 | d1_06_ == .
rename d1_06_ mid
rename d1_03 asset_
reshape wide asset_, i(a01 mid) j(d1_02)
egen assets_no = rsum (asset_1-asset_513)
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/assets.dta"
drop _merge
gen share_assets = assets_no/d1_03
drop asset_1-asset_513
save "/Users/satwikav/Documents/GitHub/thesis/data/6.dta",replace 
/////////OUTCOME - cost of Education
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/014_bihs_r3_male_mod_c3.dta", clear
keep a01 mid_c3 c3_08 c3_01
rename mid_c3 mid
keep if c3_01 == 1
replace c3_08 = 0 if c3_08 == .
save "/Users/satwikav/Documents/GitHub/thesis/data/cost_edu.dta",replace 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/011_bihs_r3_male_mod_b2.dta", clear
keep a01 mid_b2 b2_08 b2_08b 
keep if b2_08 == 1
rename mid_b2 mid
merge m:m a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/cost_edu.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/cost_edu.dta",replace 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/011_bihs_r3_male_mod_b2.dta", clear
keep a01 mid_b2 b2_08d b2_08c
keep if b2_08c == 1
rename mid_b2 mid
merge m:m a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/cost_edu.dta"
drop _merge
collapse (sum) b2_08d b2_08b c3_08, by(a01 mid)
egen cost_edu = rsum (b2_08d b2_08b c3_08)
save "/Users/satwikav/Documents/GitHub/thesis/data/7.dta",replace 
/////////OUTCOME - years of education
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_02 b1_08 
keep if b1_02 <= 17 & b1_02 >= 6
gen year_edu = b1_08
replace year_edu = 0 if b1_08 == 66
replace year_edu = 0 if b1_08 == 99
replace year_edu = 10 if b1_08 == 22
replace year_edu = 11 if b1_08 == 33
replace year_edu = . if b1_08 == 67
replace year_edu = . if b1_08 == 75
replace year_edu = . if b1_08 == 76
gen id = .
replace id = 1 if b1_02 == 6 | b1_02 == 7 | b1_02 == 8 | b1_02 == 9 | b1_02 == 10
replace id = 2 if b1_02 == 11 | b1_02 == 12 | b1_02 == 13 
replace id = 3 if b1_02 == 14 | b1_02 == 15 
replace id = 4 if b1_02 == 16 | b1_02 == 17
bysort id: egen avg_edu = mean(year_edu)
gen dev_edu = year_edu - avg_edu
keep a01 mid year_edu avg_edu dev_edu
save "/Users/satwikav/Documents/GitHub/thesis/data/8.dta",replace 
/////////OUTCOME - late enrollment 
/*gen diff = a16_1_yy - b2_03
gen enroll_age = b1_02 - diff
gen late_enroll = .
replace late_enroll = 0 if enroll_age <= 6 & enroll_age >= 4 
replace late_enroll = 1 if enroll_age > 6 
replace late_enroll = . if enroll_age == .
drop diff _merge*/
/////////MERGE
use "/Users/satwikav/Documents/GitHub/thesis/data/1.dta", clear
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/2.dta"
drop _merge
gsort a01 -div_name
quietly by a01 : replace div_name = div_name[_n-1] if div_name == ""
foreach j in a13 a23 a24 a25 a26 a16_1_yy {
	gsort a01 -`j'
	quietly by a01 : replace `j' = `j'[_n-1] if `j' == .
} 
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/3.dta"
drop _merge 
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/4.dta"
drop _merge 
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/5.dta"
drop _merge 
replace DD = child_DD if w2_14 <24
drop child_DD
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/6.dta"
drop _merge 
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/7.dta"
drop _merge 
merge m:m a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/8.dta"
drop _merge 
drop if mid == 99
merge 1:m a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/weai/5d_score.dta"
drop _merge 

save "/Users/satwikav/Documents/GitHub/thesis/data/dependent.dta",replace 
