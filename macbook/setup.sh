

# add this to .bash_profile
# if [ -f $HOME/.bashrc ]; then
#         source $HOME/.bashrc
# fi

# sublime text -> subl command line
sudo mkdir /usr/local/bin
sudo chown umut /usr/local/bin
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

echo "alias ..='cd ..'" >> ~/.bashrc
echo "alias ...='cd ...'" >> ~/.bashrc
echo "alias ....='cd ....'" >> ~/.bashrc

## set up hoffman
HOFF_USERNAME=‘dincer’ # change this
FAV_NUMBER='24567' # pick a number between 1024 and 65536

HOFF="${HOFF_USERNAME}@login2.hoffman2.idre.ucla.edu"

SSHH="ssh $HOFF"
SSHHT="ssh -t -L 8888:localhost:$FAV_NUMBER $HOFF ssh -t -L $FAV_NUMBER:localhost:$FAV_NUMBER \$(ssh $HOFF \"cat ~/.jupyter_hostname.txt\")"

echo "alias sshh='$SSHH'" >> ~/.bashrc
echo "alias sshht='$SSHHT'" >> ~/.bashrc