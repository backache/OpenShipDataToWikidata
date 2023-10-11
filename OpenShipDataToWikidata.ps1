#Go through a list of Wikidata ID's that have MMSI's and backfill any missing data it can find from the API of OpenShipData
#example thames clippers and thames luxury charters 
$Q = 'Q75345','Q474975','Q674423','Q674949','Q901855','Q1275226','Q1375227','Q1794897','Q1815076','Q2119654','Q2376481','Q3334298','Q3334391','Q3431317','Q3492518','Q3574484','Q4043306','Q4352699','Q4650910','Q5009513','Q5009518','Q5009557','Q5009575','Q5629230','Q5633490','Q5634323','Q6719208','Q6719396','Q6719993','Q6720063','Q6954811','Q7278037','Q7393317','Q7457619','Q7577978','Q7866042','Q7866087','Q7866138','Q7866195','Q7866234','Q7866241','Q7866290','Q7927055','Q7969730','Q10335157','Q11671871','Q11708154','Q11708560','Q15179941','Q16850024','Q16958282','Q18151016','Q18711691','Q19386019','Q20010342','Q20380205','Q23135788','Q23806451','Q24871265','Q26742202','Q28127191','Q28229417','Q28455946','Q29578366','Q36847711','Q48205284','Q51332944','Q52294743','Q52296668','Q52311492','Q52322066','Q52336003','Q104380732','Q104382447','Q105047111','Q105764357','Q105770081','Q108606958','Q115573695','Q117009530','Q117011440','Q117023017','Q117024639','Q117028289','Q117028492','Q117042413','Q117071036','Q117071879','Q117071910','Q117073321','Q117073424','Q895397','Q935045','Q1335175','Q1352893','Q1500875','Q1800244','Q2377766','Q2881620','Q2941215','Q16038974','Q18155068','Q18410568','Q22670074','Q23900529','Q24639032','Q26931406','Q27902765','Q29954710','Q29954712','Q42291404','Q42415185','Q47543042','Q48752872','Q50016014','Q52295307','Q52296660','Q52311149','Q52311681','Q52314040','Q52314084','Q52314667','Q52314942','Q52317618','Q52320699','Q52325874','Q52329217','Q52329346','Q52332097','Q52334227','Q52334262','Q52336013','Q52337271','Q52337348','Q52338993','Q52350728','Q52377816','Q52380107','Q104378734','Q111094438','Q115573727','Q115573731','Q115573849','Q117009597','Q117009839','Q117010393','Q117023012','Q117027507','Q117036415','Q117066875','Q117073591','Q117073811','Q117076427','Q117076717','Q117077476','Q117077532','Q117079752','Q117079837','Q117080289','Q117109000','Q117115646','Q122796057','Q3334285','Q3334301','Q3442605','Q5009508','Q5009514','Q5427005','Q5427344','Q5630245','Q5630320','Q5630648','Q5632217','Q5634722','Q5735661','Q5799933','Q6376947','Q6382064','Q6719640','Q7072945','Q7276486','Q7393667','Q7432739','Q7866009','Q7866117','Q7866148','Q7866153','Q7866163','Q7866270','Q7866275','Q7866272','Q7866273','Q7866693','Q7873375','Q11296332','Q11703527','Q11707090','Q11709947','Q52314698','Q52316102','Q52316236','Q52316854','Q52321829','Q52325626','Q52326030','Q52326466','Q52332059','Q52333546','Q52336202','Q52336211','Q52336732','Q52337128','Q52337339','Q52337674','Q52343404','Q52345314','Q52352890','Q52379952','Q52512373','Q104515511','Q105333730','Q105764918','Q117011453','Q117036421','Q117037837','Q117073865','Q117081737','Q117082098','Q117083208','Q117110940','Q5634430','Q16199823','Q16960946','Q18786353','Q19376699','Q25106391','Q25414530','Q25936055','Q26267385','Q30603534','Q42290107','Q52350037','Q52353618','Q52380307','Q52508386','Q52508782','Q52510044','Q52512493','Q55638178','Q56885356','Q56885518','Q60775815','Q99429695','Q105765400','Q105768034','Q106627001','Q109537891','Q110815479','Q111936667','Q112325530','Q113073660','Q113638788','Q113639161','Q114457673','Q115483530','Q115483537','Q115483554','Q115483559','Q115483556','Q115571277','Q115571284','Q115572231','Q115572246','Q115572247','Q115572296','Q115572305','Q115572327','Q115572360','Q115572368','Q115572374','Q115572419','Q115572439','Q115572436','Q115572488','Q115572498','Q115572624','Q115572629','Q115572636','Q115572663','Q115572681','Q115572691','Q115572700','Q115572701','Q115572719','Q115572726','Q115573535','Q115573541','Q115573559','Q115573582','Q115573624','Q115573634','Q115573643','Q115573653','Q115573665','Q115573678','Q115573694','Q115573708','Q115573723','Q115573724','Q115573747','Q115573748','Q115573762','Q115573771','Q115573806','Q115573824','Q115573844','Q115573862','Q115573874','Q115573889','Q115573896','Q115573938','Q115573939','Q115573942','Q115573944','Q115573951','Q115573962','Q115573980','Q115573994','Q115574002','Q115574010','Q115574026','Q115574033','Q115574042','Q115574047','Q115574044','Q115574049','Q115574070','Q115574072','Q115574097','Q117008722','Q117021200','Q117021680','Q117021834','Q117023056','Q117023646','Q117023958','Q117024294','Q117024295','Q117024334','Q117024439','Q117028707','Q117036086','Q117036186','Q117036524','Q117036944','Q117067301','Q117070815','Q117071526','Q117072958','Q117073475','Q117077308','Q117078096','Q117103064','Q117103279','Q117103813','Q117113593','Q80632','Q1143837','Q1258382','Q2285940','Q3018097','Q3098703','Q3360200','Q3374613','Q3374618','Q3592468','Q4353773','Q52295734','Q52310871','Q52314167','Q52315059','Q52315242','Q52315276','Q52315359','Q52316268','Q52324758','Q52332443','Q52333864','Q52334085','Q52334250','Q52335041','Q52335818','Q52336037','Q52340984','Q52345045','Q55643118','Q56885336','Q60061417','Q64796931','Q83632578','Q83645707','Q83650670','Q85795449','Q89117013','Q104034834','Q105766721','Q108044459','Q108198133','Q108295556','Q115571252','Q115571269','Q115571286','Q115572241','Q115572261','Q115572351','Q115572354','Q115572355','Q115572371','Q115572396','Q115572407','Q115572490','Q115572646','Q115572692','Q115572698','Q115572696','Q115572723','Q115572720','Q115573521','Q115573551','Q115573563','Q115573560','Q115573702','Q115573800','Q115573865','Q115573917','Q115573954','Q115573982','Q115574011','Q115574041','Q115574053','Q115574099','Q115945896','Q116444079','Q117011419','Q117018378','Q117036129','Q117036198','Q117050250','Q117102262','Q117103122','Q2554','Q4993879','Q5009493','Q5009523','Q5009569','Q5630379','Q5630435','Q5630531','Q5630687','Q6107975','Q6719186','Q6719715','Q6720103','Q7276440','Q7577957','Q7866032','Q7866048','Q7866077','Q7866104','Q7866127','Q7866725','Q9332426','Q10531523','Q11269693','Q11667231','Q11680016','Q11705702','Q52316871','Q52317976','Q52321312','Q52322283','Q52333081','Q52333772','Q52350593','Q52353863','Q52353869','Q52353963','Q52379002','Q104035122','Q104036129','Q104098514','Q105765011','Q105767377','Q109448262','Q109527446','Q109647833','Q111146951','Q112862971','Q112863179','Q113858356'

$APIKEY = 'YOUR_API_KEY_GOES_HERE'
$APIURL = 'https://ais.marineplan.com/location/2/ship.json?key='+$APIKEY+'&ship='

#to do
#If Wikidata has something OSD does not, add it

[datetime]$date=get-date
$datestr = $date.ToString("yyyy-MM-dd")

$DATASOURCE = @{
    'VAARKAART_NL'  = 'Q122852299'
    'WATERKAART_NL' = 'Q122852305'
    'AIS'           = 'Q787197'
    'NAVKID'        = 'Q122852754'
}

function Send-Wikidata {

    param (
        $QID
    )
    $out = ""

    #$QID = 'Q65464438'
    #$APIKEY = '1908ac33-d324-426b-88c3-c7194474e40c'

    #Retrieve the wikidata item and put in a variable called WD then show me what you got
    $Response = Invoke-WebRequest -Uri "https://wikidata.org/w/rest.php/wikibase/v0/entities/items/$QID" -UseBasicParsing
    If ($Response.StatusCode -ne "200") {
        # WD failed to respond.
        Write-Host "Message: $($Response.StatusCode) $($Response.StatusDescription)"
    }

    #Make a dictionary of the response from Wikidata
    $WD = $response | ConvertFrom-Json
    $MMSI = $WD.statements.p587.value.content

    try {
        $Response = Invoke-WebRequest -Uri "$APIURL$MMSI" -UseBasicParsing -ContentType "application/xml"
        $Feed = $Response.Content | ConvertFrom-Json

        # if it doesn't have a draughtMeters P2262
        [float]$draught=$feed.draughtMeters
        [float]$WDdraught=$WD.statements.p2262.value.content.amount
        if (($WD.statements.p2262.value.content.amount.length -eq 0 -Or $WDdraught -Eq 0 -Or $WDdraught -Eq 1) -And $draught -gt 1)
        { $out += "%7C%7C$QID%7CP2262%7C$draught" }

        # if it doesn't have a widthMeters P2261
        [float]$widthMeters=$feed.widthMeters
        [float]$WDwidth=$WD.statements.p2261.value.content.amount
        if (($WD.statements.p2261.value.content.amount.length -eq 0 -Or $WDwidth -eq 0 -Or $WDwidth -Eq 1) -And $widthMeters -ne 0)
        { $out += "%7C%7C$QID%7CP2261%7C$widthMeters" }


        # if it doesn't have a lengthMeters, add it $WD.statements.p2043.value.content.amount
        [float]$length=$feed.lengthMeters
        if (($WD.statements.p2043.value.content.amount.length -eq 0 -Or $length -eq 0 -Or $length -Eq 1) -And $length -gt 0)
        { $out += "%7C%7C$QID%7CP2043%7C$($length)" }

        # if it doesn't have a heightMeters, add it
        [float]$height=$feed.heightMeters
        
        if (($WD.statements.p2048.value.content.amount.length -eq 0 -Or $height -eq 0 -Or $height -Eq 1) -And $height -gt 0)
        { $out += "%7C%7C$QID%7CP2048%7C$($height)%7CP407%7CQ1860%7C" }
    

        # if it doesn't have a name, add it $WD.statements.p2043.value.content.amount
        if ($WD.statements.P1448.value.content.text.length -eq 0 -And $feed.boatName.length -ne 0) {
            $boatname = [System.Web.HTTPUtility]::UrlEncode($feed.boatName)
            $boatname = $boatname.replace('+', '%20')
            $out += "%7C%7C$QID%7CP1448%7Cen:%22$boatname%22%7CP407%7CQ1860%7C"
        }

        # if it doesn't have a callsign, add it it $WD.statements.p2317.value.content 
        if ($WD.statements.P2317.value.content.length -eq 0 -And $feed.callsign.length -ne 0) {
            $callsign = [System.Web.HTTPUtility]::UrlEncode($feed.callsign)
            $callsign = $callsign.replace('+', '%20')
            $out += "%7C%7C$QID%7CP2317%7C%22$callsign%22"
        }

        # if it doesn't have coordinates #point":{"latitude":51.48445,"longitude":-0.01208} P625
        #if ($WD.statements.P625.value.content.amount.length -eq 0 -And $feed.point.longitude.length -ne 0) {
        #    $coords="%40$($feed.point.latitude)%2F$($feed.point.longitude)"
        #    $source=$DATASOURCE[$feed.source]
        #    $out += "%7C%7C$QID%7CP625%7C$coords%7CP585%7C%2b$($datestr)T00:00:00Z%2F11%7CS248%7C$source"
        #}
    }
    catch {} 

    return $out
}
$output = "https://quickstatements.toolforge.org/#/v1="


foreach ($Qitem in $Q) {
#the owner of the API has asked that we do not hit it for more than a minute at a time, so if any block is taking longer, pause for a minute
$duration=(get-date)-$date
if ($duration.Totalseconds -gt 59) {Start-Sleep -s 60
[datetime]$date=get-date}

    $itemoutput = Send-Wikidata($Qitem)
    $output = $output + $itemoutput
}
if ($output.length -gt 43) {
Start-Process "chrome.exe" "$output"}
$output