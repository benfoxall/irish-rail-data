
curl https://api.irishrail.ie/realtime/realtime.asmx/getCurrentTrainsXML > currentTrains.xml
curl https://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML > stations.xml

git add currentTrains.xml
git add stations.xml

git commit --no-gpg-sign --author="Scrape Bot <bot@benjaminbenben.com>" -m ":robot: Train data"
