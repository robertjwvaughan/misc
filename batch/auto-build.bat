@ECHO OFF
for /f "tokens=5 delims= " %%a in ('netstat -aon ^| find ":8085" ^| find "LISTENING"') do taskkill /f /pid %%a
cd C:\Users\thewo\dev\gs-rest-service\initial
git fetch --all
git reset --hard origin/master
mvn package && javaw -jar target/gs-rest-service-0.1.0.jar --server.port=8085 && start "" http://localhost:8085/greeting