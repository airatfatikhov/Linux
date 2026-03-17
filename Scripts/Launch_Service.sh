#Получаем дату...
$Date = Get-Date;

#Именуем службу...
$Service_Name = "Zabbix Agent";

#Фиксируем службу в переменной...
$Service = Get-Service -Name $Service_Name;

#Тип запуска Автоматический(отложенный запуск)
$Automatic_Delayed_Start = Set-Service 'Zabbix Agent' -StartupType AutomaticDelayedStart;

#Тип запуска Отключена
$Disabled_Delayed_Start = Set-Service 'Zabbix Agent' -StartupType Disabled;

#Тип запуска вручную
$Manual_Delayed_Start = Set-Service 'Zabbix Agent' -StartupType Manual;

#Тип запуска Автоматически
$Auto_Delayed_Start = Set-Service 'Zabbix Agent' -StartupType Automatic;

#проверяем существует ли вообще такая служба...
if (Get-Service -Name $Service_Name -ErrorAction SilentlyContinue)
{
$Status_Service_exist = Write-Host "Service exist";
Write-Host $Service_Status = $Service.StartType;
}
else
{
$Status_Service_No_Exist = Write-Host "Service no exist";
$Service_Status_Default = $Service.StartType;
}

#провярем тип запуска службы
if ($Automatic_Delayed_Start)
{
$Automatic_Delayed_Start_false = $true;
#$Automatic_Delayed_Start_Launch = -StartupType "AutomaticDelayedStart";
}

#провярем тип запуска службы
if ($Disabled_Delayed_Start)
{
$Disabled_Delayed_Start_false = $false;
Set-Service 'Zabbix Agent' -StartupType AutomaticDelayedStart;
#$Automatic_Delayed_Start_Launch = -StartupType "AutomaticDelayedStart";
}
#провярем тип запуска службы
if ($Manual_Delayed_Start)
{
$Manual_Delayed_Start_false = $false;
Set-Service 'Zabbix Agent' -StartupType AutomaticDelayedStart;
}
#провярем тип запуска службы
if($Auto_Delayed_Start)
{
Set-Service 'Zabbix Agent' -StartupType AutomaticDelayedStart;
}
#проверяем,если не запущена служба, то включаем, если запущена, то просто выводим информацию...
if ( $Service.Status -ne 'Running')
{
$Output_No_Launch = Write-Host "No_Launch : $Service_Name ..."
Start-Service $Service_Name
$bool_station_service = $false
#Отправляем отчет, если не были запущены процессы
$Date,$Service_Name, $Service, $bool_station_service, $Output_No_Launch >> C:\VSK\Logs\Zabbix_Service_Error.txt
}
else
{
$Output_Launch = Write-Host "Launch : $Service_Name ..."
$bool_station_service = $true
#Отправялем отчет, если всё успешно
$Date,$Service_Name, $Service, $bool_station_service, $Output_Launch, $Status_Service_exist >> C:\VSK\Logs\Zabbix_Service_Succes.txt
}