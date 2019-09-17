@ECHO OFF
rem kill firefox
taskkill /IM firefox.exe

rem fetch processes running on port 8080 and kill them
for /f "tokens=5 delims= " %%a in (
	'netstat -aon ^| find ":8085" ^| find "LISTENING"'
) do (
	taskkill /f /pid %%a
	goto git-phase
)

:git-phase
rem Go to the JAR build
cd C:\Users\thewo\dev\gs-rest-service\initial

rem Git fetch and reset to master for no merging worries
rem git fetch --all
rem git reset --hard origin/master

rem Build Maven and run the JAR as a background process [shall be task listed as javaw.exe]
mvn package && javaw -jar target/gs-rest-service-0.1.0.jar --server.port=8085 && timeout /t 10 > NUL && start "" http://localhost:8085/greeting