*******************************
***  MERGING OF DATASETS  ***
*******************************
/////////HH MEMBER INFO
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/010_bihs_r3_male_mod_b1.dta",clear
keep a01 mid b1_01 b1_03 
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/hh_1.dta",replace
/////////MALE WEAI MODS
//mod 1
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/078_bihs_r3_male_weai_ind_mod_wa.dta",clear
keep a01 wa04 wa05 wa06 
rename wa04 mid
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_1.dta",replace
//mod 2
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/079_bihs_r3_male_weai_ind_mod_we2.dta", clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_2.dta",replace
//mod 3a
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/080_bihs_r3_male_weai_ind_mod_we3a.dta", clear
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
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_3a.dta",replace
//mod 3b
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/081_bihs_r3_male_weai_ind_mod_we3b.dta", clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_3b.dta",replace
//mod 3c
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/082_bihs_r3_male_weai_ind_mod_we3c.dta", clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_3c.dta",replace
//mod 3d
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/083_bihs_r3_male_weai_ind_mod_we3d.dta", clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_3d.dta",replace
//mod 4
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/084_bihs_r3_male_weai_ind_mod_we4.dta", clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_4.dta",replace
//mod 5a
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/085_bihs_r3_male_weai_ind_mod_we5a.dta",clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_5a.dta",replace
//mod 5b
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/086_bihs_r3_male_weai_ind_mod_we5b.dta", clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_5b.dta",replace
//mod 5c
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/087_bihs_r3_male_weai_ind_mod_we5c.dta",clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_5c.dta",replace
//mod 6b
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/089_bihs_r3_male_weai_ind_mod_we6b.dta", clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_6b.dta",replace
//mod 7c
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/091_bihs_r3_male_weai_ind_mod_we7c.dta"
drop etime_h_weai etime_m_weai hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_7c.dta",replace
/////////MERGE MALE WEAI MODS
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/hh_1.dta", clear
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_1.dta"
drop if _merge==1
drop _merge 
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_2.dta"
drop _merge 
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_3a.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_3b.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_3c.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_3d.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_4.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_5a.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_5b.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_5c.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_6b.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_7c.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/male_weia.dta",replace
//Male mod 6a
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/088_bihs_r3_male_weai_ind_mod_we6a.dta", clear
drop if wps==2
collapse (sum) we6_0400-we6_0345 , by(a01)
foreach x of var  we6_0400-we6_0345 {
	rename `x' sum1_`x'
}
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_6a_1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/088_bihs_r3_male_weai_ind_mod_we6a.dta", clear
drop if wps==1
collapse (sum) we6_0400-we6_0345 , by(a01)
foreach x of var  we6_0400-we6_0345 {
	rename `x' sum2_`x'
}
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_6a_2.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Male/088_bihs_r3_male_weai_ind_mod_we6a.dta", clear
merge m:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_6a_1.dta"
drop _merge
merge m:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_6a_2.dta"
drop _merge
foreach x of var we6_0400-we6_0345 {
	qui replace `x'=0 if `x'==.
}	
*Primary activities
gen we6a01_1=0
foreach x of var we6_0400-we6_0345 {
	qui bys a01 wacode: replace we6a01_1=we6a01_1+1 if (`x'==1 & wps==1) ///
	| (`x'==1 & wps==2 & sum1_`x'==0) 
}
gen adjust2=0	
foreach x of var we6_0400-we6_0345 {
	qui bys a01 wacode: replace adjust2=adjust2+1 if `x'==1 & wps==2 ///
	& sum1_`x'==0 & sum2_`x'==2
}	
gen pri_adjust1=adjust2/2
gen adjust3=0	
foreach x of var we6_0400-we6_0345 {
	qui bys a01 wacode: replace adjust3=adjust3+1 if `x'==1 & wps==2 ///
	& sum1_`x'==0 & sum2_`x'==3
}	
gen pri_adjust2=adjust3*2/3
replace we6a01_1=(we6a01_1-pri_adjust1-pri_adjust2)*15
*Secondary activities
gen we6a01_2=0
foreach x of var we6_0400-we6_0345 {
	qui bys a01 wacode: replace we6a01_2=we6a01_2+1 if `x'==1 & wps==2 ///
	& sum1_`x'==1
}
gen sec_adjust1=adjust2/2	
gen sec_adjust2=adjust3/3
qui replace we6a01_2=(we6a01_2+sec_adjust1+sec_adjust2)*15
drop adjust* pri_* sec_*
label variable we6a01_1 "Minutes spent in [ACTIVITY] (as primary)"
label variable we6a01_2 "Minutes spent in [ACTIVITY] (as secondary)"
drop wps-we6_0345 sum*
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_6a.dta",replace
/////////MERGE MALE 6a & 6b WEAI MODS
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_6a.dta",replace
merge n:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_6b.dta"
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_6a6b.dta", replace
/////////FEMALE WEAI MODS
//mod 1
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/126_bihs_r3_female_weai_ind_mod_wa.dta", clear
keep a01 wa04 wa05 wa06 
rename wa04 mid
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_1.dta",replace
//mod 2
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/127_bihs_r3_female_weai_ind_mod_we2.dta", clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_2.dta",replace
//mod 3a
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/128_bihs_r3_female_weai_ind_mod_we3a.dta"
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
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_3a.dta",replace
//mod 3b
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/129_bihs_r3_female_weai_ind_mod_we3b.dta"
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_3b.dta",replace
//mod 3c
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/130_bihs_r3_female_weai_ind_mod_we3c.dta"
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_3c.dta",replace
//mod 3d
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/131_bihs_r3_female_weai_ind_mod_we3d.dta"
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_3d.dta",replace
//mod 4
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/132_bihs_r3_female_weai_ind_mod_we4.dta"
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_4.dta",replace
//mod 5a
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/133_bihs_r3_female_weai_ind_mod_we5a.dta"
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_5a.dta",replace
//mod 5b
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/134_bihs_r3_female_weai_ind_mod_we5b.dta", clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_5b.dta",replace
//mod 5c
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/135_bihs_r3_female_weai_ind_mod_we5c.dta",clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_5c.dta",replace
//mod 6b
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/137_bihs_r3_female_weai_ind_mod_we6b.dta", clear
drop hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_6b.dta",replace
//mod 7c
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/139_bihs_r3_female_weai_ind_mod_we7c.dta"
drop etime_h_weai etime_m_weai hhid2 hh_type round
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_7c.dta",replace
/////////MERGE MALE WEAI MODS
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/hh_1.dta", clear
merge 1:1 a01 mid using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_1.dta"
drop if _merge==1
drop _merge 
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_2.dta"
drop _merge 
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_3a.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_3b.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_3c.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_3d.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_4.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_5a.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_5b.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_5c.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_6b.dta"
drop _merge
merge 1:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_7c.dta"
drop _merge
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/female_weia.dta",replace
//Female mod 6a
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/136_bihs_r3_female_weai_ind_mod_we6a.dta", clear
drop if wps==2
collapse (sum) we6_0400-we6_0345 , by(a01)
foreach x of var  we6_0400-we6_0345 {
	rename `x' sum1_`x'
}
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_6a_1.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/136_bihs_r3_female_weai_ind_mod_we6a.dta", clear
drop if wps==1
collapse (sum) we6_0400-we6_0345 , by(a01)
foreach x of var  we6_0400-we6_0345 {
	rename `x' sum2_`x'
}
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_6a_2.dta",replace
use "/Users/satwikav/Documents/GitHub/thesis/BIHSRound3/Female/136_bihs_r3_female_weai_ind_mod_we6a.dta", clear
merge m:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_6a_1.dta"
drop _merge
merge m:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_6a_2.dta"
drop _merge
foreach x of var we6_0400-we6_0345 {
	qui replace `x'=0 if `x'==.
}	
*Primary activities
gen we6a01_1=0
foreach x of var we6_0400-we6_0345 {
	qui bys a01 wacode: replace we6a01_1=we6a01_1+1 if (`x'==1 & wps==1) ///
	| (`x'==1 & wps==2 & sum1_`x'==0) 
}
gen adjust2=0	
foreach x of var we6_0400-we6_0345 {
	qui bys a01 wacode: replace adjust2=adjust2+1 if `x'==1 & wps==2 ///
	& sum1_`x'==0 & sum2_`x'==2
}	
gen pri_adjust1=adjust2/2
gen adjust3=0	
foreach x of var we6_0400-we6_0345 {
	qui bys a01 wacode: replace adjust3=adjust3+1 if `x'==1 & wps==2 ///
	& sum1_`x'==0 & sum2_`x'==3
}	
gen pri_adjust2=adjust3*2/3
replace we6a01_1=(we6a01_1-pri_adjust1-pri_adjust2)*15
*Secondary activities
gen we6a01_2=0
foreach x of var we6_0400-we6_0345 {
	qui bys a01 wacode: replace we6a01_2=we6a01_2+1 if `x'==1 & wps==2 ///
	& sum1_`x'==1
}
gen sec_adjust1=adjust2/2	
gen sec_adjust2=adjust3/3
qui replace we6a01_2=(we6a01_2+sec_adjust1+sec_adjust2)*15
drop adjust* pri_* sec_*
label variable we6a01_1 "Minutes spent in [ACTIVITY] (as primary)"
label variable we6a01_2 "Minutes spent in [ACTIVITY] (as secondary)"
drop wps-we6_0345 sum*
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_6a.dta",replace
/////////MERGE FEMALE 6a & 6b WEAI MODS
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_6a.dta",replace
merge n:1 a01 using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_6b.dta"
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_6a6b.dta", replace
/////////APPEND MALE & FEMALE WEAI MODS
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/male_weia.dta",replace
gen file=1
append using "/Users/satwikav/Documents/GitHub/thesis/data/weai/female_weia.dta"
recode file .=2
label variable file "data from male or female file"
label define file 1 "male file" 2 "female file"
label value file file
tab file
drop if mid == .
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/weia.dta", replace
/////////APPEND MALE & FEMALE 6a & 6b WEAI MODS
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/m_6a6b.dta",replace
gen file=1
append using "/Users/satwikav/Documents/GitHub/thesis/data/weai/f_6a6b.dta"
recode file .=2
label variable file "data from male or female file"
label define file 1 "male file" 2 "female file"
label value file file
tab file
save "/Users/satwikav/Documents/GitHub/thesis/data/weai/weia_6a6b.dta", replace
