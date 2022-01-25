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
keep a01 b1_01 b1_02 mid
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
keep if b1_02 >= 4 & b1_02 < 18
rename b1_01 gender_child
rename b1_02 age_child
rename mid mid_child
save "/Users/satwikav/Documents/GitHub/thesis/data/outcome_2/child2.dta",replace 


