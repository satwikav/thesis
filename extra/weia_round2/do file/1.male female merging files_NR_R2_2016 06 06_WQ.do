clear all
set more off
*set maxvar 10000
set mem 500m
set more off
cap log close

global p1="U:\BIHS2015\Round 2\Household\Dataset"
global p3="U:\BIHS2015\Round 2\Household\Dataset\updated"
global p3="U:\BIHS2015\temp"

use "$p1\BIHS_R2_WGTS.dta", clear
keep a01 hhweight popweight hh_type
save "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta", replace



 
use "$p1\001_r2_mod_a_male.dta", clear
tab hh_type
keep if hh_type==2 | hh_type==3
keep if flag_a==1  //only completed interviews (243 dropped)
save "$p3\nr_male_mod_a_000.dta", replace

 *Generating two master files containing all weai variables from male and female files (one appended and one merged)
use "$p3\nr_male_mod_a_000.dta", clear
bysort a01: gen dup=_n
tab dup //looks ok
drop dup
duplicates report a01
merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
drop _merge //all 5447 observations

saveold "$p3\male_mod_a_NR_2016 06 06.dta", replace

use "$p1\003_r2_mod_b1_male.dta", clear
merge n:1 a01 using "$p3\nr_male_mod_a_000.dta", keepusing (hh_type)
keep if _merge==3
drop _merge
duplicates report
merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" //7156 observations not matched (FTF, indigenous)
keep if _merge==3 // 7156 observations dropped
drop _merge
saveold "$p3\male_mod_b1_NR_2016 06 06.dta", replace

/***********combining male weia files******************/
use "$p1\083_r2_weai_ind_mod_wa_male.dta", clear
merge n:1 a01 using "$p3\nr_male_mod_a_000.dta", keepusing (hh_type)
keep if _merge==3
drop _merge
bysort a01: gen dup=_n
tab dup //no duplication
drop dup
tab hh_type
keep if hh_type==2 | hh_type==3
keep if wa11==1 
duplicates report
merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" 
keep if _merge==3 //4482 observations
drop _merge
saveold "$p3\male_weai_ind_mod_wa_NR_2016 06 06.dta", replace


use "$p1\085_r2_weai_ind_mod_we2_male.dta", clear //data looks fine
merge n:1 a01 using "$p3\nr_male_mod_a_000.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

bysort a01: gen dup=_n
tab dup
drop if dup==2
drop dup
duplicates report
merge n:1 a01 using "$p1\001_r2_mod_a_male.dta", keepusing (hh_type)
tab hh_type if _merge==1 //all FTF and indigenous observations
*4482 male respondents
keep if _merge==3
drop _merge
saveold "$p3\male_weai_ind_mod_we2_NR_2016 06 06.dta", replace

use "$p1\087_r2_weai_ind_mod_we3a_male.dta", clear //looks ok
encode we3a, gen (asset)
rename we3a01a haveasset
rename we3a01b numberofasset
rename we3a02a owner_a
rename  we3a02b owner_b
rename  we3a02c owner_c
rename  we3a03a sell_decision_a
rename  we3a03b sell_decision_b
rename  we3a03c sell_decision_c
rename  we3a04a distribution_decision_a
rename  we3a04b distribution_decision_b
rename  we3a04c distribution_decision_c
rename  we3a05a rent_decision_a
rename  we3a05b rent_decision_b
rename  we3a05c rent_decision_c
rename  we3a06a purchase_decision_a
rename  we3a06b purchase_decision_b
rename  we3a06c purchase_decision_c
keep haveasset numberofasset owner_a owner_b owner_c sell_decision_a sell_decision_b sell_decision_c distribution_decision_a distribution_decision_b distribution_decision_c rent_decision_a rent_decision_b rent_decision_c purchase_decision_a purchase_decision_b purchase_decision_c a01 asset
reshape wide haveasset numberofasset owner_a owner_b owner_c sell_decision_a sell_decision_b sell_decision_c distribution_decision_a distribution_decision_b distribution_decision_c rent_decision_a rent_decision_b rent_decision_c purchase_decision_a purchase_decision_b purchase_decision_c, i (a01) j (asset)
save "$p3\nr_male_weai_ind_mod_we3a_000.dta", replace

use "$p3\nr_male_weai_ind_mod_we3a_000.dta", replace
duplicates report
merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" 
*4482 male respondents
keep if _merge==3
drop _merge
saveold "$p3\male_weai_ind_mod_we3a_NR_2016 06 06.dta", replace

use "$p1\093_r2_weai_ind_mod_we3d_male.dta", clear
merge n:1 a01 using "$p3\nr_male_mod_a_000.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

bysort wa01: gen dup=_n
tab dup //hh 6382 is wrongly entered as 6282 in wa01
drop dup
duplicates report

duplicates report
merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" 
*4481 male respondents (1 less response)
keep if _merge==3
drop _merge 
saveold "$p3\male_weai_ind_mod_we3d_NR_2016 06 06.dta", replace

use "$p1\089_r2_weai_ind_mod_we3b_male.dta", clear
bysort wa01: gen dup=_n
tab dup
drop dup

merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" 
*4482 male respondents
keep if _merge==3
drop _merge
saveold "$p3\male_weai_ind_mod_we3b_NR_2016 06 06.dta", replace

use "$p1\091_r2_weai_ind_mod_we3c_male.dta", clear
bysort wa01: gen dup=_n
tab dup
drop dup
duplicates report
merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" 
*4482 male respondents
keep if _merge==3
drop _merge
saveold "$p3\male_weai_ind_mod_we3c_NR_2016 06 06.dta", replace

use "$p1\095_r2_weai_ind_mod_we4_male.dta", clear
bysort wa01: gen dup=_n
tab dup //5 hh have different identification in wa01 and a01
drop dup
duplicates report wa01
merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" 
*4482 male respondents
keep if _merge==3
drop _merge
saveold "$p3\male_weai_ind_mod_we4_NR_2016 06 06.dta", replace

use "$p1\097_r2_weai_ind_mod_we5a_male.dta", clear
bysort wa01: gen dup=_n
tab dup
drop dup
duplicates report
merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" 
*4482 male respondents
keep if _merge==3
drop _merge
saveold "$p3\male_weai_ind_mod_we5a_NR_2016 06 06.dta", replace

use "$p1\099_r2_weai_ind_mod_we5b_male.dta", clear
bysort wa01: gen dup=_n
tab dup
drop dup
duplicates report
merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" 
*4482 male respondents
keep if _merge==3
drop _merge
saveold "$p3\male_weai_ind_mod_we5b_NR_2016 06 06.dta", replace


use "$p1\101_r2_weai_ind_mod_we5c_male.dta", clear
bysort wa01: gen dup=_n
tab dup
drop dup
duplicates report
merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" 
*4482 male respondents
keep if _merge==3
drop _merge
saveold "$p3\male_weai_ind_mod_we5c_NR_2016 06 06.dta", replace

use "$p1\103_r2_weai_ind_mod_we6a_male.dta", clear
merge n:1 a01 using "$p3\nr_male_mod_a_000.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

duplicates report
merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" 
tab hh_type if _merge==1 // all FTF and indigenous

keep if _merge==3
drop _merge
saveold "$p3\male_weai_ind_mod_we6a_NR_2016 06 06.dta", replace

use "$p1\105_r2_weai_ind_mod_we6b_male.dta", clear
bysort wa01: gen dup=_n
tab dup
drop dup
duplicates report
merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" 
*1702 male respondents
keep if _merge==3
drop _merge
saveold "$p3\male_weai_ind_mod_we6b_NR_2016 06 06.dta", replace

*use "r2_male_weai_ind_mod_we7c_000.dta", clear
use "$p1\107_r2_weai_ind_mod_we7_male.dta", clear  // don't find "we7c" 
bysort wa01: gen dup=_n
tab dup
drop dup
duplicates report
merge n:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" 
*4482 male respondents
keep if _merge==3
drop _merge
saveold "$p3\male_weai_ind_mod_we7c_NR_2016 06 06.dta", replace

*************merging male files
use "$p3\male_mod_a_NR_2016 06 06.dta", clear
merge 1:1 a01 using "$p3\male_weai_ind_mod_wa_NR_2016 06 06.dta"
keep if _merge==3
drop _merge 
gen keep=1
gen mid=wa04
*fixing mid and gender mismatch
*recode mid (2=3) if a01==5373.2
*recode mid (1=2) if a01==5287
*recode mid (10=1) if a01==5384

merge 1:1 a01 mid using "$p3\male_mod_b1_NR_2016 06 06.dta" //2 respondent's info missing from b1
keep if keep==1
drop _merge
merge 1:1 a01 using "$p3\male_weai_ind_mod_we2_NR_2016 06 06.dta"
drop _merge
merge 1:1 a01 using "$p3\male_weai_ind_mod_we3a_NR_2016 06 06.dta"
drop _merge
merge 1:1 a01 using "$p3\male_weai_ind_mod_we3d_NR_2016 06 06.dta"
drop if _m==2
tab _m
drop _merge
merge 1:1 a01 using "$p3\male_weai_ind_mod_we3b_NR_2016 06 06.dta"
drop _merge
merge 1:1 a01 using "$p3\male_weai_ind_mod_we3c_NR_2016 06 06.dta"
drop _merge
merge 1:1 a01 using "$p3\male_weai_ind_mod_we4_NR_2016 06 06.dta"
drop _merge
merge 1:1 a01 using "$p3\male_weai_ind_mod_we5a_NR_2016 06 06.dta"
drop _merge
merge 1:1 a01 using "$p3\male_weai_ind_mod_we5a_NR_2016 06 06.dta"
drop _merge
merge 1:1 a01 using "$p3\male_weai_ind_mod_we5b_NR_2016 06 06.dta"
drop _merge
merge 1:1 a01 using "$p3\male_weai_ind_mod_we5c_NR_2016 06 06.dta"
drop _merge
merge 1:1 a01 using "$p3\male_weai_ind_mod_we6b_NR_2016 06 06.dta"
drop _merge
merge 1:1 a01 using "$p3\male_weai_ind_mod_we7c_NR_2016 06 06.dta"
drop _merge
drop keep
//keep if wgt_new!=.
**************************************************drop District_Name- hh_type hh_type wa07- wa12 b1_05 b1_06
//drop  Upazila- hh_type  a02- a12 a16_dd- Flagaddl  regnm- FLAG_SMPL  dvcode quintile_ftf1- quintile_bihs3  wa07- wa12
saveold "$p3\male_weai_variables_NR_round2.dta", replace
/*HAVE NOT DROPPED HOUSEHOLDS WITH MISSING MALE RESPONDENTS*/



*************************************************************************************************************************************************************************
/***********combining female weia files******************/
clear all
set more off
set mem 500m
cap log close

use "$p1\002_r2_mod_a_female.dta", clear
bysort a01: gen dup=_n
tab dup //looks ok
drop dup
duplicates report a01

tab hh_type
keep if hh_type==2 | hh_type==3
merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
keep if _m==3
drop _merge //5447 observations (looks ok)
tab flag_fem_a
keep if flag_fem_a==1 

saveold "$p3\female_mod_a_NR_2016 06 06.dta", replace //5443 observations (4 female not completed)


use "$p1\084_r2_weai_ind_mod_wa_female.dta", clear
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

bysort a01: gen dup=_n
tab dup
drop if dup==2
drop dup
keep if wa11==1
recode wa04 (2=3) if a01==5373.2
recode wa04 (1=2) if a01==5287
recode wa04 (10=1) if a01==5384

tab hh_type
keep if hh_type==2 | hh_type==3

merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
keep if _merge==3
drop _merge
*5397 female respondents
saveold "$p3\female_weai_ind_mod_wa_NR_2016 06 06.dta", replace


use "$p1\086_r2_weai_ind_mod_we2_female.dta", clear
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge
 
tab hh_type
keep if hh_type==2 | hh_type==3

duplicates report
merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
*5397 female respondents
keep if _merge==3
drop _merge
saveold "$p3\female_weai_ind_mod_we2_NR_2016 06 06.dta", replace

use "$p1\088_r2_weai_ind_mod_we3a_female.dta", clear
*use "V:\PHN\SHARED\Nusrat\BIHS round 2\WEAI_Round II_USB\hh_Male\male_weai_ind_mod_we3a_002.dta", clear //looks ok
 encode we3a, gen (asset)
rename we3a01a haveasset
rename we3a01b numberofasset
rename we3a02a owner_a
rename  we3a02b owner_b
rename  we3a02c owner_c
rename  we3a03a sell_decision_a
rename  we3a03b sell_decision_b
rename  we3a03c sell_decision_c
rename  we3a04a distribution_decision_a
rename  we3a04b distribution_decision_b
rename  we3a04c distribution_decision_c
rename  we3a05a rent_decision_a
rename  we3a05b rent_decision_b
rename  we3a05c rent_decision_c
rename  we3a06a purchase_decision_a
rename  we3a06b purchase_decision_b
rename  we3a06c purchase_decision_c
keep haveasset numberofasset owner_a owner_b owner_c sell_decision_a sell_decision_b sell_decision_c distribution_decision_a distribution_decision_b distribution_decision_c rent_decision_a rent_decision_b rent_decision_c purchase_decision_a purchase_decision_b purchase_decision_c a01 asset
reshape wide haveasset numberofasset owner_a owner_b owner_c sell_decision_a sell_decision_b sell_decision_c distribution_decision_a distribution_decision_b distribution_decision_c rent_decision_a rent_decision_b rent_decision_c purchase_decision_a purchase_decision_b purchase_decision_c, i (a01) j (asset)
save "$p3\nr_female_weai_ind_mod_we3a_000.dta", replace

use "$p3\nr_female_weai_ind_mod_we3a_000.dta", replace
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

tab hh_type
keep if hh_type==2 | hh_type==3
duplicates report

merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
*5397 female respondents
keep if _merge==3
drop _merge
saveold "$p3\female_weai_ind_mod_we3a_NR_2016 06 06.dta", replace

use "$p1\094_r2_weai_ind_mod_we3d_female.dta", clear
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

bysort wa01: gen dup=_n
tab dup
drop dup
duplicates report
tab hh_type
keep if hh_type==2 | hh_type==3

duplicates report
merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
*5397 female respondents
keep if _merge==3
drop _merge
saveold "$p3\female_weai_ind_mod_we3d_NR_2016 06 06.dta", replace

use "$p1\090_r2_weai_ind_mod_we3b_female.dta", clear
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

bysort wa01: gen dup=_n
tab dup
drop dup
duplicates report

tab hh_type
keep if hh_type==2 | hh_type==3

merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
*5397 female respondents
keep if _merge==3
drop _merge
saveold "$p3\female_weai_ind_mod_we3b_NR_2016 06 06.dta", replace

use "$p1\092_r2_weai_ind_mod_we3c_female.dta", clear
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

tab hh_type
keep if hh_type==2 | hh_type==3

bysort wa01: gen dup=_n
tab dup
drop dup
duplicates report
merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
*5397 female respondents
keep if _merge==3
drop _merge
saveold "$p3\female_weai_ind_mod_we3c_NR_2016 06 06.dta", replace //done till june 6

use "$p1\096_r2_weai_ind_mod_we4_female.dta", clear
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

tab hh_type
keep if hh_type==2 | hh_type==3

bysort wa01: gen dup=_n
tab dup
drop dup

duplicates report
merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
*5397 female respondents
keep if _merge==3
drop _merge
saveold "$p3\female_weai_ind_mod_we4_NR_2016 06 06.dta.dta", replace

use "$p1\098_r2_weai_ind_mod_we5a_female.dta", clear
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

tab hh_type
keep if hh_type==2 | hh_type==3

duplicates report
merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
*5397 female respondents
keep if _merge==3
drop _merge
saveold "$p3\female_weai_ind_mod_we5a_NR_2016 06 06.dta", replace

use "$p1\100_r2_weai_ind_mod_we5b_female.dta", clear
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

tab hh_type
keep if hh_type==2 | hh_type==3


bysort wa01: gen dup=_n
tab dup
drop dup
duplicates report
merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
*5397 female respondents
keep if _merge==3
drop _merge
saveold "$p3\female_weai_ind_mod_we5b_NR_2016 06 06.dta", replace


use "$p1\102_r2_weai_ind_mod_we5c_female.dta", clear
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

tab hh_type
keep if hh_type==2 | hh_type==3


bysort wa01: gen dup=_n
tab dup
drop dup
duplicates report
merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
*5397 female respondents
keep if _merge==3
drop _merge
saveold "$p3\female_weai_ind_mod_we5c_NR_2016 06 06.dta", replace

use "$p1\104_r2_weai_ind_mod_we6a_female.dta", clear
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

tab hh_type
keep if hh_type==2 | hh_type==3

duplicates report
duplicates drop

merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta" //_merge==1 mismatch from 1614 entries (so drop)
keep if _merge==3
drop _merge
saveold "$p3\female_weai_ind_mod_we6a_NR_2016 06 06.dta", replace


use "$p1\106_r2_weai_ind_mod_we6b_female.dta", clear
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

tab hh_type
keep if hh_type==2 | hh_type==3


bysort wa01: gen dup=_n
tab dup
drop dup

duplicates report
merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
*5397 female respondents
keep if _merge==3
drop _merge
saveold "$p3\female_weai_ind_mod_we6b_NR_2016 06 06.dta", replace

use "$p1\108_r2_weai_ind_mod_we7_female.dta", clear
merge n:1 a01 using "$p3\female_mod_a_NR_2016 06 06.dta", keepusing (hh_type)
keep if _merge==3
drop _merge

tab hh_type
keep if hh_type==2 | hh_type==3


bysort wa01: gen dup=_n
tab dup
drop dup
duplicates report
merge m:1 a01 using "$p3\NR 2016 06 06 hhweight_BIHS round 2.dta"
*5397 female respondents
keep if _merge==3
drop _merge
saveold "$p3\female_weai_ind_mod_we7c_NR_2016 06 06.dta", replace

*************merging female files

use "$p3\female_mod_a_NR_2016 06 06.dta", clear
gen wa01=a01
*drop div
merge 1:1 a01 using "$p3\female_weai_ind_mod_wa_NR_2016 06 06.dta"
keep if _merge==3
drop _merge 
gen keep=1

recode wa04 (12=2) if a01==4686 
gen mid=wa04


merge 1:1 a01 mid using "$p3\male_mod_b1_NR_2016 06 06.dta"
keep if keep==1
drop _merge

merge 1:1 a01 using "$p3\female_weai_ind_mod_we2_NR_2016 06 06.dta"
keep if _m==3
drop _merge
merge 1:1 a01 using "$p3\female_weai_ind_mod_we3a_NR_2016 06 06.dta"
keep if _m==3

drop _merge
merge 1:1 a01 using "$p3\female_weai_ind_mod_we3d_NR_2016 06 06.dta"
keep if _m==3

drop _merge
merge 1:1 a01 using "$p3\female_weai_ind_mod_we3b_NR_2016 06 06.dta"
keep if _m==3

drop _merge
merge 1:1 a01 using "$p3\female_weai_ind_mod_we3c_NR_2016 06 06.dta"
keep if _m==3

drop _merge
merge 1:1 a01 using "$p3\female_weai_ind_mod_we4_NR_2016 06 06.dta.dta"
keep if _m==3

drop _merge
merge 1:1 a01 using "$p3\female_weai_ind_mod_we5a_NR_2016 06 06.dta"
keep if _m==3

drop _merge
merge 1:1 a01 using "$p3\female_weai_ind_mod_we5a_NR_2016 06 06.dta"
keep if _m==3

drop _merge
merge 1:1 a01 using "$p3\female_weai_ind_mod_we5b_NR_2016 06 06.dta"
keep if _m==3

drop _merge
merge 1:1 a01 using "$p3\female_weai_ind_mod_we5c_NR_2016 06 06.dta"
keep if _m==3

drop _merge
merge 1:1 a01 using "$p3\female_weai_ind_mod_we6b_NR_2016 06 06.dta"
keep if _m==3

drop _merge
merge 1:1 a01 using "$p3\female_weai_ind_mod_we7c_NR_2016 06 06.dta"
keep if _m==3

drop _merge //5396 female respondents

//keep if wgt_new!=.
**************************************************drop District_Name- hh_type hh_type wa07- wa12 b1_05 b1_06
//drop  Upazila- hh_type  a02- a12 a16_dd- Flagaddl  regnm- FLAG_SMPL  dvcode quintile_ftf1- quintile_bihs3  wa07- wa12
saveold "$p3\female_weai_variables_NR_round2.dta", replace

**********************************************************************************************************************************************
****************************************************
**************************************************
**appending male and female files (generating a variable "file" for separating the files)

use "$p3\male_weai_variables_NR_round2.dta", clear
gen file=1
append using "$p3\female_weai_variables_NR_round2.dta"
recode file .=2
label variable file "data from male or female file"
label define file 1 "male file" 2 "female file"
label value file file
tab file
//drop district_name upazila_name union_name village_name
//order wa01 division dcode-sample_t census-wg06_m hhsize-file a01
saveold "$p3\male_female_weai_NR_appended_round2.dta", replace

use "$p3\male_female_weai_NR_appended_round2.dta", clear

 /*Module 6a: Female*/
set more off

use "$p3\female_weai_ind_mod_we6a_NR_2016 06 06.dta", clear
 *use "V:\PHN\SHARED\Nusrat\BIHS round 2\WEAI_Round II_USB\hh_Female\female_weai_ind_mod_we6a_002.dta", clear
 gen field_f1=0

********Duplicate Check*********
*drop if flag!=.
*duplicates list a01 wacode

*we6a01_0400 we6a01_0345
*********Range Checks*********
*Checks that response codes correspond to survey
foreach x of var we6a01_0400-we6a01_0345{
	list a01 `x' if `x'!=1 & `x'!=2 & `x'!=.
}

*Flags if a05 is missing
//list a01 a05 acode if a05==.
*Flags if a01 is missing
list a01 wacode if a01==.

*********Consistency Checks*********
*Checks for gaps (i.e., periods for which no primary activity is recorded) 
*or overlaps (i.e., periods for which two primary activities are recorded)
drop if wps==2
collapse (sum) we6a01_0400-we6a01_0345 , by(a01)
foreach x of var  we6a01_0400-we6a01_0345{
	rename `x' sum1_`x'
	}
saveold "$p3\female_weai_ind_mod_we6a_NR_collapsedmerged1.dta", replace

use "$p3\female_weai_ind_mod_we6a_NR_2016 06 06.dta", clear
 *use "V:\PHN\SHARED\Nusrat\BIHS round 2\WEAI_Round II_USB\hh_Female\female_weai_ind_mod_we6a_002.dta", clear
 *use "female_weai_ind_mod_f01_5503_March28.dta", clear
*drop if flag!=.
drop if wps==1
collapse (sum) we6a01_0400-we6a01_0345, by(a01)
foreach x of var we6a01_0400-we6a01_0345{
	rename `x' sum2_`x'
	}
*saveold "female_weai_ind_mod_f01_5503_collapsed2March28.dta", replace
saveold "$p3\female_weai_ind_mod_we6a_NR_collapsedmerged2.dta", replace

 use "$p3\female_weai_ind_mod_we6a_NR_2016 06 06.dta", clear
 *use "female_weai_ind_mod_f01_5503_March28.dta", clear
*drop if flag!=.
merge m:1 a01 using "$p3\female_weai_ind_mod_we6a_NR_collapsedmerged1.dta"
*keep if _m==3
drop _merge
merge m:1 a01 using "$p3\female_weai_ind_mod_we6a_NR_collapsedmerged2.dta"
*keep if _m==3
drop _merge

*Calculate total time spent in each activity (in minutes)
foreach x of var we6a01_0400-we6a01_0345{
	qui replace `x'=0 if `x'==.
	}
*Primary activities
gen we6a01_1=0
foreach x of var we6a01_0400-we6a01_0345{
	qui bys a01 wacode: replace we6a01_1=we6a01_1+1 if (`x'==1 & wps==1) ///
	| (`x'==1 & wps==2 & sum1_`x'==0) 
	}
gen adjust2=0	
foreach x of var we6a01_0400-we6a01_0345{
	qui bys a01 wacode: replace adjust2=adjust2+1 if `x'==1 & wps==2 ///
	& sum1_`x'==0 & sum2_`x'==2
	}	
gen pri_adjust1=adjust2/2
gen adjust3=0	
foreach x of var we6a01_0400-we6a01_0345{
	qui bys a01 wacode: replace adjust3=adjust3+1 if `x'==1 & wps==2 ///
	& sum1_`x'==0 & sum2_`x'==3
	}	
gen pri_adjust2=adjust3*2/3

replace we6a01_1=(we6a01_1-pri_adjust1-pri_adjust2)*15

*Secondary activities
gen we6a01_2=0
foreach x of var we6a01_0400-we6a01_0345{
	qui bys a01 wacode: replace we6a01_2=we6a01_2+1 if `x'==1 & wps==2 ///
	& sum1_`x'==1
	}
gen sec_adjust1=adjust2/2	
gen sec_adjust2=adjust3/3

qui replace we6a01_2=(we6a01_2+sec_adjust1+sec_adjust2)*15
drop adjust* pri_* sec_*
label variable we6a01_1 "Minutes spent in [ACTIVITY] (as primary)"
label variable we6a01_2 "Minutes spent in [ACTIVITY] (as secondary)"

drop wps-we6a01_0345 sum*

save "$p3\female_weai_ind_mod_we6a_NR_collapsedmerged.dta", replace



***************************************************************************************************************************
/*Module F1: Male*/


set more off

use "$p3\male_weai_ind_mod_we6a_NR_2016 06 06.dta", clear
*use "male_weai_ind_mod_f01_5503_March28.dta", clear
//drop if sample_type==1
gen field_f1=0

********Duplicate Check*********
*drop if flag!=.
*duplicates list a01 wacode

*********Range Checks*********
*Checks that response codes correspond to survey
foreach x of var we6a01_0400-we6a01_0345{
	list a01 `x' if `x'!=1 & `x'!=2 & `x'!=.
}

*Flags if a05 is missing
//list a01 a05 acode if a05==.
*Flags if a01 is missing
list a01 wacode if a01==.

*********Consistency Checks*********
*Checks for gaps (i.e., periods for which no primary activity is recorded) 
*or overlaps (i.e., periods for which two primary activities are recorded)
drop if wps==2
collapse (sum) we6a01_0400-we6a01_0345 , by(a01)
foreach x of var  we6a01_0400-we6a01_0345{
	rename `x' sum1_`x'
	}

saveold "$p3\male_weai_ind_mod_we6a_NR_collapsedmerged1.dta", replace

use "$p3\male_weai_ind_mod_we6a_NR_2016 06 06.dta", clear
*use "male_weai_ind_mod_f01_5503_March28.dta", clear
*drop if flag!=.
drop if wps==1
collapse (sum) we6a01_0400-we6a01_0345, by(a01)
foreach x of var we6a01_0400-we6a01_0345{
	rename `x' sum2_`x'
	}
*saveold "male_weai_ind_mod_f01_5503_collapsed2March28.dta", replace
saveold "$p3\male_weai_ind_mod_we6a_NR_collapsedmerged2.dta", replace

use "$p3\male_weai_ind_mod_we6a_NR_2016 06 06.dta", clear
*use "male_weai_ind_mod_f01_5503_March28.dta", clear
merge m:1 a01 using "$p3\male_weai_ind_mod_we6a_NR_collapsedmerged1.dta"

drop _merge
merge m:1 a01 using "$p3\male_weai_ind_mod_we6a_NR_collapsedmerged2.dta"

drop _merge

*Calculate total time spent in each activity (in minutes)
foreach x of var we6a01_0400-we6a01_0345{
	qui replace `x'=0 if `x'==.
	}
*Primary activities
gen we6a01_1=0
foreach x of var we6a01_0400-we6a01_0345{
	qui bys a01 wacode: replace we6a01_1=we6a01_1+1 if (`x'==1 & wps==1) ///
	| (`x'==1 & wps==2 & sum1_`x'==0) 
	}
gen adjust2=0	
foreach x of var we6a01_0400-we6a01_0345{
	qui bys a01 wacode: replace adjust2=adjust2+1 if `x'==1 & wps==2 ///
	& sum1_`x'==0 & sum2_`x'==2
	}	
gen pri_adjust1=adjust2/2
gen adjust3=0	
foreach x of var we6a01_0400-we6a01_0345{
	qui bys a01 wacode: replace adjust3=adjust3+1 if `x'==1 & wps==2 ///
	& sum1_`x'==0 & sum2_`x'==3
	}	
gen pri_adjust2=adjust3*2/3

replace we6a01_1=(we6a01_1-pri_adjust1-pri_adjust2)*15

*Secondary activities
gen we6a01_2=0
foreach x of var we6a01_0400-we6a01_0345{
	qui bys a01 wacode: replace we6a01_2=we6a01_2+1 if `x'==1 & wps==2 ///
	& sum1_`x'==1
	}
gen sec_adjust1=adjust2/2	
gen sec_adjust2=adjust3/3

qui replace we6a01_2=(we6a01_2+sec_adjust1+sec_adjust2)*15
drop adjust* pri_* sec_*
label variable we6a01_1 "Minutes spent in [ACTIVITY] (as primary)"
label variable we6a01_2 "Minutes spent in [ACTIVITY] (as secondary)"

drop wps-we6a01_0400 sum*

save "$p3\male_weai_ind_mod_we6a_NR_collapsedmerged.dta", replace


/*****************merging 6a and 6b*************************/

use "$p3\male_weai_ind_mod_we6a_NR_collapsedmerged.dta", clear
merge n:1 a01 using "$p3\male_weai_ind_mod_we6b_NR_2016 06 06.dta"
keep if _m==3
drop _m
gen file=1
saveold "$p3\male_weai_ind_mod_we6a6b_NR.dta", replace

use "$p3\female_weai_ind_mod_we6a_NR_collapsedmerged.dta", clear
merge n:1 a01 using "$p3\female_weai_ind_mod_we6b_NR_2016 06 06.dta"
*keep if _m==3
drop _m
saveold "$p3\female_weai_ind_mod_we6a6b_NR.dta", replace

append using "$p3\male_weai_ind_mod_we6a6b_NR.dta"
recode file .=2
label variable file "data from male or female file"
label define file 1 "male file" 2 "female file"
label value file file
tab file
gen country=1

saveold "$p3\male_female_weai_ind_mod_we6a6b_NR.dta", replace

************ END this part****
