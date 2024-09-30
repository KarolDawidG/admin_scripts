# ====================================================================
# Skrypt do zarządzania dostępem do portów USB oraz napędów CD/DVD
# ====================================================================

# WAZNE:
# Do poprawnego działania skryptu, przed jego pierwszym uruchomieniem
# należy stworzyć plik konfiguracyjny: Registry_wlaczona_blokada.pol,
# który jest kopią pliku Registry z folderu:
# C:\Windows\System32\GroupPolicy\Machine\Registry.pol

# Jak stworzyć plik Registry_wlaczona_blokada.pol:
# 1. Otwórz CMD i uruchom edytor polityk grupowych (gpedit.msc).
# 2. Przejdź do:
#    Szablony administracyjne > System > Dostęp do magazynu wymiennego
# 3. Ustaw następujące opcje na "Włączone":
#    - Dysk CD i DVD: odmowa dostępu do wykonania
#    - Dysk CD i DVD: odmowa dostępu do odczytu
#    - Dysk CD i DVD: odmowa dostępu do zapisu
#    - Dyski wymienne: odmowa dostępu do wykonania
#    - Dyski wymienne: odmowa dostępu do odczytu
#    - Dyski wymienne: odmowa dostępu do zapisu
#
# 4. Analogicznie postąp dla pliku Registry_wylaczona_blokada, 
#    z tym że opcje powinny być ustawione na "Wyłączone".
#
# 5. Gotowe! Teraz możesz blokować i odblokowywać porty USB oraz
#    napędy CD/DVD jednym kliknięciem.

# ====================================================================
# Funkcja do wyłączania portów USB oraz napędów CD/DVD
function DisableExtDev {
    Write-Host "Wylaczam porty USB oraz naped CD/DVD." -ForegroundColor Yellow
    
    # Tworzenie kluczy w rejestrze dla wyłączenia portów USB i napędów
    New-Item -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630b-b6bf-11d0-94f2-00a0c91efb8b}' -Force | Out-Null
    New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630b-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Read' -Value 1 -PropertyType 'DWord' -Force | Out-Null
    New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630b-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Write' -Value 1 -PropertyType 'DWord' -Force | Out-Null
    New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630b-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Execute' -Value 1 -PropertyType 'DWord' -Force | Out-Null

    New-Item -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f56311-b6bf-11d0-94f2-00a0c91efb8b}' -Force | Out-Null
    New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f56311-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Read' -Value 1 -PropertyType 'DWord' -Force | Out-Null
    New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f56311-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Write' -Value 1 -PropertyType 'DWord' -Force | Out-Null
    New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f56311-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Execute' -Value 1 -PropertyType 'DWord' -Force | Out-Null
    
    # Kopiowanie pliku konfiguracyjnego i aktualizacja zasad grupowych
    Copy-Item -Path 'C:\Windows\System32\GroupPolicy\Registry_wlaczona_blokada.pol' -Destination 'C:\Windows\System32\GroupPolicy\Machine\Registry.pol' -Force
    gpupdate.exe /force /wait:0
    
    Write-Host "Porty USB oraz naped CD/DVD zostaly wylaczone." -ForegroundColor Green
}

# ====================================================================
# Funkcja do włączania portów USB oraz napędów CD/DVD
function EnableExtDev {
    Write-Host "Wlaczam porty USB oraz naped CD/DVD." -ForegroundColor Yellow
    
    # Tworzenie kluczy w rejestrze dla włączenia portów USB i napędów
    New-Item -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630b-b6bf-11d0-94f2-00a0c91efb8b}' -Force | Out-Null
    New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630b-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Read' -Value 0 -PropertyType 'DWord' -Force | Out-Null
    New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630b-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Write' -Value 0 -PropertyType 'DWord' -Force | Out-Null
    New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630b-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Execute' -Value 0 -PropertyType 'DWord' -Force | Out-Null

    New-Item -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f56311-b6bf-11d0-94f2-00a0c91efb8b}' -Force | Out-Null
    New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f56311-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Read' -Value 0 -PropertyType 'DWord' -Force | Out-Null
    New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f56311-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Write' -Value 0 -PropertyType 'DWord' -Force | Out-Null
    New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f56311-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Execute' -Value 0 -PropertyType 'DWord' -Force | Out-Null
    
    # Kopiowanie pliku konfiguracyjnego i aktualizacja zasad grupowych
    Copy-Item -Path 'C:\Windows\System32\GroupPolicy\Registry_wylaczona_blokada.pol' -Destination 'C:\Windows\System32\GroupPolicy\Machine\Registry.pol' -Force
    gpupdate.exe /force /wait:0
    
    Write-Host "Porty USB oraz naped CD/DVD zostaly wlaczone." -ForegroundColor Green
}

# ====================================================================
# Główna logika skryptu - sprawdzenie argumentu wywołania
$action = $args[0]

# Wykonaj odpowiednią funkcję na podstawie argumentu
if ($action -eq "DisableExtDev") {
    DisableExtDev
} elseif ($action -eq "EnableExtDev") {
    EnableExtDev
} else {
    Write-Host "Nieprawidlowa komenda! Uzyj DisableExtDev lub EnableExtDev." -ForegroundColor Red
}

