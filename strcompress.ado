/*
strcompress: Stata module for maximally compressing string variables
Author:  Luke Stein
Contact: lcdstein@babson.edu
Date:    2019-01-28
Version: 0.1
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
	}
	
	compress `varlist'
	
	qui memory
	local newmem = `r(data_data_u)' + `r(data_strl_u)'
	local savingsfrac = 1-(`newmem' / `oldmem')
	
	disp as text "  strcompress saved " as result %2.1f = 100*`savingsfrac' "%" as text " overall"

end
