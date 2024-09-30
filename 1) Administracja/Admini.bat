@echo off
setlocal
cd c:\Data

:: Definiowanie zmiennych dla adresow IP
set PC1_IP=192.168.1.12
set PC2_IP=192.168.1.10
set SWITCH_IP=192.168.1.100
set ROUTER_IP=192.168.1.1

:: Stylizacja Matrixa - zielony tekst na czarnym tle
color 0A

:: Poczatkowy efekt "hackingu"
echo.
echo Inicjalizacja...
ping localhost -n 2 >nul
echo Ladowanie danych...
ping localhost -n 2 >nul
echo Polaczono. Czekaj na dalsze instrukcje...
ping localhost -n 2 >nul
echo.

:menu
cls
echo =====================================================
echo   	** Witaj w systemie Monitoring PC **   
echo =====================================================
echo.
echo 1) Polacz z urzadzeniami PC       
echo 2) Polacz z urzadzeniami sieciowymi  
echo 3) Wlacz/Wylacz porty USB i napedy CD/DVD
echo -----------------------------------------------------
echo ** Nacisnij inny klawisz, aby uciec... **
echo =====================================================
echo.
set /p wybor=">> Wybierz odpowiednia opcje: "

if "%wybor%"=="1" (
    goto sop_question
) 
if "%wybor%"=="2" (
    goto network_question
) 
if "%wybor%"=="3" (
    goto disable_enable_question
) 
echo "Koniec pracy... System zostanie zamkniety."
pause
exit /b

:sop_question
cls
echo =====================================================
echo 	** Polaczenie z systemami PC **   
echo =====================================================
echo 1) PC 1 %PC1_IP%
echo 2) PC 2 %PC2_IP%
echo 3) Cofnij do menu glownego
echo -----------------------------------------------------
echo ** Wybierz odpowiednia opcje lub powrot do mene... **
echo =====================================================
echo.
set /p choice=">> Dokonaj wyboru: "

if "%choice%"=="1" (
    start cmd /k "sftp user@%PC1_IP%"
    goto menu
) 
if "%choice%"=="2" (
    start cmd /k "sftp -o KexAlgorithms=+diffie-hellman-group1-sha1 user@%PC2_IP%"
    goto menu
)
if "%choice%"=="3" (
    goto menu
) 
echo "Brak wyboru... powrot do menu."
pause
goto menu

:network_question
cls
echo =====================================================
echo 		** Polaczenie z siecia **   
echo =====================================================
echo 1) Switch %SWITCH_IP%
echo 2) Router %ROUTER_IP%
echo 3) Cofnij do menu glownego
echo -----------------------------------------------------
echo ** Wybierz odpowiednia opcje lub powrot do mene... **
echo =====================================================
echo.
set /p choice=">> Dokonaj wyboru: "

if "%choice%"=="1" (
    set /p LOGIN=">> Wprowadz login: "
    start cmd /k "ssh %LOGIN%@%SWITCH_IP%"
    goto menu
) 
if "%choice%"=="2" (
    set /p LOGIN=">> Wprowadz login: "
    start cmd /k "ssh %LOGIN%@%ROUTER_IP%"
    goto menu
)
if "%choice%"=="3" (
    goto menu
) 
echo "Brak wyboru... powrot do menu."
pause
goto menu

:disable_enable_question
cls
echo =====================================================
echo	 ** Zarzadzanie portami USB i napedami CD/DVD **   
echo =====================================================
echo 1) Wylacz porty USB i napedy CD/DVD
echo 2) Wlacz porty USB i napedy CD/DVD
echo 3) Cofnij do menu glownego
echo -----------------------------------------------------
echo ** Wybierz odpowiednia opcje lub powrot do mene... **
echo =====================================================
echo.
set /p usbchoice=">> Dokonaj wyboru: "

if "%usbchoice%"=="1" (
    powershell.exe -ExecutionPolicy Bypass -File "C:\Users\karol\Desktop\disable_ext_dev.ps1" DisableExtDev
    goto menu
) 
if "%usbchoice%"=="2" (
    powershell.exe -ExecutionPolicy Bypass -File "C:\Users\karol\Desktop\disable_ext_dev.ps1" EnableExtDev
    goto menu
)
if "%usbchoice%"=="3" (
    goto menu
) 
echo "Brak wyboru... powrot do menu."
pause
goto menu
