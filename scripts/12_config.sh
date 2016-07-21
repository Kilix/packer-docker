#!/bin/bash -eux

# get git contrib scripts
mkdir /home/vagrant/.git-contrib
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O /home/vagrant/.git-contrib/git-completion.bash
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O /home/vagrant/.git-contrib/git-prompt.sh
chown -R vagrant:vagrant /home/vagrant/.git-contrib

# add custom git prompt
`git clone https://github.com/magicmonty/bash-git-prompt.git /opt/bash-git-prompt`

echo "copying config files ..."
cp -R $DATA_DIR/etc/bash.bashrc /etc
cp -R $DATA_DIR/etc/screenrc /etc
cp -R $DATA_DIR/etc/skel /etc
cp -R $DATA_DIR/etc/vim /etc
cp -R $DATA_DIR/root /
cp -R $DATA_DIR/etc/skel/.bash_aliases /root/
cp -R $DATA_DIR/etc/skel/.gitconfig /root/
cp -R $DATA_DIR/etc/skel/.gitignore /root/
cp -R $DATA_DIR/etc/skel/.git-prompt-colors.sh /root/
cp -R $DATA_DIR/etc/skel/.bash_aliases /home/$ADMIN_USER
cp -R $DATA_DIR/etc/skel/.bashrc /home/$ADMIN_USER
cp -R $DATA_DIR/etc/skel/.gitconfig /home/$ADMIN_USER
cp -R $DATA_DIR/etc/skel/.gitignore /home/$ADMIN_USER
cp -R $DATA_DIR/etc/skel/.git-prompt-colors.sh /home/$ADMIN_USER
chown -R $ADMIN_USER:$ADMIN_USER /home/$ADMIN_USER

# set global vagrant user git exclude file
`sudo -u vagrant git config --global core.excludesfile /home/$ADMIN_USER/.gitignore`
