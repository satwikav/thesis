
/* Value of assets
- get the value of personal assets owned by each person in the hh
- to get value per asset, total value of each asset owned by the hh is divided by the quantity
- drop if owned by all members or someone outside the household*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/015_bihs_r3_male_mod_d1.dta", clear
keep a01 d1_02 d1_02oth d1_03 d1_04 d1_06_a d1_06_b d1_06_c d1_09
drop if d1_02 == 16
rename d1_06_a d1_06_1
rename d1_06_b d1_06_2
rename d1_06_c d1_06_3
reshape long d1_06_ , i(a01 d1_02 d1_02oth d1_03 d1_04 d1_09) j(ix)
rename d1_06_ mid
gen value = d1_09 / d1_04
replace value = d1_09 if d1_04 == .
collapse (sum) value, by(a01 mid)
drop if mid == . | mid == 71 | mid == 72 | mid == 73
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace 
/* Cost of Education
- get the value of education - cost of technical education, cost of school fees, cost of private*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/014_bihs_r3_male_mod_c3.dta", clear
keep a01 mid_c3 c3_08
rename mid_c3 mid
merge m:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/011_bihs_r3_male_mod_b2.dta", clear
keep a01 mid_b2 b2_08b 
rename mid_b2 mid
merge 1:m a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/011_bihs_r3_male_mod_b2.dta", clear
keep a01 mid_b2 b2_08d
rename mid_b2 mid
merge 1:m a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace 
/* Calculate the total investments*/
egen investment = rowtotal(b2_08d b2_08b c3_08 value)
gen school = b2_08b * 12
gen tution = b2_08d * 12
egen edu_cost = rowtotal(school tution)
replace investment = . if b2_08d == . & b2_08b == . & c3_08 == . & value == . 
rename c3_08 voc_cost
drop b2_08d b2_08b
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace 
/* Invidual level information
- drop if person is greater than 18 years old
- drop if person is primary respondent
- */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep mid a01 b1_01 b1_02 b1_03 b1_04 b1_09 b1_10 b1_08a
merge 1:m a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop _m 
keep if b1_02 < 18
rename b1_02 age_child_years
drop if b1_03 == 1 | b1_03 == 2
drop b1_03
gen girl_child = 1 if b1_01 == 2
replace girl_child = 0 if b1_01 == 1
drop b1_01
gen unmarried = 0 
replace unmarried = 1 if b1_04 == 1
drop b1_04
gen edu_child = b1_09
replace edu_child = 0 if edu_child == 2
/*gen edu_child = b1_08
replace edu_child = 0 if b1_08 == 66
replace edu_child = 0 if b1_08 == 99
replace edu_child = 9 if b1_08 == 22
replace edu_child = 11 if b1_08 == 33
replace edu_child = 12 if b1_08 == 75
replace edu_child = 15 if b1_08 == 14
replace edu_child = 16 if b1_08 == 15
replace edu_child = 16 if b1_08 == 72
replace edu_child = 16 if b1_08 == 73
replace edu_child = 16 if b1_08 == 74
replace edu_child = 17 if b1_08 == 16
replace edu_child = 17 if b1_08 == 71
replace edu_child = . if b1_08 == 67
replace edu_child = . if b1_08 == 76
drop b1_08*/
rename mid mid_child
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace 
/*Female empowerment scores
- retain score, type of hh*/
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta", clear
rename ci empw_female
rename mid mid_female
keep a01 empw_female mid_female
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta", replace
/*Male empowerment scores
- retain score, type of hh
- check if type of hh is same for each hh 
- create if hh is deal headed
- calculate empowerment gap between male and female*/
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/male_score.dta", clear
rename ci empw_male
rename mid mid_male
keep a01 empw_male mid_male
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta", replace
/*female_resp's age
- get female_resp's age from hh info
- create if age square of female_resp*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_female
rename b1_02 age_female_resp
merge 1:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta", replace
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
merge 1:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _merge b1_08
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace
/*Household's location
- get hh location and size from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 dvcode a23
rename a23 hh_size
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace
/*Household dependency ratio
- get number of dependents (age less than 15 and greater than 64) in each household from from hh info
- divide the dependents by household size to the dependency ratio*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02
drop if b1_02 == .
gen dependents = 0
replace dependents = 1 if b1_02 < 15 | b1_02 > 64
collapse (sum) dep, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _m
gen dep_ratio = dependents / hh_size
drop dependents
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _merge land
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace
/* total income of the household - step 1 
- keep the montly income earned by the members
- obtain the yearly income earned by the members 
- collapse at hh level*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/012_bihs_r3_male_mod_c.dta", clear
replace c14 = 0 if c14 == .
gen salary = c14 * 12
collapse (sum) salary, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace
/* total income of the household - step 2
- keep the yearly remittances received by the members
- collapse at hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/073_bihs_r3_male_mod_v2.dta", clear
replace v2_06 = 0 if v2_06 == .
collapse (sum) v2_06, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace
/* total income of the household - step 3
- keep the yearly other incomes received by the households
- sum them at the hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/076_bihs_r3_male_mod_v4.dta", clear
egen other = rowtotal(v4_01-v4_12)
keep a01 other
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _m
egen total_income = rowtotal(other v2_06 salary)
drop other v2_06 salary
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace
/* income terciles
- calculate income terciles */
use "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",clear
xtile income_3 = total_income, nq(3)
drop total_income
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace
/*physical or verbal abuse in last 12 months
- if the wiea respondent was abused*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/124_bihs_r3_female_mod_z4.dta", clear
keep a01 z4_01c1 z4_01d1 z4_mid 
rename z4_mid mid_female
gen abuse = 0
replace abuse = 1 if z4_01c1 == 1 | z4_01c1 == 2 | z4_01d1 == 1 | z4_01d1 == 2
replace abuse = . if z4_01c1 == 9 | z4_01d1 == 9 | z4_01c1 == 88 | z4_01d1 == 88 | z4_01c1 == . | z4_01d1 == .
keep a01 mid_female abuse
merge 1:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta", replace
/* distance to local shops
- keep only if the facility is local shops
- merge the distance with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/066_bihs_r3_male_mod_s.dta", clear
keep if s_01 == 6
keep a01 s_04 
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _m
rename s_04 dist_market
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/investment.dta",replace

gen log_inv = ln(investment)
gen log_edu = ln(edu_cost)
gen log_value = ln(value)
gen log_voc = ln(voc_cost)
gen log_school = ln(school)
gen log_tution = ln(tution)



gen age_2_child = age_child_years ^ 2
gen age_2_female_resp = age_female_resp ^ 2
gen age_2_hhh = age_hhh ^ 2
drop if age_child_years < 6 
//drop if age_child_years > 15
gen not_working = 0 
replace not_working = 1 if b1_10 == 81|b1_10 == 82|b1_10 == 84|b1_10 == 85|b1_10 == 86|b1_10 == 99|b1_10 == 83
replace not_working = . if b1_10 == .
gen scholarship = 0
replace scholarship = 1 if b1_08a == 3|b1_08a == 4|b1_08a == 5|b1_08a == 8|b1_08a == 9|b1_08a == 10
replace scholarship = . if b1_08a == .

/*main results for regression 3
est clear  // clear the stored estimates
eststo: quietly reg value empw_female i.dvcode age_child_years age_hhh dep_ratio edu_hhh trader_hhh girl_child i.income_3 unmarried edu_child abuse edu_female_resp age_female_resp not_working scholarship age_2_child log_land
//main results for regression 4
eststo: quietly reg edu_cost empw_female i.dvcode age_child_years age_hhh dep_ratio edu_hhh trader_hhh girl_child i.income_3 unmarried edu_child abuse edu_female_resp age_female_resp not_working scholarship age_2_child log_land
//main results for regression 5  
eststo: quietly reg investment empw_female i.dvcode age_child_years age_hhh dep_ratio edu_hhh trader_hhh girl_child i.income_3 unmarried edu_child abuse edu_female_resp age_female_resp not_working scholarship age_2_child log_land
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress

est clear  // clear the stored estimates
eststo: quietly reg log_value empw_female i.dvcode age_child_years age_hhh dep_ratio edu_hhh trader_hhh girl_child i.income_3 unmarried edu_child abuse edu_female_resp age_female_resp not_working scholarship age_2_child log_land
//main results for regression 4
eststo: quietly reg log_edu empw_female i.dvcode age_child_years age_hhh dep_ratio edu_hhh trader_hhh girl_child i.income_3 unmarried edu_child abuse edu_female_resp age_female_resp not_working scholarship age_2_child log_land
//main results for regression 5  


est clear  // clear the stored estimates
eststo: quietly reg log_inv empw_female age_child_years age_2_child girl_child edu_child not_working unmarried scholarship edu_female_resp age_female_resp abuse log_land dep_ratio age_hhh edu_hhh trader_hhh i.income_3  i.dvcode       
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress  

gen gap =  empw_male - empw_female


eststo: quietly reg log_inv empw_female age_child_years age_2_child girl_child edu_child not_working unmarried scholarship edu_female_resp age_female_resp abuse log_land dep_ratio age_hhh edu_hhh trader_hhh i.income_3  i.dvcode
eststo: quietly reg log_edu empw_female age_child_years age_2_child girl_child not_working unmarried scholarship edu_female_resp age_female_resp  log_land dep_ratio age_hhh edu_hhh trader_hhh i.income_3  i.dvcode  */

eststo: quietly reg log_value empw_female age_child_years age_2_child girl_child not_working unmarried scholarship edu_female_resp age_female_resp  log_land dep_ratio age_hhh edu_hhh trader_hhh i.income_3  i.dvcode 

est clear  // clear the stored estimates
eststo: quietly reg log_value empw_female age_child_years age_2_child girl_child not_working unmarried scholarship log_land dep_ratio age_hhh edu_hhh trader_hhh i.income_3  i.dvcode 
eststo: quietly reg log_value empw_female age_child_years age_2_child girl_child not_working unmarried scholarship edu_female_resp age_female_resp  log_land dep_ratio age_hhh edu_hhh trader_hhh i.income_3  i.dvcode edu_child
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress  



