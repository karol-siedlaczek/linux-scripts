#!/bin/bash

APP_NAME="<service name>"
RUN_PATH="<app run script?"
SCREEN_NAME="<screen name>"
APP_PORT=<app_port>

function START {
   echo "Starting ${APP_NAME}..."
   pid=$(ss -lptn sport = :$APP_PORT | awk '{print $6}' | grep -o 'pid=[0-9]*' | grep -o '[0-9]*')
   if [ -z "$pid" ]
   then
      screen -d -m -S $SCREEN_NAME $RUN_PATH
      echo "${APP_NAME} started"
   else
      echo "${APP_NAME} is already running with PID $pid, operation aborted"
      exit 0
   fi
}

function STOP {
   echo "Stopping ${APP_NAME}..."
   pid=$(ss -lptn sport = :$APP_PORT | awk '{print $6}' | grep -o 'pid=[0-9]*' | grep -o '[0-9]*')
   if [ -z "$pid" ]
   then
      echo "${APP_NAME} is not running, operation aborted"
      exit 0
   else
      kill -9 $pid
      echo "${APP_NAME} with PID ${pid} has been killed"
   fi
}

case "$1" in
  start)
    START;;
  stop)
    STOP;;
  restart)
    echo "Restarting ${APP_NAME}..."
    STOP
    START;;
  *)
    echo "Usage: /etc/init.d/node-exporter {start|stop|restart}"
    ;;
esac

exit 0