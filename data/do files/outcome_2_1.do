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
generate foodgroup1=1 if (ingred>=1 & ingred<=15) | ingred==61 | ingred==76 | ingred==323 | ingred==621 | ingred==901 | ingred==55 | ingred==59 | ingred==284 | ingred==282 | ingred==295 | ingred==296 | ingred==297
generate foodgroup2=1 if (ingred>=21 & ingred<=28) | ingred==270 | ingred==298 | ingred==299 | ingred==301 | ingred==902 | ingred==31 | ingred==259
generate foodgroup3=1 if (ingred>=132 & ingred<=135) | ingred==294 | ingred==34 | ingred==16
generate foodgroup4=1 if (ingred>=121 & ingred<=128)| ingred==131| (ingred>=176 & ingred<=205)|(ingred>=211 & ingred<=223)|(ingred>=225 & ingred<=236)|(ingred>=238 & ingred<=243)| ingred==322| ingred==906| ingred==908| ingred==909
generate foodgroup5=1 if ingred==130
generate foodgroup6=1 if ingred==46 | ingred==52 |ingred==56 |  ingred==60 | ingred==67 | ingred==68 | (ingred>=86 & ingred<=88) | ingred==91 |(ingred>=93 & ingred<=101)|(ingred>=103 & ingred<=107) | ingred==141 | ingred==143| ingred==622 | ingred==905 | (ingred>=109 & ingred<=115)
generate foodgroup7=1 if (ingred>=41 & ingred<=45) | (ingred>=47 & ingred<=51) | ingred==53 | ingred==54 | ingred==57 | ingred==58 | (ingred>=63 & ingred<=66) | (ingred>=69 & ingred<=75) | (ingred>=77 & ingred<=82)| ingred==89| ingred==90| ingred==92| ingred==142| (ingred>=144 & ingred<=147) | (ingred>=149 & ingred<=169) |(ingred>=317 & ingred<=320)| ingred==904|  ingred==907 | ingred==102|  ingred==254|  ingred==255|  ingred==292|  ingred==300
collapse (mean) foodgroup1-foodgroup7, by (a01 x1_05)
rename x1_05 menu
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/hhds.dta",replace 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/106_bihs_r3_female_mod_x2.dta",clear
rename x2_08 menu
merge m:1 a01 menu using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/hhds.dta"
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
egen DD=rsum(foodgroup1-foodgroup7)
replace DD = . if foodgroup1 == . & foodgroup2 == . & foodgroup3 == . & foodgroup4 == . & foodgroup5 == . & foodgroup6 == . & foodgroup7 == . 
keep if x2_01<100
rename x2_01 mid
keep a01 mid DD
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/hhds.dta",replace 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_01 b1_02 b1_03 mid b1_09 b1_10
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/hhds.dta"
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace 
/*Female empowerment scores
- retain score, type of hh*/
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta"
rename ci empw_female
rename mid mid_female
keep a01 mid_female empw_female
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop _m
keep if b1_02 >= 5 & b1_02 < 18
drop if b1_03 == 1 | b1_03 == 2
keep if b1_10 == 81 | b1_10 == 84 | b1_10 == 86 | b1_10 == 99
drop b1_03 b1_09 b1_10
rename b1_01 gender_child
rename b1_02 age_child
rename mid mid_child
gen age_2_child = age_child ^ 2
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace 
/*Female respondent of WEIA age
- get age from hh info
- create if age square*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_female
rename b1_02 age_female
gen age_2_female = age_female ^ 2

merge 1:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta", replace
/*Female respondent's years of education
- get highest education from hh info
- calculate years of education depending on the highest class passed*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_08
gen edu_female = b1_08
replace edu_female = 0 if b1_08 == 66
replace edu_female = 0 if b1_08 == 99
replace edu_female = 9 if b1_08 == 22
replace edu_female = 11 if b1_08 == 33
replace edu_female = 12 if b1_08 == 75
replace edu_female = 15 if b1_08 == 14
replace edu_female = 16 if b1_08 == 15
replace edu_female = 16 if b1_08 == 72
replace edu_female = 16 if b1_08 == 73
replace edu_female = 16 if b1_08 == 74
replace edu_female = 17 if b1_08 == 16
replace edu_female = 17 if b1_08 == 71
replace edu_female = . if b1_08 == 67
replace edu_female = . if b1_08 == 76
rename mid mid_female
merge 1:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop if _m == 1
drop _merge b1_08
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace
/*Household's location
- get hh location and size from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 dvcode a23 community_id
rename a23 hh_size
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace
/*Household head information
- get hhh occupation,age,highest class passed from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep if b1_03 == 1
keep a01 b1_10 b1_02 b1_08 b1_03
rename b1_02 age_hhh
gen age_2_hhh = age_hhh ^ 2
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
keep a01 age_hhh farmer_hhh edu_hhh trader_hhh age_2_hhh
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace
/*Household dependency ratio
- get number of dependents (age less than 15 and greater than 64) in each household from from hh info
- divide the dependents by household size to the dependency ratio*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02
drop if b1_02 == .
gen dependents = 0
replace dependents = 1 if b1_02 < 15 | b1_02 > 64
collapse (sum) dep, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop if _m == 1
drop _m
gen dep_ratio = dependents / hh_size
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace
/* total income of the household - step 1 
- keep the montly income earned by the members
- obtain the yearly income earned by the members 
- collapse at hh level*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/012_bihs_r3_male_mod_c.dta", clear
replace c14 = 0 if c14 == .
gen salary = c14 * 12
collapse (sum) salary, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace
/* total income of the household - step 2
- keep the yearly remittances received by the members
- collapse at hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/073_bihs_r3_male_mod_v2.dta", clear
replace v2_06 = 0 if v2_06 == .
collapse (sum) v2_06, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace
/* total income of the household - step 3
- keep the yearly other incomes received by the households
- sum them at the hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/076_bihs_r3_male_mod_v4.dta", clear
egen other = rowtotal(v4_01-v4_12)
keep a01 other
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop if _m == 1
drop _m
egen total_income = rowtotal(other v2_06 salary)
drop other v2_06 salary
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace
/* income terciles
- calculate income terciles */
use "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",clear
xtile income_3 = total_income, nq(3)
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace
/* distance to local shops
- keep only if the facility is local shops
- merge the distance with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/066_bihs_r3_male_mod_s.dta", clear
keep if s_01 == 5 
keep a01 s_04 
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop if _m == 1
drop _m
rename s_04 dist_shop
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace
//Farm diversity: Number of crop species including vegetables and fruits produced by the household in the last year 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/030_bihs_r3_male_mod_i1.dta", clear
keep a01 crop_a_i1 i1_01
rename i1_01 harvested
rename crop_a_i1 crop
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/farmD.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/034_bihs_r3_male_mod_i3.dta", clear
keep a01 i3_04 i3_03
rename i3_04 harvested
rename i3_03 crop
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/farmD.dta"
collapse (sum) harvested, by (a01 crop)
gen FD = 1 if harvested > 0
replace FD = 0 if harvested == 0
collapse (sum) FD, by (a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace


use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/124_bihs_r3_female_mod_z4.dta", clear
keep a01 z4_01c1 z4_01d1 z4_mid
rename z4_mid mid_female
gen abuse = 0
replace abuse = 1 if z4_01c1 == 1 | z4_01c1 == 2 | z4_01d1 == 1 | z4_01d1 == 2
replace abuse = . if z4_01c1 == 9 | z4_01d1 == 9 | z4_01c1 == 88 | z4_01d1 == 88 | z4_01c1 == . | z4_01d1 == .
keep a01 mid_female abuse 
merge 1:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace




//main results
est clear  // clear the stored estimates
eststo: quietly reg DD empw_female 
eststo: quietly reg DD empw_female i.dvcode dep_ratio
eststo: quietly reg DD empw_female age_2_child age_child age_female age_hhh i.gender_child dep_ratio dist_shop edu_hhh edu_female farmer_hhh log_land FD i.income_3 i.dvcode 

esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress 

reg DD empw_female i.dvcode hh_size FD
