/* 5d score and parity gap for female respondents
- drop if sex of the respondent is male
- calculate the empowerment score
- save in out_1.dta 
use "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",clear
gen stun = 0
replace stun = 1 if haz06 <= -2
graph hbar, over(stun) // 34% of the kids in the sample are stunted 
drop if stunting == "no"
tab stunting //of the stunted kids, 50% are low, 36% are moderate and 14% are severe  
graph hbar (count), over(stun) over(div_name) // Dhaka followed by Sylhet have the highest number of stunting cases
graph hbar (count), over(stunting) over(div_name)

graph hbar (count), over(stun) over(age_bucket)
graph hbar (count), over(stunting) over(age_bucket)

graph hbar (count), over(stun) over(gender_child)
graph hbar (count), over(stunting) over(gender_child)



graph hbar, over(stun) over(gender_child)


use "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",clear

reg haz06 empw_female edu_diff age_diff gender_child age_child farm_male dep_ratio log_land i.income_3  i.dvcode 
estimates table, star(.05 .01 .001)*/


//haz,whz,waz des stats
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/100_bihs_r3_female_mod_w2.dta", clear
keep a01 mid_w2 w2_14 haz06 waz06 whz06 w2_01a w2_01
rename w2_01a mid_father
rename w2_01 mid_mother
drop if mid_w2 == 99
rename mid_w2 mid
gen stunting = .
replace stunting = 1 if haz06 <= -2
gen wasting = .
replace wasting = 1 if whz06 <= -2
gen underweight = .
replace underweight = 1 if waz06 <= -2
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta", replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_01
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
drop if haz06 == . & waz06 == . & whz06 == .
gen female = 1 if b1_01 == 2
replace female = 0 if b1_01 == 1
drop b1_01
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta", replace
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/5d_score.dta", clear
drop if wa05 == 1
gen empw_female = ci
rename mid mid_female
keep a01 empw_female
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta", replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_father
rename b1_02 age_father
merge m:m a01 mid_father using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_mother
rename b1_02 age_mother
merge m:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _merge
gen age_diff =  age_father - age_mother
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace


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
merge m:m a01 mid_mother using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _merge b1_08
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_08
gen edu_father = b1_08
replace edu_father = 0 if b1_08 == 66
replace edu_father = 0 if b1_08 == 99
replace edu_father = 9 if b1_08 == 22
replace edu_father = 11 if b1_08 == 33
replace edu_father = 12 if b1_08 == 75
replace edu_father = 15 if b1_08 == 14
replace edu_father = 16 if b1_08 == 15
replace edu_father = 16 if b1_08 == 72
replace edu_father = 16 if b1_08 == 73
replace edu_father = 16 if b1_08 == 74
replace edu_father = 17 if b1_08 == 16
replace edu_father = 17 if b1_08 == 71
replace edu_father = . if b1_08 == 67
replace edu_father = . if b1_08 == 76
rename mid mid_father
merge m:m a01 mid_father using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _merge b1_08
gen edu_diff = edu_father - edu_mother
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep if b1_03 == 1
keep a01 b1_10 
gen farmer_hhh = 0
replace farmer_hhh = 1 if b1_10 == 64 | b1_10 == 65 | b1_10 == 66 | b1_10 == 67| b1_10 == 68| b1_10 == 69| b1_10 == 70| b1_10 == 71| b1_10 == 72
gen trader_hhh = 0
replace trader_hhh = 1 if b1_10 == 50 | b1_10 == 51 | b1_10 == 52 | b1_10 == 53| b1_10 == 54
drop b1_10
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 dvcode div_name a23
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m 
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02
drop if b1_02 == .
gen dep = 0
replace dep = 1 if b1_02 < 15 | b1_02 > 64
collapse (sum) dep, by(a01)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
gen dep_ratio = dep / a23
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/020_bihs_r3_male_mod_g.dta",clear
keep a01 plotid g01 g02 g06
gen cultland=0
replace cultland=g02/100 if [g01==2 & (g06==2| g06==3|g06==4|g06==5|g06==9|g06==11|g06==12|g06==13)]| [g01==8 & (g06==2| g06==3|g06==4|g06==5|g06==9|g06==11|g06==12|g06==13)]  
collapse (sum) cultland, by(a01) 
gen log_land = ln(cultland + 1)
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
/* total income of the household - step 1 
- keep the montly income earned by the members
- obtain the yearly income earned by the members 
- collapse at hh level
- merge with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/012_bihs_r3_male_mod_c.dta", clear
replace c14 = 0 if c14 == .
gen salary = c14 * 12
collapse (sum) salary, by(a01)
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
/* total income of the household - step 2
- keep the yearly remittances received by the members
- collapse at hh level
- merge with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/073_bihs_r3_male_mod_v2.dta", clear
replace v2_06 = 0 if v2_06 == .
collapse (sum) v2_06, by(a01)
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
/* total income of the household - step 3
- keep the yearly other incomes received by the households
- sum them at the hh level
- merge with previous data
- generate total yearly income of the households by summing yearly salary, yearly remittances, yearly other income
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/076_bihs_r3_male_mod_v4.dta", clear
egen other = rowtotal(v4_01-v4_12)
keep a01 other
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta"
drop if _m == 1
drop _m
egen total_income = rowtotal(other v2_06 salary)
drop other v2_06 salary
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
/* income terciles
- calculate income terciles
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",clear
xtile income_3 = total_income, nq(3)
save "/Users/satwikav/Documents/GitHub/thesis/data/des_1.dta",replace
//Des stats
tabstat haz06, stat(n mean sd) by(female)
tabstat waz06, stat(n mean sd) by(female)
tabstat whz06, stat(n mean sd) by(female)
sum haz06 if stunting == 1
sum haz06 if stunting == 1 & female == 1
sum haz06 if stunting == 1 & female == 0
sum whz06 if wasting == 1
sum whz06 if wasting == 1 & female == 1
sum whz06 if wasting == 1 & female == 0
sum waz06 if underweight == 1
sum waz06 if underweight == 1 & female == 1
sum waz06 if underweight == 1 & female == 0
sum w2_14
tab female
sum female
sum empw_female
//sum empw_male
//sum empw_gap
sum age_father
sum age_mother
sum age_diff
summ trader_hhh
summ farmer_hhh
sum a23
summ dep
sum dep_ratio
tab dvcode
foreach j in 10 20 30 40 50 55 60 {
	gen d_`j' = 0 
	replace d_`j' = 1 if dvcode == `j'
	summ d_`j'
}
summ cultland
summ log_land
summ total_income
tabstat total_income, stat(n mean sd min max) by(income_3)
keep haz06 empw_female age_diff edu_diff w2_14 female farmer_hhh trader_hhh dep_ratio log_land dvcode income_3
order haz06 empw_female age_diff edu_diff w2_14 female farmer_hhh trader_hhh dep_ratio log_land dvcode income_3
reg haz06 empw_female age_diff edu_diff w2_14 female farmer_hhh trader_hhh dep_ratio log_land i.dvcode i.income_3
estimates table, star(.1 .05 .01)
corr haz06 empw_female
reg haz06 empw_female 
estimates table, star(.1 .05 .01)



