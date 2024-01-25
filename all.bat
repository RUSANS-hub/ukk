@echo off
setlocal enabledelayedexpansion

:menu
cls
echo Menu Options:
echo 1. Show All Docker
echo 2. Copy Docker Container
echo 3. Check Docker Images
echo 4. Start Nginx & PHP
echo 5. Generate SSH Key
echo 6. SSH Without Password (Linux)
echo 7. SSH Without Password (Windows)
echo 8. Exit

set /p option="Enter option number: "

if "%option%"=="1" (
    call :show_docker_list
) else if "%option%"=="2" (
    call :copy_docker_container
) else if "%option%"=="3" (
    call :check_images
) else if "%option%"=="4" (
    call :start_nginx_php
) else if "%option%"=="5" (
    call :generate_ssh_key
) else if "%option%"=="6" (
    call :ssh_without_password_linux
) else if "%option%"=="7" (
    call :ssh_without_password_windows
) else if "%option%"=="8" (
    echo Exiting...
    goto :eof
) else (
    echo Invalid option. Please try again.
    pause
    goto :menu
)

goto :menu

:show_docker_list
echo Show All Docker
docker ps -a
pause
goto :menu

:copy_docker_container
echo Copy Docker Container
set /p container_id="Enter Container ID: "
set /p image_name="Enter Image Name: "
docker commit !container_id! !image_name!
pause
goto :menu

:check_images
echo Check Docker Images
docker images
pause
goto :menu

:start_nginx_php
echo Start Nginx & PHP
/etc/init.d/nginx start
/etc/init.d/php7.4-fpm start
pause
goto :menu

:generate_ssh_key
echo Generate SSH Key
ssh-keygen
pause
goto :menu

:ssh_without_password_linux
echo SSH Without Password (Linux)
set /p ssh_path="Enter SSH Key Path (default: ~/.ssh/id_rsa): "
set /p ssh_port="Enter SSH Port: "
set /p ssh_ip="Enter Destination IP: "
ssh-copy-id -i "!ssh_path!" -p "!ssh_port!" ubuntu@!ssh_ip!
pause
goto :menu

:ssh_without_password_windows
echo SSH Without Password (Windows)
set /p ssh_path_win="Enter SSH Key Path (default: ~/.ssh/id_rsa): "
set /p ssh_port_win="Enter SSH Port: "
set /p ssh_ip_win="Enter Destination IP: "
ssh-keygen
type $env:USERPROFILE/.ssh/id_rsa.pub | ssh ubuntu@!ssh_ip_win! -p "!ssh_port_win!" "cat >>.ssh/authorized_keys"
pause
goto :menu
