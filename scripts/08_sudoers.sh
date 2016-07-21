#!/bin/bash -eux

# Only add the secure path line if it is not already present - Debian 7
# includes it by default.
grep -q 'secure_path' /etc/sudoers || sed -i -e '/Defaults\s\+env_reset/a Defaults\tsecure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"' /etc/sudoers

# define restricted commands aliases
sed -i -e "/# Cmnd alias specification/a\\
Cmnd_Alias SHELLS = /bin/sh, /bin/rsh, /bin/bash, /bin/dash \\
Cmnd_Alias SU = /bin/su \\
Cmnd_Alias PASSWORD = /usr/bin/passwd \\
" /etc/sudoers

echo -e "# allow group $ADMIN_USER and $ADMIN_USER user to use sudo without password\n\
%$ADMIN_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/99_$ADMIN_USER

# vagrant prefers no tty
echo "Defaults !requiretty" >> /etc/sudoers
