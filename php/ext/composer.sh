#!/bin/bash

echo Installing Composer

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

echo Installing Composer Done
