***************************************
//INSTRUMENTS
****************************************
//freedom of mobility
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/121_bihs_r3_female_mod_z1.dta", clear
keep a01 res_id_z12
rename res_id_z12 mid_female
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/122_bihs_r3_female_mod_z2.dta"
keep a01 z2_01_1 z2_02_1 z2_03_1 z2_04_1 z2_05_1 mid_female
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
keep a01 mobility_score mid_female
save "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta", replace
//marriage decision 
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/126_bihs_r3_female_weai_ind_mod_wa.dta", clear
keep a01 wa04 
rename wa04 mid_female
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/138_bihs_r3_female_weai_ind_mod_we7b.dta"
keep a01 we7b_15 mid_female
gen marr_choice = 0
replace marr_choice = 1 if we7b_15 == 1 | we7b_15 == 2
replace marr_choice = 0.5 if we7b_15 == 3 | we7b_15 == 5
replace marr_choice = . if we7b_15 == .
keep a01 marr_choice mid_female
merge 1:m a01 mid_female using "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/instruments.dta", replace


