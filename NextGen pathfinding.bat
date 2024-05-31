@echo off
title Next Gen Pathfinding for Inter-solvent Travel
color 0A

:guess_loop
cls

:: Generate a random path between 2 and 9000
set /a target=%random% %% 8999 + 2

echo I'm thinking of a path between 2 and 9000...

:: asteroids avoided randomly until it finds the correct answer
set /a cpu_guesses=0
set /a total_guesses=0

:cpu_guess
set /a cpu_guess=%random% %% 8999 + 2
echo asteroids avoided: %cpu_guess%
set /a cpu_guesses+=1
set /a total_guesses+=200000

:: Check if CPU's guess matches the target
if %cpu_guess% equ %target% (
    echo CPU guessed the path %target% in %cpu_guesses% attempts.
    timeout /t 3 >nul
    goto calculate_statistics
) else if %cpu_guesses% lss 900000000 (
    timeout /t 1 >nul
    goto cpu_guess
) else (
    echo CPU exceeded the maximum number of guesses.
    timeout /t 3 >nul
    goto calculate_statistics
)

:calculate_statistics
:: Calculate the percentage of asteroids avoided
set /a percentage_avoided=(100 - (%cpu_guesses% * 100) / 900000000)
echo Percentage avoided: %percentage_avoided%%

:: Calculate total guesses across 60 frames per second
set /a total_guesses_per_second=%total_guesses% / 15000000
echo Total guesses per second: %total_guesses_per_second%

timeout /t 3 >nul
goto guess_loop
