
# Create tmp/trains directory if it doesn't exist
mkdir -p tmp/trains

# Iterate through git log for currentTrains.xml
git log --pretty=format:"%H %at" -- currentTrains.xml | while read COMMIT TS; do
	OUTFILE="tmp/trains/${TS}.xml"
	# Only extract if file doesn't already exist
	if [ ! -f "$OUTFILE" ]; then
		echo "Extracting $OUTFILE from commit $COMMIT"
		git show ${COMMIT}:currentTrains.xml > "$OUTFILE"
	else
		echo "Skipping $OUTFILE (already exists)"
	fi
done

# Convert tmp/trains/*.xml to CSV
for XMLFILE in tmp/trains/*.xml; do
	TS=$(basename "$XMLFILE" .xml)
	CSVFILE="tmp/trains/${TS}.csv"
	if [ ! -f "$CSVFILE" ]; then
		echo "Converting $XMLFILE to $CSVFILE"
					xmlstarlet sel -T -t -m '/*[local-name()="ArrayOfObjTrainPositions"]/*[local-name()="objTrainPositions"]' \
						-v 'concat('"$TS"',",",./*[local-name()="TrainCode"],",",./*[local-name()="TrainStatus"],",",./*[local-name()="TrainLatitude"],",",./*[local-name()="TrainLongitude"],",",./*[local-name()="TrainDate"],",",./*[local-name()="PublicMessage"],",",./*[local-name()="Direction"])' \
						-n "$XMLFILE" \
						| awk 'BEGIN {print "Time,TrainCode,TrainStatus,TrainLatitude,TrainLongitude,TrainDate,PublicMessage,Direction"} {print}' > "$CSVFILE"
	else
		echo "Skipping $CSVFILE (already exists)"
	fi
done

# Create tmp/stations directory if it doesn't exist
mkdir -p tmp/stations

# Iterate through git log for stations.xml
git log --pretty=format:"%H %at" -- stations.xml | while read COMMIT TS; do
	OUTFILE="tmp/stations/${TS}.xml"
	# Only extract if file doesn't already exist
	if [ ! -f "$OUTFILE" ]; then
		echo "Extracting $OUTFILE from commit $COMMIT"
		git show ${COMMIT}:stations.xml > "$OUTFILE"
	else
		echo "Skipping $OUTFILE (already exists)"
	fi
done
