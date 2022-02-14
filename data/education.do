/////////OUTCOME - years of education
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_02 b1_08 b1_01 b1_03 b1_10 b1_08a b1_04
keep if b1_02 <= 17 & b1_02 >= 6
gen year_edu = b1_08
replace year_edu = 0 if b1_08 == 66
replace year_edu = 0 if b1_08 == 99
replace year_edu = 9 if b1_08 == 22
replace year_edu = 11 if b1_08 == 33
replace year_edu = 12 if b1_08 == 75
replace year_edu = 15 if b1_08 == 14
replace year_edu = 16 if b1_08 == 15
replace year_edu = 16 if b1_08 == 72
replace year_edu = 16 if b1_08 == 73
replace year_edu = 16 if b1_08 == 74
replace year_edu = 17 if b1_08 == 16
replace year_edu = 17 if b1_08 == 71
replace year_edu = . if b1_08 == 67
replace year_edu = . if b1_08 == 76
gen id = .
replace id = 1 if inlist(b1_02, 6,7,8,9,10)
replace id = 2 if inlist(b1_02, 11,12,13,14,15,16,17)
bysort id: egen avg_edu = mean(year_edu)
gen dev_edu = year_edu - avg_edu
gen not_working = 0 
replace not_working = 1 if b1_10 == 81|b1_10 == 82|b1_10 == 84|b1_10 == 85|b1_10 == 86|b1_10 == 99|b1_10 == 83
replace not_working = . if b1_10 == .
gen scholarship = 0
replace scholarship = 1 if b1_08a == 3|b1_08a == 4|b1_08a == 5|b1_08a == 8|b1_08a == 9|b1_08a == 10
replace scholarship = . if b1_08a == .
gen unmarried = 0 
replace unmarried = 1 if b1_04 == 1
replace unmarried = . if b1_04 == .
drop if b1_03 == 1 | b1_03 == 2
gen girl_child = 1 if b1_01 == 2
replace girl_child = 0 if b1_01 == 1
drop avg_edu b1_08 year_edu b1_10 b1_08a b1_04 b1_03 b1_01
rename b1_02 age_child
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",replace 
/*Female empowerment scores
- retain score, type of hh*/
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta", clear
rename ci empw_female
rename mid mid_female
keep a01 empw_female mid_female
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta", replace
/*Male empowerment scores
- retain score, type of hh
- check if type of hh is same for each hh 
- create if hh is deal headed
- calculate empowerment gap between male and female*/
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/male_score.dta", clear
rename ci empw_male
rename mid mid_male
keep a01 empw_male mid_male
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta", replace
/*female_resp's age
- get female_resp's age from hh info
- create if age square of female_resp*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_female
rename b1_02 age_female_resp
merge 1:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta", replace
/*female_resp's years of education
- get female_resp's highest education from hh info
- calculate years of education depending on the highest class passed*/
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
merge 1:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _merge b1_08
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",replace
/*Household's location
- get hh location and size from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 dvcode a23
rename a23 hh_size
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",replace
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",replace
/*Household dependency ratio
- get number of dependents (age less than 15 and greater than 64) in each household from from hh info
- divide the dependents by household size to the dependency ratio*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02
drop if b1_02 == .
gen dependents = 0
replace dependents = 1 if b1_02 < 15 | b1_02 > 64
collapse (sum) dep, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _m
gen dep_ratio = dependents / hh_size
drop dependents
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",replace
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _merge land
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",replace
/* total income of the household - step 1 
- keep the montly income earned by the members
- obtain the yearly income earned by the members 
- collapse at hh level*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/012_bihs_r3_male_mod_c.dta", clear
replace c14 = 0 if c14 == .
gen salary = c14 * 12
collapse (sum) salary, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",replace
/* total income of the household - step 2
- keep the yearly remittances received by the members
- collapse at hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/073_bihs_r3_male_mod_v2.dta", clear
replace v2_06 = 0 if v2_06 == .
collapse (sum) v2_06, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",replace
/* total income of the household - step 3
- keep the yearly other incomes received by the households
- sum them at the hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/076_bihs_r3_male_mod_v4.dta", clear
egen other = rowtotal(v4_01-v4_12)
keep a01 other
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _m
egen total_income = rowtotal(other v2_06 salary)
drop other v2_06 salary
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",replace
/* income terciles
- calculate income terciles */
use "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",clear
xtile income_3 = total_income, nq(3)
drop total_income
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",replace
/*physical or verbal abuse in last 12 months
- if the wiea respondent was abused*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/124_bihs_r3_female_mod_z4.dta", clear
keep a01 z4_01c1 z4_01d1 z4_mid 
rename z4_mid mid_female
gen abuse = 0
replace abuse = 1 if z4_01c1 == 1 | z4_01c1 == 2 | z4_01d1 == 1 | z4_01d1 == 2
replace abuse = . if z4_01c1 == 9 | z4_01d1 == 9 | z4_01c1 == 88 | z4_01d1 == 88 | z4_01c1 == . | z4_01d1 == .
keep a01 mid_female abuse
merge 1:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta", replace
/* distance to school
- keep only if the facility is local shops
- merge the distance with previous data=
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/066_bihs_r3_male_mod_s.dta", clear
keep if s_01 == 21 | s_01 == 24
keep a01 s_04 s_01
reshape wide s_04, i(a01) j(s_01)
rename s_0421 dist_prim
rename s_0424 dist_sec
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/education.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",replace

gen age_2_child = age_child ^ 2
gen age_2_female_resp = age_female_resp ^ 2
gen age_2_hhh = age_hhh ^ 2
save "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",replace


use "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",clear
keep if age_child <= 15
est clear  
eststo: quietly reg dev_edu empw_female age_child age_2_child girl_child not_working unmarried scholarship edu_female_resp age_female_resp abuse log_land dep_ratio age_hhh edu_hhh trader_hhh dist_prim dist_sec i.income_3 i.dvcode 
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress


use "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",clear
keep if id == 1
gen gap =  empw_male - empw_female

est clear  
eststo: quietly reg dev_edu empw_female age_child age_2_child girl_child not_working unmarried scholarship edu_female_resp age_female_resp abuse log_land dep_ratio age_hhh edu_hhh trader_hhh dist_prim i.income_3  i.dvcode 
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
est clear  
eststo: quietly reg dev_edu gap age_child age_2_child girl_child not_working unmarried scholarship edu_female_resp age_female_resp abuse log_land dep_ratio age_hhh edu_hhh trader_hhh dist_prim i.income_3  i.dvcode 
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress


use "/Users/satwikav/Documents/GitHub/thesis/data/education.dta",clear
keep if id == 2
gen gap =  empw_male - empw_female

est clear  
eststo: quietly reg dev_edu empw_female age_child age_2_child girl_child not_working unmarried scholarship edu_female_resp age_female_resp abuse log_land dep_ratio age_hhh edu_hhh trader_hhh dist_sec i.income_3  i.dvcode 
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
est clear  
eststo: quietly reg dev_edu gap age_child age_2_child girl_child not_working unmarried scholarship edu_female_resp age_female_resp abuse log_land dep_ratio age_hhh edu_hhh trader_hhh dist_sec i.income_3  i.dvcode 
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress
