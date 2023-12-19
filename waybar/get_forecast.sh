#!/bin/bash

FORECAST_URL=$(curl 'https://api.weather.gov/points/39.749,-105.221' | jq -r '.properties.forecast')

CURRENT_WEATHER=$(curl "$FORECAST_URL" | jq '.properties.periods[0]')

CURRENT_TEMPERATURE=$(echo $CURRENT_WEATHER | jq -r '.temperature')
CURRENT_TEMPERATURE_UNIT=$(echo $CURRENT_WEATHER | jq -r '.temperatureUnit')

echo "$CURRENT_TEMPERATURE"° "$CURRENT_TEMPERATURE_UNIT"
