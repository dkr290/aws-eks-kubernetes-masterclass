npm install -g aws-cdk
cdk --version
cdk init app --language python


# in case already installed
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt


# to deploy
cdk ls
cdk synth
cdk deploy


