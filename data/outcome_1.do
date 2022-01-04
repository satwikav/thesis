/* 5d score and parity gap for female respondents
- drop if sex of the respondent is male
- calculate the empowerment score
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/5d_score.dta", clear
drop if wa05 == 1
gen empw_female = 1 - ci
rename mid mid_female
keep a01 empw_female mid_female
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* 5d score and parity gap for male respondents
- drop if sex of the respondent is female
- calculate the empowerment score
- merge with female empowerment scores
- calculate the parity gap
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/5d_score.dta", clear
drop if wa05 == 2
gen empw_male = 1 - ci
rename mid mid_male
keep a01 empw_male mid_male
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop _merge
gen empw_gap = empw_male - empw_female
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* anthropometry for children <5 years
- drop if mid is 99 (not applicable)
- merge with previous data
- keep only the data that matches with father's and mother's data of the child
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/100_bihs_r3_female_mod_w2.dta", clear
keep a01 mid_w2 w2_14 haz06 waz06 whz06 w2_01a w2_01
drop if mid_w2 == 99
merge m:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 2
drop if w2_01 != mid_female
drop if w2_01a != mid_male
rename mid_w2 mid_child 
keep a01 mid_child w2_14 haz06 waz06 whz06 mid_male empw_female mid_female empw_gap
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* hh info
- keep the district, religion, household size, no of children and primary adult decision maker
- merge with previous data
- calculate if the child has siblings 
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 div_name a13 a23 a25 a26 dvcode
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
gen sibling = 1 if a25 > 1
replace sibling = 0 if a25 == 1 
gen pri_decmaker = 0 if a26 == 1
replace pri_decmaker = 1 if a26 == 2
drop a25 _m a26
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* Dependency ratio
- keep the age of the members
- calculate dependents if age is less than 15 or greater than 64
- collapse at hh level
- merge with previous data
- calculate dependecy ration
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02
drop if b1_02 == .
gen dep = 0
replace dep = 1 if b1_02 < 15 | b1_02 > 64
collapse (sum) dep, by(a01)
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
gen dep_ratio = dep / a23
drop dep a23 _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* Child gender
- keep the gender of the members
- merge with previous data 
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_01
drop if b1_01 == .
rename mid mid_child
merge 1:1 a01 mid_child using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
gen gender_child = 0 if  b1_01 == 1
replace gender_child = 1 if  b1_01 == 2
drop _m b1_01
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* No of years of education of the mother 
- keep the highest education level of members
- calculate the years of education
- merge with previous data
- save in out_1.dta */
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
merge m:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
drop _merge b1_08
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* No of years of education of the father 
- keep the highest education level of members
- calculate the years of education
- merge with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_08
gen edu_male = b1_08
replace edu_male = 0 if b1_08 == 66
replace edu_male = 0 if b1_08 == 99
replace edu_male = 9 if b1_08 == 22
replace edu_male = 11 if b1_08 == 33
replace edu_male = 12 if b1_08 == 75
replace edu_male = 15 if b1_08 == 14
replace edu_male = 16 if b1_08 == 15
replace edu_male = 16 if b1_08 == 72
replace edu_male = 16 if b1_08 == 73
replace edu_male = 16 if b1_08 == 74
replace edu_male = 17 if b1_08 == 16
replace edu_male = 17 if b1_08 == 71
replace edu_male = . if b1_08 == 67
replace edu_male = . if b1_08 == 76
rename mid mid_male
merge m:m a01 mid_male using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
drop _merge b1_08
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* Difference in edu 
- calculate the diff
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",clear
gen edu_diff = edu_male - edu_female
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* Age of the father
- keep the age of members
- merge with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_male
rename b1_02 age_male
merge m:m a01 mid_male using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* Age of the mother
- keep the age of members
- merge with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 b1_02 mid
rename mid mid_female
rename b1_02 age_female
merge m:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* Difference in Age 
- calculate the diff
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",clear
gen age_diff = age_male - age_female
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* Father is a farmer
- keep the occupation of members
- calculate if member is a farmer or not
- merge with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_10 
gen farm_male = 0
replace farm_male = 1 if b1_10 == 64 | b1_10 == 65 | b1_10 == 66 | b1_10 == 67| b1_10 == 68| b1_10 == 69| b1_10 == 70| b1_10 == 71| b1_10 == 72
drop b1_10
rename mid mid_male
merge m:m a01 mid_male using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* cultivable land operated by the household
- keep the land type, operational status and area
- generating operated cultivable land area in acres
- collapse at household level
- generated log tranformed area of land
- merge with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/020_bihs_r3_male_mod_g.dta",clear
keep a01 plotid g01 g02 g06
gen cultland=0
replace cultland=g02/100 if [g01==2 & (g06==2| g06==3|g06==4|g06==5|g06==9|g06==11|g06==12|g06==13)]| [g01==8 & (g06==2| g06==3|g06==4|g06==5|g06==9|g06==11|g06==12|g06==13)]  
collapse (sum) cultland, by(a01) 
gen log_land = ln(cultland + 1)
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
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
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* total income of the household - step 2
- keep the yearly remittances received by the members
- collapse at hh level
- merge with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/073_bihs_r3_male_mod_v2.dta", clear
replace v2_06 = 0 if v2_06 == .
collapse (sum) v2_06, by(a01)
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* total income of the household - step 3
- keep the yearly other incomes received by the households
- sum them at the hh level
- merge with previous data
- generate total yearly income of the households by summing yearly salary, yearly remittances, yearly other income
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/076_bihs_r3_male_mod_v4.dta", clear
egen other = rowtotal(v4_01-v4_12)
keep a01 other
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
drop _m
egen total_income = rowtotal(other v2_06 salary)
drop other v2_06 salary
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* income terciles
- calculate income terciles
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",clear
xtile income_3 = total_income, nq(3)
tabstat total_income, stat(n mean min max) by(income_3)
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* distance to local shops
- keep only if the facility is local shops
- merge the distance with previous data
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/066_bihs_r3_male_mod_s.dta", clear
keep if s_01 == 5
keep a01 s_04 
merge m:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta"
drop if _m == 1
drop _m
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace
/* general management
- renaming and labelling the variables
- setting value lables
- save in out_1.dta */
use "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",clear
drop mid_male mid_female mid_child
rename s_04 dist
label variable dist "Distance to the local shop (km)"
label variable cultland "cultivable land (acres)"
label variable log_land "log of cultivable land"
label variable farm_male "Father is a farmer?"
label variable age_female "age of the mother"
label variable age_male "age of the father"
label variable edu_male "years of education of father"
label variable edu_female "years of education of mother"
label variable edu_diff "difference in edu"
label variable age_diff "difference in age"
label variable gender_child "gender of child"
rename a13 religion
label variable religion "religion"
label variable pri_decmaker "Primary adult decision maker"
rename w2_14 age_child
label variable age_child "Child's age in full month"
label variable empw_female "5de score using 10 indicators for females"
label variable empw_gap "difference in 5de scores for men and women in a hh"
label variable sibling "child has a sibling < 6 years"
label variable dep_ratio "depedence ratio in the hh"
label variable total_income "yearly income (salaries+remittances+other income)"
label define choice 0 "No" 1 "Yes"
label values farm_male choice
label values sibling choice
label define gender 0 "Male" 1 "Female"
label values pri_decmaker gender
label values gender_child gender
label define division 10 "Barisal" 20 "Chittagong" 30 "Dhaka" 40 "Khulna" 50 "Rajshahi" 55 "Rangpur" 60 "Sylhet"
label values dvcode division
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace




/* for stunting, underweight, wasting
gen stunting = "no"
replace stunting = "low" if haz06 <= -1
replace stunting = "moderate" if haz06 <= -2
replace stunting = "severe" if haz06 <= -3
gen stunting_1 = 0
replace stunting_1 = 1 if haz06 <= -2
gen underweight = "no"
replace underweight = "low" if waz06 <= -1
replace underweight = "moderate" if waz06 <= -2
replace underweight = "severe" if waz06 <= -3
gen underweight_1 = 0
replace underweight_1 = 1 if waz06 <= -2
gen wasting = "no"
replace wasting = "low" if waz06 <= -1
replace wasting = "moderate" if whz06 <= -2
replace wasting = "severe" if whz06 <= -3
gen wasting_1 = 0
replace wasting_1 = 1 if whz06 <= -2
label values stunting_1 choice
label values underweight_1 choice
label values wasting_1 choice
gen age_bucket = "0-5" if age_child <= 5
replace age_bucket = "6-11" if age_child >= 6 & age_child <= 11
replace age_bucket = "12-23" if age_child >= 12 & age_child <= 23
replace age_bucket = "24-35" if age_child >= 24 & age_child <= 35
replace age_bucket = "36-47" if age_child >= 36 & age_child <= 47
replace age_bucket = "48-59" if age_child >= 48 & age_child <= 59
save "/Users/satwikav/Documents/GitHub/thesis/data/out_1.dta",replace */
