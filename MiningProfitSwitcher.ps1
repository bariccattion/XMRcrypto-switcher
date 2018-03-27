$global:STAKexe = "XMR-STAK.EXE"
function kill-Process ($STAKexe){
		$prog = ($STAKexe -split "\.", 2)
		$prog = $prog[0]
		$stakPROC = Get-Process $prog -ErrorAction SilentlyContinue
		$stakPROC.CloseMainWindow() | Out-Null
		Sleep 5
		if (!$stakPROC.HasExited){
			$stakPROC | Stop-Process -Force | Out-Null
		}
}  

function simpleAPI($SITE){
	$site = Invoke-WebRequest -UseBasicParsing -Uri $SITE
	$return = $site.Content
	$return2 = [single]$return
	return $return2
}

function coinmarketcapAPI($SITE){
	$rawdata = Invoke-WebRequest -Uri $SITE -TimeoutSec 60
	$data = $rawdata | ConvertFrom-Json
	$rawtotal = ($data.price_usd)
	$VALUE = $rawtotal | foreach {$_}
	return [single]$VALUE
}

function tradeogreAPI($SITE){
	$rawdata = Invoke-WebRequest -UseBasicParsing -Uri $SITE -TimeoutSec 60
	$data = $rawdata | ConvertFrom-Json
	$rawtotal = [single]($data.price)
	$PRICE = $rawtotal | foreach {$_}
	return $PRICE
}

function tradeogrelowAPI($SITE){
	$rawdata = Invoke-WebRequest -UseBasicParsing -Uri $SITE -TimeoutSec 60
	$data = $rawdata | ConvertFrom-Json
	$rawtotal = [single]($data.low)
	$PRICE = $rawtotal | foreach {$_}
	return $PRICE
}

function nanopoolAPI($SITE){
	$rawdata = Invoke-WebRequest -UseBasicParsing -Uri $SITE -TimeoutSec 60
	$data = $rawdata | ConvertFrom-Json
	$rawtotal = ($data.data).day
	$rawtotal2 = [double]($rawtotal.bitcoins)
	$VALUE = $rawtotal2 | foreach {$_}
	return $VALUE
}

function whattominenethashAPI($SITE){
	$rawdata = Invoke-WebRequest -UseBasicParsing -Uri $SITE -TimeoutSec 60
	$data = $rawdata | ConvertFrom-Json
	$rawtotal = [single]($data.nethash)
	$VALUE = $rawtotal | foreach {$_}
	return $VALUE
}

function whattomineblockrewardAPI($SITE){
	$rawdata = Invoke-WebRequest -UseBasicParsing -Uri $SITE -TimeoutSec 60
	$data = $rawdata | ConvertFrom-Json
	$rawtotal = [single]($data.block_reward24)
	$VALUE = $rawtotal | foreach {$_}
	return $VALUE
}

function whattomineblocktimeAPI($SITE){
	$rawdata = Invoke-WebRequest -UseBasicParsing -Uri $SITE -TimeoutSec 60
	$data = $rawdata | ConvertFrom-Json
	$rawtotal = [single]($data.block_time)
	$VALUE = $rawtotal | foreach {$_}
	return $VALUE
}

function nanopoolAPI($SITE){
	$rawdata = Invoke-WebRequest -UseBasicParsing -Uri $SITE -TimeoutSec 60
	$data = $rawdata | ConvertFrom-Json
	$rawtotal = ($data.data).day
	$rawtotal2 = [single]($rawtotal.bitcoins)
	$VALUE = $rawtotal2 | foreach {$_}
	return $VALUE
}

function hashvaultAPI($SITE){
	$rawdata = Invoke-WebRequest -UseBasicParsing -Uri $SITE -TimeoutSec 60
	$data = $rawdata | ConvertFrom-Json
	$rawtotal = ($data.difficulty)
	$VALUE = [single]$rawtotal | foreach {$_}
	return $VALUE
}

function southxchangeAPI($SITE){
	$rawdata = Invoke-WebRequest -UseBasicParsing -Uri $SITE -TimeoutSec 60
	$data = $rawdata | ConvertFrom-Json
	$rawtotal = [single]($data.last)
	$VALUE = $rawtotal | foreach {$_}
	return $VALUE
}

function calculateshit{
	$BTCPRICE = coinmarketcapAPI https://api.coinmarketcap.com/v1/ticker/bitcoin/
	$KRBPRICE = coinmarketcapAPI https://api.coinmarketcap.com/v1/ticker/karbowanec/
	$SUMOPRICE = coinmarketcapAPI https://api.coinmarketcap.com/v1/ticker/sumokoin/
	$DCYPRICE = coinmarketcapAPI https://api.coinmarketcap.com/v1/ticker/dinastycoin/
	$XLCPRICE = coinmarketcapAPI https://api.coinmarketcap.com/v1/ticker/leviarcoin/
	$XUNPRICE = tradeogrelowAPI https://tradeogre.com/api/v1/ticker/BTC-XUN
	$IPBCPRICE = tradeogrelowAPI https://tradeogre.com/api/v1/ticker/BTC-IPBC
	$GRFTPRICE = tradeogrelowAPI https://tradeogre.com/api/v1/ticker/BTC-GRFT
	$ITNSPRICE = tradeogrelowAPI https://tradeogre.com/api/v1/ticker/BTC-ITNS
	$ETNPRICE = tradeogreAPI https://tradeogre.com/api/v1/ticker/BTC-ETN
	$MSRPRICE = southxchangeAPI https://www.southxchange.com/api/price/MSR/BTC
	$DEROPRICE = 0.00000001
	$EDLPRICE = 0.00000001
	$FNOPRICE = 0.00000001

	$NetHashTRTL = simpleAPI https://turtle-coin.com/q/hashrate/
	$RewardTRTL = simpleAPI https://turtle-coin.com/q/reward/
	$NetHashKRB = simpleAPI http://explorer.karbowanec.com/q/hashrate/
	$RewardKRB = simpleAPI http://explorer.karbowanec.com/q/reward/
	$NetHashXUN = simpleAPI http://explorer.ultranote.org/q/hashrate/
	$RewardXUN = simpleAPI http://explorer.ultranote.org/q/reward/
	$NetHashIPBC = simpleAPI https://explorer.ipbc.io/q/hashrate/
	$RewardIPBC = simpleAPI https://explorer.ipbc.io/q/reward/
	$NetHashSUMO = whattominenethashAPI https://whattomine.com/coins/196.json
	$RewardSUMO = whattomineblockrewardAPI https://whattomine.com/coins/196.json
	$NetHashDCY = whattominenethashAPI https://whattomine.com/coins/227.json
	$RewardDCY = whattomineblockrewardAPI https://whattomine.com/coins/227.json
	$NetHashMSR = ( hashvaultAPI https://masari.hashvault.pro/api/network/stats )/120
	$RewardMSR = 27.16
	$NetHashGRFT = ( hashvaultAPI https://graft.hashvault.pro/api/network/stats )/120
	$RewardGRFT = 1782
	$NetHashDERO = ( hashvaultAPI https://dero.hashvault.pro/api/network/stats )/120
	$RewardDERO = 28.7
	$NetHashEDL = ( hashvaultAPI https://edollar.hashvault.pro/api/network/stats )/120
	$RewardEDL = 3398.3
	$NetHashFNO = ( hashvaultAPI https://fonero.hashvault.pro/api/network/stats )/120
	$RewardFNO = 26.3
	$NetHashITNS = ( hashvaultAPI https://intense.hashvault.pro/api/network/stats )/120
	$RewardITNS = 1445.8
	$NetHashXLC = ( hashvaultAPI https://leviarcoin.hashvault.pro/api/network/stats )/60
	$RewardXLC = 8.3
	$NetHashETN = ( hashvaultAPI https://electroneum.hashvault.pro/api/network/stats )/60
	$RewardETN = 6500
	
	
	$TimeSUMO = whattomineblocktimeAPI https://whattomine.com/coins/196.json
	$TimeDCY = whattomineblocktimeAPI https://whattomine.com/coins/227.json

	$DOLLARSKRB = calculateBTCDAY $NetHashKRB $RewardKRB $KRBPRICE 240 1
	$DOLLARSTRTL = calculateBTCDAY $NetHashTRTL $RewardTRTL 0.0000000125 30 $BTCPRICE
	$DOLLARSXUN = calculateBTCDAY $NetHashXUN $RewardXUN $XUNPRICE 120 $BTCPRICE
	$DOLLARSIPBC = calculateBTCDAY $NetHashIPBC $RewardIPBC $IPBCPRICE 120 $BTCPRICE
	$DOLLARSSUMO = calculateBTCDAY $NetHashSUMO $RewardSUMO $SUMOPRICE $TimeSUMO 1
	$DOLLARSDCY = calculateBTCDAY $NetHashDCY $RewardDCY $DCYPRICE $TimeDCY 1
	$DOLLARSMSR = calculateBTCDAY $NetHashMSR $RewardMSR $MSRPRICE 120 $BTCPRICE
	$DOLLARSGRFT = calculateBTCDAY $NetHashGRFT $RewardGRFT $GRFTPRICE 120 $BTCPRICE
	$DOLLARSDERO = calculateBTCDAY $NetHashDERO $RewardDERO $DEROPRICE 120 $BTCPRICE
	$DOLLARSEDL = calculateBTCDAY $NetHashEDL $RewardEDL $EDLPRICE 120 $BTCPRICE
	$DOLLARSITNS = calculateBTCDAY $NetHashITNS $RewardITNS $ITNSPRICE 120 $BTCPRICE
	$DOLLARSXLC = calculateBTCDAY $NetHashXLC $RewardXLC $XLCPRICE 60 1
	$DOLLARSETN = calculateBTCDAY $NetHashETN $RewardETN $ETNPRICE 60 1
	
	$BTCXMR = nanopoolAPI https://api.nanopool.org/v1/xmr/approximated_earnings/1000
	$DOLLARSXMR = $BTCXMR * $BTCPRICE
	
	$arrayBTCPROFIT = @(
	([single]$DOLLARSKRB,[single]$DOLLARSTRTL,[single]$DOLLARSXUN,[single]$DOLLARSIPBC,[single]$DOLLARSSUMO,[single]$DOLLARSDCY,[single]$DOLLARSMSR,[single]$DOLLARSGRFT,[single]$DOLLARSITNS,[single]$DOLLARSXLC,[single]$DOLLARSETN),
	("KRB","TRTL","XUN","IPBC","SUMO","DCY","MSR","GRFT","ITNS","XLC","ETN")
	)
	bubbleSort -array $arrayBTCPROFIT
	$arrayrtn=$arrayBTCPROFIT
	return $arrayrtn
}

function calculateBTCDAY($NetHash, $Reward, $Price, $BlockTime, $BTCPRICE){
	$HR=1000/$NetHash
	$E=($Reward*86400)/$BlockTime
	$C=$HR*$E
	$BTCTot=$C*$Price*$BTCPRICE*0.95

	return $BTCTot
}

function bubbleSort($array){
	[bool] $sorted = $false 
	$counter = 0 
	for ($pass = 1; ($pass -lt $arrayBTCPROFIT[1].count) -and -not $sorted; $pass++) 
	{ 
		$sorted = $true 
		for ($index = 0; $index -lt ($arrayBTCPROFIT[1].count - $pass); $index++) 
		{ 
			$counter++ 
			$nextIndex = $index + 1 
			if ($arrayBTCPROFIT[0][$index].CompareTo($arrayBTCPROFIT[0][$nextIndex]) -gt 0) 
			{ 
				$temp = $arrayBTCPROFIT[0][$index]
				$temp2 = $arrayBTCPROFIT[1][$index]
				$arrayBTCPROFIT[0][$index] = $arrayBTCPROFIT[0][$nextIndex]
				$arrayBTCPROFIT[1][$index] = $arrayBTCPROFIT[1][$nextIndex]
				$arrayBTCPROFIT[0][$nextIndex] = $temp 
				$arrayBTCPROFIT[1][$nextIndex] = $temp2 
				$sorted = $false 
			} 
		} 
	}
}

function checkhash{
	$array=calculateshit
	$stringMostProf=$array[1][-1]
	"Table of profitability of 1000 H/s in dollars"
	$array|%{"$_"}
	
	if((Get-FileHash "$PSScriptRoot\monero-config$stringMostProf.txt").hash  -ne (Get-FileHash "$PSScriptRoot\monero-config.txt").hash){
		Remove-Item -Path "$PSScriptRoot\monero-config.txt"
		Copy-Item "$PSScriptRoot\monero-config$stringMostProf.txt" -Destination "$PSScriptRoot\monero-config$stringMostProf2.txt"
		Rename-Item -Path "$PSScriptRoot\monero-config$stringMostProf2.txt" -NewName "$PSScriptRoot\monero-config.txt"
		"$stringMostProf is best, changing it"
		kill-Process ($STAKexe)
		"Mining $stringMostProf for 40 minutes"
		sleep 2400
	}
	else {
		"$stringMostProf is best but we are already mining it."
		"Checking profitability again in 15 minutes"
		sleep 900
	}
}

"Welcome to the bariccattion's mining switcher" 
while($true){
	checkhash
}

