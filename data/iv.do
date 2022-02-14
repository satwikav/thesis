***************************************
//INSTRUMENTS
****************************************
//hh info
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 community_id
save "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta", replace
//freedom of mobility
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/121_bihs_r3_female_mod_z1.dta", clear
keep a01 res_id_z12
rename res_id_z12 z3_mid
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/122_bihs_r3_female_mod_z2.dta"
keep a01 z2_01_1 z2_02_1 z2_03_1 z2_04_1 z2_05_1 z3_mid
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
//gen mobility_score = score/5
keep a01 mobility_score z3_mid
rename z3_mid mid
merge 1:1 a01 using  "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta", replace
//value of assets brought during marriage
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/125_bihs_r3_female_mod_z5.dta", clear
keep a01 res_id_z5 z5_03 
rename res_id_z5 mid
collapse (sum) z5_03, by(a01 mid)
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta"
drop _merge
rename z5_03 dowry_value
rename mid mid_female
gen log_dowry = ln(dowry_value)
save "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta", replace
//community level empowermnet level 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta",clear
keep a01 community_id
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai_new/female_score.dta"
collapse (mean) ci, by(community_id)
rename ci avg_empw_female
merge 1:m community_id using "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta", replace
//religious diversity at village level
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/009_bihs_r3_male_mod_a.dta", clear
keep a01 a13 community_id a27
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta"
keep a01 mid a13 community_id a27
gen population = 1 if community_id != .
gen muslim = 0
replace muslim = 1 if a13 == 1
gen hindu = 0
replace hindu = 1 if a13 == 2
gen other = 0
replace other = 1 if a13 == 5
collapse (sum) population muslim hindu other, by(community_id)
gen muslim_share = muslim/population
gen hindu_share = hindu/population
gen other_share = other/population
gen muslim_share_sq = muslim_share ^ 2
gen hindu_share_sq = hindu_share  ^ 2
gen other_share_sq = other_share  ^ 2
egen summ_share = rowtotal(muslim_share_sq hindu_share_sq other_share_sq)
gen ELF = 1 - summ_share
keep ELF community_id 
merge 1:m community_id using "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta"
drop _merge community_id
save "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta", replace
//value of assets brought during marriage (dummy)
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/125_bihs_r3_female_mod_z5.dta", clear
keep a01 res_id_z5 z5_01
rename res_id_z5 mid_female
gen marriage_asset = 0
replace marriage_asset = 1 if z5_01 == 1
replace marriage_asset = . if z5_01 == .
drop z5_01
collapse (max) marriage_asset, by(a01 mid_female)
merge 1:1 a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta", replace
//marriage decision 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/138_bihs_r3_female_weai_ind_mod_we7b.dta", clear
gen marr_force = 1
replace marr_force = 0 if we7b_15 == 1 | we7b_15 == 2
replace marr_force = 0.5 if we7b_15 == 3 | we7b_15 == 5
replace marr_force = . if we7b_15 == . | we7b_15 == 96
keep a01 marr_force
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta", replace
//clothes and medicines for yourself
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/121_bihs_r3_female_mod_z1.dta", clear
rename res_id_z12 mid_female
gen purchases_1 = z1_16b
replace purchases_1 = 0 if z1_16b == 2
gen purchases_2 = z1_16c
replace purchases_2 = 0 if z1_16c == 2
gen purchases_3 = z1_16d
replace purchases_3 = 0 if z1_16d == 2
egen purchase_score = rowtotal(purchases_1 purchases_2 purchases_3)
replace purchase_score = . if purchases_1 == . & purchases_2 == . & purchases_3 == .
keep a01 purchase_score
merge 1:m a01 using "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta", replace

//husband consumes drugs
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/124_bihs_r3_female_mod_z4.dta", clear
rename z4_mid mid_female 
gen drinks = 0 
replace drinks = 1 if z4_09 == 1 | z4_09a == 1
replace drinks = . if z4_09 == . & z4_09a == .
gen drugs = 0 
replace drugs = 1 if z4_10 == 1 | z4_10a == 1
replace drugs = . if z4_10 == . & z4_10a == .
egen drug_score = rowtotal(drinks drugs)
replace drug_score = . if drinks == . & drugs == .
keep a01 mid_female drinks drugs drug_score
merge 1:1 a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta"
drop if _m == 1
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta", replace







/*reproductive decisions
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/123_bihs_r3_female_mod_z3.dta", clear
rename z3_mid mid_female

gen repr_dec = 0 
replace repr_dec = 1 if z3_02 == 1
replace repr_dec = 0.5 if z3_02 == 3
replace repr_dec = . if z3_02 == .

keep a01 mid_female repr_dec z3_02 z3_01

duplicates tag a01, generate(dup_hh)
tab dup_hh
