#!/bin/bash

# Get the city name from location information
city=$(curl -s https://ipinfo.io/city)

# Fetch and display weather details for the detected city
weather=$(curl -s "wttr.in/${city}?format=3")

echo "$weather"
