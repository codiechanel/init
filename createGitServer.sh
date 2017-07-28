sudo adduser git
su git
cd $HOME
mkdir .ssh && chmod 700 .ssh
touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys
cat id_rsa.pub >> ~/.ssh/authorized_keys
mkdir project.git
cd project.git
git init --bare

# on remote client computer
git remote add origin git@gitserver:/home/git/project.git
or
git remote add origin git@gitserver:project.git
