//annual expenses 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/062_bihs_r3_male_mod_p2.dta", clear
keep if inlist(p2_01, 63, 64, 65, 66, 67, 68, 69, 70, 71, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 168, 172, 217, 176, 210, 212, 213, 218, 222)
gen category = 1 if inlist(p2_01, 63, 64, 65, 66, 67, 68, 69, 70, 71)
replace category = 2 if inlist(p2_01, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155)
replace category = 3 if inlist(p2_01, 168, 172, 217)
replace category = 4 if inlist(p2_01, 176, 210, 212, 213, 218, 222)
collapse (sum) p2_03, by(a01 category)
reshape wide p2_03, i(a01) j(category)
rename p2_031 cost_clothes
rename p2_032 cost_edu
rename p2_033 cost_hobbies
rename p2_034 cost_tech
egen inv = rowtotal(cost_clothes cost_edu cost_hobbies cost_tech)
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta",replace 
/* Invidual level information
- drop if person is greater than 18 years old
- drop if person is primary respondent*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep mid a01 b1_02 b1_03 b1_10 b1_08a b1_01 b1_04 b1_09
keep if b1_02 > 5 & b1_02 < 16
gen children = 0
replace children = 1 if b1_02 > 5 & b1_02 < 16
replace children = 0 if b1_03 == 1 | b1_03 == 2
//replace children = 1 if b1_02 < 18
gen child_working = 1 if children == 1
replace child_working = 0 if (b1_10 == 81|b1_10 == 82|b1_10 == 84|b1_10 == 85|b1_10 == 86|b1_10 == 99|b1_10 == 83) & children == 1
gen scholarship = 0 if children == 1
replace scholarship = 1 if (b1_08a == 3|b1_08a == 4|b1_08a == 5|b1_08a == 8|b1_08a == 9|b1_08a == 10) & children == 1
gen married = 1 & children == 1
replace married = 0 if b1_04 == 1 & children == 1
gen girl_child = 1 if b1_01 == 2 & children == 1
replace girl_child = 0 if b1_01 == 1 & children == 1
gen edu_child = 1 if b1_01 == 1 & children == 1
replace edu_child = 0 if b1_01 == 2 & children == 1
collapse (sum) children scholarship child_working girl_child married edu_child, by(a01)
//collapse (sum) girl_child edu_child, by(a01)
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta"
drop if _m == 2
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta", replace
/*Female empowerment scores
- retain score, type of hh*/
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta", clear
rename ci empw_female
rename mid mid_female
keep a01 empw_female mid_female
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta", replace
/*Mother's age
- get mother's age from hh info
- create if age square of mother*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_female
rename b1_02 age_female_resp
merge 1:1 a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta", replace
/*Male empowerment scores
- retain score, type of hh
- check if type of hh is same for each hh 
- create if hh is deal headed
- calculate empowerment gap between male and female*/
use "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/male_score.dta", clear
rename ci empw_male
rename mid mid_male
keep a01 empw_male mid_male
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta", replace
/*Mother's years of education
- get mother's highest education from hh info
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
merge 1:1 a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta"
drop if _m == 1
drop _merge b1_08
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta",replace
/*Household's location
- get hh location and size from hh info*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 dvcode a23
rename a23 hh_size
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta",replace
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta",replace
/*Household dependency ratio
- get number of dependents (age less than 15 and greater than 64) in each household from from hh info
- divide the dependents by household size to the dependency ratio*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02
drop if b1_02 == .
gen dependents = 0
replace dependents = 1 if b1_02 < 15 | b1_02 > 64
collapse (sum) dep, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta"
drop if _m == 1
drop _m
gen dep_ratio = dependents / hh_size
drop dependents
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta",replace
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
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta"
drop if _m == 1
drop _merge land
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta",replace
/* total income of the household - step 1 
- keep the montly income earned by the members
- obtain the yearly income earned by the members 
- collapse at hh level*/
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/012_bihs_r3_male_mod_c.dta", clear
replace c14 = 0 if c14 == .
gen salary = c14 * 12
collapse (sum) salary, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta",replace
/* total income of the household - step 2
- keep the yearly remittances received by the members
- collapse at hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/073_bihs_r3_male_mod_v2.dta", clear
replace v2_06 = 0 if v2_06 == .
collapse (sum) v2_06, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta",replace
/* total income of the household - step 3
- keep the yearly other incomes received by the households
- sum them at the hh level */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/076_bihs_r3_male_mod_v4.dta", clear
egen other = rowtotal(v4_01-v4_12)
keep a01 other
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta"
drop if _m == 1
drop _m
egen total_income = rowtotal(other v2_06 salary)
drop other v2_06 salary
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta",replace
/* income terciles
- calculate income terciles */
use "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta",clear
xtile income_3 = total_income, nq(3)
drop total_income
save "/Users/satwikav/Documents/GitHub/thesis/data/investment_1.dta",replace

gen log_inv = ln(inv)
gen log_clothes = ln(cost_clothes)
gen log_edu = ln(cost_edu)
gen log_hobb = ln(cost_hobbies)
gen log_tech = ln(cost_tech)
egen inv_1 = rowtotal(cost_clothes cost_edu)
egen inv_2 = rowtotal(cost_clothes cost_edu cost_tech)
gen log_inv_1 = ln(inv_1)
gen log_inv_2 = ln(inv_2)




est clear  
eststo: quietly reg log_inv empw_female children child_working edu_child girl_child married scholarship  age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh hh_size log_land i.income_3 i.dvcode
eststo: quietly reg log_inv empw_female girl_child edu_child age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh hh_size log_land i.income_3 i.dvcode
eststo: quietly reg log_inv empw_female children child_working edu_child girl_child married scholarship  age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh dep_ratio log_land i.income_3 i.dvcode
eststo: quietly reg log_inv empw_female girl_child edu_child age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh dep_ratio log_land i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress

gen gap =  empw_male - empw_female

est clear  
eststo: quietly reg log_inv gap children child_working edu_child girl_child married scholarship  age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh hh_size log_land i.income_3 i.dvcode
eststo: quietly reg log_inv gap girl_child edu_child age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh hh_size log_land i.income_3 i.dvcode
eststo: quietly reg log_inv gap children child_working edu_child girl_child married scholarship  age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh dep_ratio log_land i.income_3 i.dvcode
eststo: quietly reg log_inv gap girl_child edu_child age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh dep_ratio log_land i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress




/*

est clear  
eststo: quietly reg log_clothes empw_female girl_child edu_child age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh hh_size log_land i.income_3 i.dvcode
eststo: quietly reg log_edu empw_female girl_child edu_child age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh hh_size log_land i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress

est clear  
eststo: quietly reg log_hobb empw_female girl_child edu_child age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh hh_size log_land i.income_3 i.dvcode
eststo: quietly reg log_tech empw_female girl_child edu_child age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh hh_size log_land i.income_3 i.dvcode
eststo: quietly reg log_inv empw_female girl_child edu_child age_female_resp edu_female_resp age_hhh edu_hhh trader_hhh hh_size log_land i.income_3 i.dvcode
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress


est clear  
eststo: quietly reg log_inv empw_female 
eststo: quietly reg log_inv empw_female i.dvcode 

est clear  
eststo: quietly reg log_clothes empw_female i.dvcode age_hhh age_female_resp child_working children edu_hhh edu_female_resp trader_hhh girl_child hh_size i.income_3 log_land married scholarship
eststo: quietly reg log_edu empw_female i.dvcode age_hhh age_female_resp child_working children edu_hhh edu_female_resp trader_hhh girl_child hh_size i.income_3 log_land married scholarship
eststo: quietly reg log_hobb empw_female i.dvcode age_hhh age_female_resp child_working children edu_hhh edu_female_resp trader_hhh girl_child hh_size i.income_3 log_land married scholarship
eststo: quietly reg log_tech empw_female i.dvcode age_hhh age_female_resp child_working children edu_hhh edu_female_resp trader_hhh girl_child hh_size i.income_3 log_land married scholarship
esttab, b(2) p(2) r2 ar2 star(* 0.10 ** 0.05 *** 0.01) wide compress

*/

