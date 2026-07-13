#!/bin/bash

sudo dnf update -y

sudo dnf install -y mariadb105 wget

sudo dnf install -y telnet || true

mysql --version