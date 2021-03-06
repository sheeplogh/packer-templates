sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

### disable yum repository "base""updates""extras"
sed -i "s/^\[base\]$/[base]\\nenabled=0/g" /etc/yum.repos.d/CentOS-Base.repo
sed -i "s/^\[updates\]$/[updates]\\nenabled=0/g" /etc/yum.repos.d/CentOS-Base.repo
sed -i "s/^\[extras\]$/[extras]\\nenabled=0/g" /etc/yum.repos.d/CentOS-Base.repo

### disable yum plugin "fastestmirror"
sed -i "s/^enabled=1$/#enabled=1\\nenabled=0/g" /etc/yum/pluginconf.d/fastestmirror.conf

### add yum repository "C6.2-*" on ftp.riken.jp
cat > /etc/yum.repos.d/c62.repo << EOM
[C6.2-base]
name=CentOS-6.2 - Base
baseurl=http://ftp.riken.jp/Linux/centos/6.2/os/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
enabled=1

[C6.2-updates]
name=CentOS-6.2 - Updates
baseurl=http://ftp.riken.jp/Linux/centos/6.2/updates/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
enabled=1

[C6.2-extras]
name=CentOS-6.2 - Extras
baseurl=http://ftp.riken.jp/Linux/centos/6.2/extras/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
enabled=1

[C6.2-contrib]
name=CentOS-6.2 - Contrib
baseurl=http://ftp.riken.jp/Linux/centos/6.2/contrib/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
enabled=0

[C6.2-centosplus]
name=CentOS-6.2 - CentOSPlus
baseurl=http://ftp.riken.jp/Linux/centos/6.2/centosplus/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
enabled=0
EOM

sudo yum -y --disablerepo=base,updates --enablerepo=C6.2-base,C6.2-updates --disableplugin=fastestmirror install \
		gcc make gcc-c++ kernel-devel-`uname -r` kernel-headers-`uname -r` perl
