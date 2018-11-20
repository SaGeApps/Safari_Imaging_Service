

on run argv
	screenshot_active_window("/Users/SaGe/Pictures/temp.png")
end run

on screenshot_active_window(outputPath)
	set quotedPath to quoted form of outputPath
	
	-- get screen dimensions
	copy {do shell script "system_profiler SPDisplaysDataType | awk '/Resolution/{print $2}'", ¬
		do shell script "system_profiler SPDisplaysDataType | awk '/Resolution/{print $4}'"} to {scrn_w, scrn_h}
	
	tell application "System Events"
		set proc to name of first process whose frontmost is true
		tell window 1 of process proc
			-- get window initial position
			copy position to {ini_x, ini_y}
			copy size to {win_w, win_h}
			
			-- center window because the sips crop command automatically centers the cropped area in the image
			set position to {(scrn_w - win_w) / 2, (scrn_h - win_h) / 2}
		end tell
		
		-- capture the screen , crop the image and open it.
		do shell script "screencapture" & space & "-x" & space & quotedPath & "; sips -c" & space & (win_h) & space & (win_w) & space & quotedPath & space & "--out" & space & quotedPath & "; open" & space & quotedPath
		
		-- revert window position
		tell window 1 of process proc to set position to {ini_x, ini_y}
	end tell
end screenshot_active_window