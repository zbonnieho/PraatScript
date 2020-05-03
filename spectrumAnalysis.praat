##### Args: output_filename, input_dir #####

form Spectral analysis	
	sentence txtName
	sentence folder
endform
	select all

txtNameExtension$= txtName$+ ".txt"

writeFileLine ("'txtName$'.txt", "Speaker	", "File	", "Interval label	", "Interval start [ms]	", "Interval end [ms]	", "Interval duration [ms]	", "Min intensity	", "Max intensity	", "Mean intensity	", "Center of gravity	", "Standard deviation	", "Skewness	", "Kurtosis")


##### main programme #####
