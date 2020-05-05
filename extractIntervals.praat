##### take two arguments (input_directory, output_file) #####

form extract intervals
	sentence input_dir
	sentence output_file
endform
	select all


writeFileLine ("'output_file$'", "Speaker	", "File	", "Interval label	", "Interval start [ms]	", "Interval end [ms]	", "Interval duration [ms]")


##### main programme #####

Create Strings as file list... list 'input_dir$'/*.wav
numberOfFiles = Get number of strings

for ifile to numberOfFiles

	select Strings list
	fileName$ = Get string: ifile
	base$ = fileName$ - ".wav"

	# Read the Sound file
	Read from file... 'input_dir$'/'base$'.wav
	Open long sound file: input_dir$ + "/"+ base$ + ".wav"
	# Read the TextGrid
	Read from file... 'input_dir$'/'base$'.TextGrid

	# Get the speaker's ID
	speakersId$ = left$ (base$, 3)


	#Get the name of each interval
	select TextGrid 'base$'
	numberOfIntervals = Get number of intervals: 1

	for n to numberOfIntervals
		select TextGrid 'base$'
		intervalLabel$ = Get label of interval: 1, n

		if intervalLabel$ <> ""
		@extract_intervals
		endif
	endfor

##### Final cleaning and info (display when run in GUI) #####
select all
minus Strings list
Remove
endfor

echo The file has been created. 
printline You can find it here 'input_dir$'.




##### Extract intervals #####

procedure extract_intervals
	appendFile ("'output_file$'", "'speakersId$'	", "'base$'	", "'intervalLabel$'	")
	.intervalStart = Get start point: 1, n
	.intervalEnd = Get end point: 1, n
	.intervalDur = .intervalEnd - .intervalStart
	.intervalStartms = .intervalStart*1000
	.intervalEndms= .intervalEnd*1000
	.intervalDurms = .intervalDur*1000
	.intervalStartms$ = fixed$ (.intervalStartms, 0)
	.intervalEndms$ = fixed$ (.intervalEndms, 0)
	.intervalDurms$ = fixed$ (.intervalDurms, 0)


	select LongSound 'base$'
	#if the interval is less than 0-030 the value 2 = intervalEnd
	.targetEnd = .intervalStart + 0.030
	if .targetEnd > .intervalEnd
		.targetEnd = .intervalEnd
	endif
	printline '.intervalStart' - '.intervalEnd' targetEnd: '.targetEnd'


	appendFile: output_file$, .intervalStartms$, tab$, .intervalEndms$, tab$, .intervalDurms$, newline$


endproc