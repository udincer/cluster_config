HOFF_USERNAME='' # change this
FAV_NUMBER=0 # pick a number between 1024 and 65536

HOFF="${HOFF_USERNAME}@login2.hoffman2.idre.ucla.edu"

SSHH="ssh $HOFF"
SSHHT="ssh -t -L 8888:localhost:$FAV_NUMBER $HOFF ssh -t -L $FAV_NUMBER:localhost:$FAV_NUMBER \$(ssh $HOFF \"cat ~/.jupyter_hostname.txt\")"

echo "alias sshh='$SSHH'" >> ~/.bashrc
echo "alias sshht='$SSHHT'" >> ~/.bashrc