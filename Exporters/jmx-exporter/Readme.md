# Шаг 1: Настройка Java-приложения (Target Host)
Предположим, вы мониторите приложение на сервере app-server.example.com.

## 1.1. Создание файлов аутентификации
Создайте директорию для файлов безопасности (например, /etc/jmx/):
````
sudo mkdir -p /etc/jmx-exporter/
sudo chmod 700 /etc/jmx-exporter/
````

## Файл /etc/jmx/jmxremote.access (права доступа):
````
# Формат: username rights
monitorUser readonly
adminUser readwrite
````

## Файл /etc/jmx/jmxremote.password (пароли):
````
# Формат: username password
monitorUser StrongPassword123!
adminUser SuperSecretAdminPass456!
````

````
sudo chown appuser:appuser /etc/jmx-exporter/jmxremote.*
sudo chmod 600 /etc/jmx-exporter/jmxremote.*
````

## 1.2. Настройка JVM параметров
Добавьте следующие системные свойства при запуске Java-приложения. Это можно сделать в скрипте запуска, в setenv.sh (для Tomcat) или в параметрах systemd.
Основные параметры:
````
-Dcom.sun.management.jmxremote
-Dcom.sun.management.jmxremote.port=10099
-Dcom.sun.management.jmxremote.ssl=false
-Dcom.sun.management.jmxremote.authenticate=true
-Dcom.sun.management.jmxremote.password.file=/etc/jmx-exporter/jmxremote.password
-Dcom.sun.management.jmxremote.access.file=/etc/jmx-exporter/jmxremote.access
-Djava.rmi.server.hostname=app-server.example.com
````

