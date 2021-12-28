**************************************************
*******   FIVE DOMAINS EMPOWERMENT (5DE)   *******
**************************************************
// So far all_indicators were defined so 1 identifies adequate. //
// Now we transform indicators so 1 identifies inadequate. //
use "/Users/satwikav/Documents/GitHub/thesis/data/weai/all_indicators.dta",clear
// So far all_indicators were defined so 1 identifies adequate. //
// Now we transform indicators so 1 identifies inadequate. //
foreach var in  feelinputdecagr raiprod_any jown_count jrightanyagr credjanydec_any incdec_count groupmember_any speakpublic_any npoor_z105 leisuretime {
	rename `var' `var'_ndepr
	gen `var'=1 if `var'_ndepr==0
	replace `var'=0 if `var'_ndepr==1
	}

*****************************************************************************
********  Create a local variable with all your indicators varlist_emp ******
*****************************************************************************

#delimit;
local varlist_5do feelinputdecagr raiprod_any jown_count jrightanyagr credjanydec_any incdec_count groupmember_any speakpublic_any npoor_z105 leisuretime;

gen sample5do=(feelinputdecagr~=. & raiprod_any~=. & jown_count~=. & jrightanyagr~=.& credjanydec_any~=. & incdec_count~=. & groupmember_any~=. & speakpublic_any~=. & npoor_z105~=. & leisuretime~=.);
#delimit cr

******************************
**** Define the weights.  ****
******************************

foreach var in feelinputdecagr raiprod_any{
	gen w_`var'=1/10
	}
foreach var in jown_count jrightanyagr credjanydec_any {
	gen w_`var'=1/15
	}
foreach var in incdec_count {
	gen w_`var'=1/5
	}
foreach var in groupmember_any speakpublic_any {
	gen w_`var'=1/10
	}
foreach var in npoor_z105 leisuretime{
	gen w_`var'=1/10
	}

	
**********************************************************
*********     Define the weigted inadequacy g0*      ****
**********************************************************

foreach var in `varlist_5do'{
	gen wg0_`var'= `var'*w_`var'
	}

********************************************************************************
*************   Define the (weighted) inadequacy count vector "ci" ************
********************************************************************************

egen ci=rsum(wg0_*)
replace ci = . if sample5do==0

label variable ci "Inadequacy Count without Parity"




