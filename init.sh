#!/bin/bash

SERVICE_NAME="service_name"

function START {
    echo "Starting ${SERVICE_NAME}..."
    is_active=$(systemctl is-active $SERVICE_NAME)
    if [ "$is_active" == "active" ]
    then
        echo "${SERVICE_NAME} is already running, operation aborted"
    else
        systemctl start $SERVICE_NAME.service
        echo "${SERVICE_NAME} started"
    fi
}

function STOP {
    echo "Stopping ${SERVICE_NAME}..."
    is_active=$(systemctl is-active $SERVICE_NAME)
    if [ "$is_active" == "active" ]
    then
        systemctl stop $SERVICE_NAME.service
        echo "${SERVICE_NAME} has been stopped"
    else
        echo "${SERVICE_NAME} is not running, operation aborted"
    fi
}

function RESTART {
    echo "Restarting ${APP_NAME}..."
    is_active=$(systemctl is-active $SERVICE_NAME)
    if [ "$is_active" == "active" ]
    then
      systemctl restart $SERVICE_NAME.service
      echo "${SERVICE_NAME} restarted"
    else
      echo "${SERVICE_NAME} is not running, operation aborted"
    fi
}

function STATUS {
    systemctl status $SERVICE_NAME.service
}

case "$1" in
    start)
        START;;
    stop)
        STOP;;
    restart)
        RESTART;;
    status)
        STATUS;;
    *)
        echo "Usage: $(realpath "$0") {start|stop|restart|status}";;
esac

exit 0
