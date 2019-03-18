
<#
.SYNOPSIS
Does Stuff
.Description
more stuff
.Parameter computername
pc
.example
bosh .ps1
#>

[cmdletbinding()]
param(
#    [Parameter(Mandatory=$True)]
#    [string]$serverfile
)
#cls
Write-Verbose "servers in text file at start are:"
#Get-WmiObject -class win32_computersystem -ComputerName student08, student09, student10, student11 | select -Property __SERVER, Description, Domain, totalphysicalmemory, Manufacturer, @{n='PC';e={$_.__SERVER}},@{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}} | ft -AutoSize

#Get-WmiObject -class win32_computersystem -ComputerName (GC servers.txt)| select -Property __SERVER, Description, Domain, totalphysicalmemory, Manufacturer, @{n='PC';e={$_.__SERVER}},@{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}} | ft -AutoSize

#Get-WmiObject -class win32_computersystem -ComputerName (GC servers.txt)| ft -Property @{n='PC';e={$_.__SERVER}}, Description, Domain, @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer, @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}} -AutoSize

#stripped down properties
#Get-WmiObject -class win32_computersystem -property __SERVER, Manufacturer, Description, Domain, totalphysicalmemory -ComputerName (GC servers.txt) | ft -Property @{n='PC';e={$_.__SERVER}}, Description, Domain, @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer, @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}} -AutoSize

#Get-WmiObject -class win32_computersystem -ComputerName (GC servers.txt)| ft -Property @{n='PC';e={$_.__SERVER}}, Description, Domain, @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer, @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}} -AutoSize

#Test-Connection -Count 1 -ComputerName (GC servers.txt) -quiet | foreach { "is "+$_ }

#gc servers.txt | foreach { $jbpc=$_;Test-Connection -quiet -count 1 -ComputerName $_ } | foreach { if ($_) {"yes"} }


#ping then single wmi queries
#gc servers.txt | foreach { $jbpc=$_;Test-Connection -quiet -count 1 -ComputerName $_ } | foreach { if ($_) {Get-WmiObject -class win32_computersystem -ComputerName $jbpc| ft -Property @{n='PC';e={$_.__SERVER}}, Description, Domain, @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer, @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}} -HideTableHeaders} }

#ping the build server list and wmi query
#$jbpcall=@()
#$jbnopcall=@()
#gc servers.txt | foreach { $jbpc=$_;Test-Connection -quiet -count 1 -ComputerName $_ } | foreach { if ($_) {write-host -NoNewline ".";$jbpcall=$jbpcall+$jbpc} else {write-host -NoNewline "X";$jbnopcall=$jbnopcall+$jbpc+","}} 
#write-host ""
#"connection errors found with computers: "+$jbnopcall
#Get-WmiObject -class win32_computersystem -ComputerName $jbpcall | ft -Property @{n='PC';e={$_.__SERVER}}, Description, Domain, @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer, @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}} -AutoSize

#get perf counters in comp list
#get-counter '\memory\available mbytes' -computername $jbpcall | foreach {$_.CounterSamples.CookedValue}

#get perf counters in comp list
#$jbpcall=@()
#$jbnopcall=@()
#gc servers.txt | foreach { $jbpc=$_;Test-Connection -quiet -count 1 -ComputerName $_ } | foreach { if ($_) {write-host -NoNewline ".";$jbpcall=$jbpcall+$jbpc} else {write-host -NoNewline "X";$jbnopcall=$jbnopcall+$jbpc+","}} 
#write-host ""
#"connection errors found with computers: "+$jbnopcall
#Get-WmiObject -class win32_computersystem -ComputerName $jbpcall | ft -Property @{n='PC';e={$_.__SERVER}}, Description, Domain, @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer, @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}}, @{n='memfree';e={get-counter '\memory\available mbytes' -computername $_.__SERVER | foreach {$_.CounterSamples.CookedValue}}}

#move to parameter

#$jbpcall=@()
#$jbnopcall=@()
#gc $serverfile | foreach { $jbpc=$_;Test-Connection -quiet -count 1 -ComputerName $_ } | foreach { if ($_) {write-host -NoNewline ".";$jbpcall=$jbpcall+$jbpc} else {write-host -NoNewline "X";$jbnopcall=$jbnopcall+$jbpc+","}} 
#write-host ""
#"connection errors found with computers: "+$jbnopcall
#Get-WmiObject -class win32_computersystem -ComputerName $jbpcall | ft -Property @{n='PC';e={$_.__SERVER}}, Description, Domain, @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer, @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}}, @{n='memfree';e={get-counter '\memory\available mbytes' -computername $_.__SERVER | foreach {$_.CounterSamples.CookedValue}}}

#use cursor position
#$position=$host.ui.rawui.cursorposition;$position.x=0;$position.y=0
#$jbpcall=@();$jbnopcall=@();$progress="["
#gc $serverfile | foreach { $jbpc=$_;$host.ui.rawui.cursorposition=$position;write-host "Processing" $jbpc "                ";Test-Connection -quiet -count 1 -ComputerName $_ } | foreach { if ($_) {$progress=$progress+".";$jbpcall=$jbpcall+$jbpc} else {$progress=$progress+"X";$jbnopcall=$jbnopcall+$jbpc+","};write-host $progress} 
#write-host "connection errors found with computers: " $jbnopcall
#Get-WmiObject -class win32_computersystem -ComputerName $jbpcall | ft -Property @{n='PC';e={$_.__SERVER}}, Description, Domain, @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer, @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}}, @{n='memfree';e={get-counter '\memory\available mbytes' -computername $_.__SERVER | foreach {$_.CounterSamples.CookedValue}}}

#trim space and filter CRLF
#$position=$host.ui.rawui.cursorposition;$position.x=0;$position.y=0
#$jbpcall=@();$jbnopcall=@();$progress="["
#gc $serverfile | Where-Object {$_.trim().length -gt 0} | foreach { $jbpc=$_;$host.ui.rawui.cursorposition=$position;write-host "Processing" $jbpc "                ";Test-Connection -quiet -count 1 -ComputerName $_ } | foreach { if ($_) {$progress=$progress+".";$jbpcall=$jbpcall+$jbpc} else {$progress=$progress+"X";$jbnopcall=$jbnopcall+$jbpc+","};write-host $progress} 
#write-host "connection errors found with computers: " $jbnopcall
#Get-WmiObject -class win32_computersystem -ComputerName $jbpcall | ft -Property @{n='PC';e={$_.__SERVER}}, Description, Domain, @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer, @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}}, @{n='memfree';e={get-counter '\memory\available mbytes' -computername $_.__SERVER | foreach {$_.CounterSamples.CookedValue}}}

#free disk, CPU, Mem free
#$position=$host.ui.rawui.cursorposition;$position.x=0;$position.y=0
#$jbpcall=@();$jbnopcall=@();$progress="["
#gc $serverfile | Where-Object {$_.trim().length -gt 0} | foreach { $jbpc=$_;$host.ui.rawui.cursorposition=$position;write-host "Processing" $jbpc "                ";Test-Connection -quiet -count 1 -ComputerName $_ } | foreach { if ($_) {$progress=$progress+".";$jbpcall=$jbpcall+$jbpc} else {$progress=$progress+"X";$jbnopcall=$jbnopcall+$jbpc+","};write-host $progress} 
#write-host "connection errors found with computers: " $jbnopcall
#Get-WmiObject -class win32_computersystem -ComputerName $jbpcall | ft -Property @{n='PC';e={$_.__SERVER}}, @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer, @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}},
# @{n='memFree';e={get-counter '\memory\available mbytes' -computername $_.__SERVER | foreach {$_.CounterSamples.CookedValue}}},
# @{n='CPU';e={get-counter '\Processor(_Total)\% Processor Time' -computername $_.__SERVER | foreach {$_.CounterSamples.CookedValue}};formatstring='n2'},
# @{n='C: free';e={$(Get-Counter -computername $_.__SERVER -Counter “\LogicalDisk(C:)\% Free Space”).countersamples.cookedvalue};formatstring='n2'}


#recode to get number format better
#$position=$host.ui.rawui.cursorposition;$position.x=0;$position.y=0
#$jbpcall=@();$jbnopcall=@();$progress="["
#gc $serverfile | Where-Object {$_.trim().length -gt 0} | foreach { $jbpc=$_;$host.ui.rawui.cursorposition=$position;write-host "Processing" $jbpc "                ";Test-Connection -quiet -count 1 -ComputerName $_ } | foreach { if ($_) {$progress=$progress+".";$jbpcall=$jbpcall+$jbpc} else {$progress=$progress+"X";$jbnopcall=$jbnopcall+$jbpc+","};write-host $progress} 
#write-host "connection errors found with computers: " $jbnopcall
#Get-WmiObject -class win32_computersystem -ComputerName $jbpcall | ft -Property @{n='PC';e={$_.__SERVER}}, 
# @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer,
# @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}},
# @{n='memFree';e={$($(get-counter -computername $_.__SERVER -Counter '\memory\available mbytes').countersamples.cookedvalue) / 1024};formatstring='n2'},
# @{n='CPU use';e={$(get-counter -computername $_.__SERVER -Counter '\Processor(_Total)\% Processor Time').countersamples.cookedvalue};formatstring='n2'},
# @{n='C: free';e={$(Get-Counter -computername $_.__SERVER -Counter “\LogicalDisk(C:)\% Free Space”).countersamples.cookedvalue};formatstring='n2'}

#add-job?
$servers=gc servers.txt | Where-Object {$_.trim().length -gt 0}

#$servers | % { remove-job -name job$_ -Force}
$servers | % { 

Get-WmiObject -class win32_computersystem -ComputerName $_ | ft -Property @{n='PC';e={$_.__SERVER}},
 @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer,
 @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}},
 @{n='memFree';e={$($(get-counter -computername $_.__SERVER -Counter '\memory\available mbytes').countersamples.cookedvalue) / 1024};formatstring='n2'},
 @{n='CPU use';e={$(get-counter -computername $_.__SERVER -Counter '\Processor(_Total)\% Processor Time').countersamples.cookedvalue};formatstring='n2'},
 @{n='C: free';e={$(Get-Counter -computername $_.__SERVER -Counter “\LogicalDisk(C:)\% Free Space”).countersamples.cookedvalue};formatstring='n2'}
   }

#$servers | % { wait-job -name job$_ }
#$servers | % { Receive-Job -name job$_ }



#asJob

$servers | % { 

Get-WmiObject -AsJob -class win32_computersystem -ComputerName $_ | ft -Property @{n='PC';e={$_.__SERVER}},
 @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer,
 @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}},
 @{n='memFree';e={$($(get-counter -computername $_.__SERVER -Counter '\memory\available mbytes').countersamples.cookedvalue) / 1024};formatstring='n2'},
 @{n='CPU use';e={$(get-counter -computername $_.__SERVER -Counter '\Processor(_Total)\% Processor Time').countersamples.cookedvalue};formatstring='n2'},
 @{n='C: free';e={$(Get-Counter -computername $_.__SERVER -Counter “\LogicalDisk(C:)\% Free Space”).countersamples.cookedvalue};formatstring='n2'}
   }


write-host "multithread wmi calls?"

$servers | % { start-job {

Get-WmiObject -class win32_computersystem -ComputerName $_ | ft -Property @{n='PC';e={$_.__SERVER}},
 @{n='MEM GB';e={$_.totalphysicalmemory / 1GB};formatstring='n2'}, Manufacturer,
 @{n='OS';e={(get-wmiobject -class win32_operatingsystem -computername $_.__SERVER).caption}},
 @{n='memFree';e={$($(get-counter -computername $_.__SERVER -Counter '\memory\available mbytes').countersamples.cookedvalue) / 1024};formatstring='n2'},
 @{n='CPU use';e={$(get-counter -computername $_.__SERVER -Counter '\Processor(_Total)\% Processor Time').countersamples.cookedvalue};formatstring='n2'},
 @{n='C: free';e={$(Get-Counter -computername $_.__SERVER -Counter “\LogicalDisk(C:)\% Free Space”).countersamples.cookedvalue};formatstring='n2'}
   }
   }

write-host "variable first multithread wmi calls?"

function TestConnJob($comp) {
   $sb = [scriptblock]::create("Test-Connection $comp")
   Start-Job -ScriptBlock $sb
}

TestConnJob("localhost2")


write-host "shell out multiple job function"

get-job | remove-job -force
#CLS
#Get-WmiObject -class win32_computersystem -ComputerName $comp | fl -Property *
function Testwmi($comp) {
   $sb = [scriptblock]::create("
   get-counter -computername $comp -Counter '\memory\available mbytes'
    ")
   Start-Job -ScriptBlock $sb
}

Testwmi("localhost")
wait-job * -Any | Receive-Job -keep



#shell out multiple job function - test with Param - works
get-job | remove-job -force
#CLS
function Testwmi($comp) {
   
   start-job -ScriptBlock {param($computername)
   get-counter -computername $computername -Counter '\memory\available mbytes'
   } -ArgumentList $comp
   
}

Testwmi("localhost")
wait-job * -Any | Receive-Job -keep


#shell out multiple job function - working with variables
get-job | remove-job -force
#CLS
function Testwmi($comp) {
   
   start-job -ScriptBlock {param($computername)
   $jb=get-counter -computername $computername -Counter '\memory\available mbytes'
   $jb.countersamples.cookedvalue
   } -ArgumentList $comp
   
}
Testwmi("localhost")
wait-job * -Any | Receive-Job -keep


#shell out multiple job function - working with $_
get-job | remove-job -force
#CLS
function Testwmi($comp) {
   write-host "Server:" $comp
   start-job -ScriptBlock {get-counter -computername $comp -Counter '\memory\available mbytes' | %{$_.countersamples.cookedvalue}
   
   }
   
}
Write-Host "Test 12"
Testwmi("localhost")
wait-job * -Any | Receive-Job -keep

#CLS
write-host "test 13"
write-host "Remove Jobs.."
get-job | remove-job -force

write-host "Define Function"

function Testwmi13($comp) {
   Write-Host "$comp=" $comp
   start-job -ScriptBlock {param($jbc)
   get-counter -computername $jbc -Counter '\memory\available mbytes'
   } -ArgumentList $comp
   
}

write-host "Call Function"
Testwmi13("DESKTOP-UNADPE1")

write-host "wait for jobs"
wait-job * -Any | Receive-Job -keep
write-host "13 done"
