#!/bin/bash -eux

echo "configure locales and timezone ..."

# reconfigure tzdata
# debconf-set-selections <<< "tzdata  tzdata/Zones/$TZ_CONTINENT     select  $TZ_COUNTRY"
# debconf-set-selections <<< "tzdata  tzdata/Areas    select  $TZ_CONTINENT"
if [ -n "$TZ_COUNTRY" ]; then
    TZ="$TZ_CONTINENT/$TZ_COUNTRY"
else
    TZ="$TZ_CONTINENT"
fi

echo "$TZ" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

# reconfigure locale
debconf-set-selections <<< "locales locales/default_environment_locale      select  $DEFAULT_LOCALE.$DEFAULT_CHARSET"
debconf-set-selections <<< 'locales locales/locales_to_be_generated multiselect     en_US.UTF-8 UTF-8, fr_FR.UTF-8 UTF-8'
echo "LANG=$DEFAULT_LOCALE.$DEFAULT_CHARSET" | tee /etc/default/locale
sed -i "s/^#\s*\($DEFAULT_LOCALE.$DEFAULT_CHARSET $DEFAULT_CHARSET\)/\1/" /etc/locale.gen
dpkg-reconfigure --frontend noninteractive locales
locale-gen
