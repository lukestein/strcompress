/*
strcompress: Stata module for maximally compressing string variables
Author:  Luke Stein
Contact: lcdstein@babson.edu
Date:    2019-01-28
Version: 0.2
*/

capture program drop strcompress
program define strcompress

    version 13.0
	syntax [varlist]
	
	qui memory
	local oldmem = `r(data_data_u)' + `r(data_strl_u)'
	
	qui ds `varlist', has(type str#)
	
	if "`r(varlist)'" != "" {
		disp as text "  Converting " as result "str" as text " to " as result "strL" as text ": `r(varlist)'"
		qui recast strL `r(varlist)'
		
		qui memory
		local midmem = `r(data_data_u)' + `r(data_strl_u)'

		if `midmem' <= `oldmem' {
			local savingsfrac = 1-(`midmem' / `oldmem')
			disp as text "    strcompress shrank data " as result %1.0f = 100*`savingsfrac' "%" as text " so far"
		}
		else {
			local savingsfrac = (`midmem' / `oldmem')-1
			disp as text "    strcompress grew data " as result %1.0f = 100*`savingsfrac' "%" as text " so far, but I'm not done yet!"
		}
	
	}
	else {
		qui memory
		local midmem = `r(data_data_u)' + `r(data_strl_u)'
	}
	
	
	compress `varlist'
	
	qui memory
	local newmem = `r(data_data_u)' + `r(data_strl_u)'

	local savingsfrac = 1-(`newmem' / `midmem')
	disp as text "       compress shrank data " as result %2.0f = 100*`savingsfrac' "%"

	local savingsfrac = 1-(`newmem' / `oldmem')
	disp as text "    strcompress shrank data " as result %2.0f = 100*`savingsfrac' "%" as text " overall"

end
