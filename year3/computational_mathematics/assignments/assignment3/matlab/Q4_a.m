roc_male_2006 = ((2006-2003) / ((2002-2003)*(2002-2006)))*(638182) ...
				+((2006-2002) / ((2003-2002)*(2003-2006)))*(646493) ...
				+(((2*2006)-2002-2003) / ((2006-2002)*(2006-2003)))*(665647);
            
fprintf("\n%d",roc_male_2006);

roc_female_2006 = ((2006-2003) / ((2002-2003)*(2002-2006)))*(215005) + ...
				  ((2006-2002) / ((2003-2002)*(2003-2006)))*(225042) + ...
				  (((2*2006)-2002-2003) / ((2006-2002)*(2006-2003)))*(256257);
fprintf("\n%d",roc_female_2006);