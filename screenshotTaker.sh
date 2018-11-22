for j in $(cat ./ToScrap.txt)    
do
	open -a Safari "https://$j"
    sleep 3
    osascript -e 'tell application "Safari" perform action "AXZoomWindow"'
	# screencapture -R 100,100,300,300 $j.png
	screencapture $j.png
    echo "$j" 
    sleep 2
    osascript -e 'tell application "Safari" to close current tab of front window without saving'
    osascript ../Safari_Imaging_Service/"safari maximizer".scpt 

done
