@echo off
title Wifi connection tester adn resetter
:: let this script run at the background

:: these are parameters to fix
set mynetwork="YOUR NETWORK NAME"
set timeout=5
set myIP="208.67.222.222"
set use_hard_reset = 0

set failCounter=0
set totalCounter=0

goto :pingtest

:pingtest
echo Pinging IP %myIP%
set /a totalCounter+=1
ping -w 1250 -n 2 %myIP% | find "TTL"
if errorlevel 1 (
    echo.
    echo !!!!!!! ping failed !!!!!!!
    if "%use_hard_reset%"=="1" (
        goto :fail_hard
    ) else (
        goto :fail_soft
    )
) else (
    goto :success
)

:fail_soft
:: Increment the counter each time failure occurs
set /a failCounter+=1
echo soft reconnecting wifi to '%mynetwork%'
:: disconned and connect, keep adapter on
netsh wlan disconnect
netsh wlan connect ssid=%mynetwork% name=%mynetwork%
timeout /t 2 /nobreak > nul
goto :pingtest

:fail_hard
:: Increment the counter each time failure occurs
set /a failCounter+=1
echo resetting adapter
:: hard off and on adapter
interface set interface "WiFi" admin=disabled
timeout /t 1 /nobreak > nul
interface set interface "WiFi" admin=enabled
netsh wlan connect ssid=%mynetwork% name=%mynetwork%
timeout /t 2 /nobreak > nul
goto :pingtest

:success
echo Still connected (%failCounter% failed out of %totalCounter%)
timeout /t "%timeout%" /nobreak
goto :pingtest
