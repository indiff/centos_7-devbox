#!/bin/sh

# update the system
# apt-get update
# apt-get -y upgrade

system_install() {

    ################################################################################
    # Install the mandatory tools
    ################################################################################

    # install utilities
    yum -y install vim git zip bzip2 fontconfig curl language-pack-en unzip python g++ build-essential

    # install Java 8
    yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel

    ################################################################################
    # Install the graphical environment
    ################################################################################

    # force encoding
    echo 'LANG=en_US.UTF-8' >> /etc/environment
    echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
    echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
    echo 'LC_CTYPE=en_US.UTF-8' >> /etc/environment

    # run GUI as non-privileged user
    echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config

    # install Ubuntu desktop and VirtualBox guest tools
    yum install epel-release -y
    yum groupinstall "Server with GUI" -y
    yum groupinstall "Xfce" -y
    systemctl set-default graphical.target
    yum install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

    ## change the default wallpaper
    #wget https://raw.githubusercontent.com/VSaliy/centos_7-devbox/master/images/extenda_wallpaper.jpg -O /usr/share/xfce4/backdrops/extenda_wallpaper.jpg
    #sed -i -e 's/extenda_wallpaper.jpg/' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

    ################################################################################
    # Install the development tools
    ################################################################################

    # install MySQL Workbench
    yum install -y mysql-workbench

    # install Guake
    yum install -y guake
    cp /usr/share/applications/guake.desktop /etc/xdg/autostart/

    # install zsh
    yum install -y zsh

    # install oh-my-zsh
    git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
    cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc
    chsh -s /bin/zsh vagrant
    echo 'SHELL=/bin/zsh' >> /etc/environment

    # install jhipster-oh-my-zsh-plugin
    git clone https://github.com/jhipster/jhipster-oh-my-zsh-plugin.git /home/vagrant/.oh-my-zsh/custom/plugins/jhipster
    sed -i -e "s/plugins=(git)/plugins=(git docker docker-compose jhipster)/g" /home/vagrant/.zshrc
    echo 'export PATH="$PATH:/usr/bin:/home/vagrant/.yarn-global/bin:/home/vagrant/.yarn/bin:/home/vagrant/.config/yarn/global/node_modules/.bin"' >> /home/vagrant/.zshrc

    # change user to vagrant
    chown -R vagrant:vagrant /home/vagrant/.zshrc /home/vagrant/.oh-my-zsh
}

# fix ownership of home
setup_mysql() {
    wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
	rpm -ivh mysql57-community-release-el7-9.noarch.rpm
	yum install -y mysql-server
	systemctl start mysqld
	systemctl status mysqld
	##oe1nhBfW<g#
}

# fix ownership of home
fix_ownership_of_home() {
    chown -R vagrant:vagrant /home/vagrant/
}

# ============================================================================
system_install
fix_ownership_of_home
