#!/bin/sh

# android sdk
if [ ! -d "${HOME}/Android/sdk" ]; then
	echo "downloading android tools archive"
	curl https://dl.google.com/android/repository/tools_r25.2.3-linux.zip -o /tmp/android_tools.zip
	mkdir -p ${HOME}/Android/sdk
	unzip /tmp/android_tools.zip -d ${HOME}/Android/sdk
fi

if [ -z "${ANDROID_HOME}" ]; then
	echo "export ANDROID_HOME=\${HOME}/Android/sdk" >> ~/.bashrc
	echo "export PATH=\${PATH}:\${ANDROID_HOME}/tools" >> ~/.bashrc
	echo "export PATH=\${PATH}:\${ANDROID_HOME}/tools/bin" >> ~/.bashrc
	echo "export PATH=\${PATH}:\${ANDROID_HOME}/platform-tools" >> ~/.bashrc
	. ~/.bashrc
fi
	
mkdir -p ${HOME}/.android
cat << EOF > ~/.android/repositories.cfg
### User Sources for Android SDK Manager
count=0
EOF

echo "installing tools"
yes | sdkmanager "tools"
echo "installing build-tools"
sdkmanager "build-tools;23.0.1"
echo "installing android m2 repository"
sdkmanager "extras;android;m2repository"
echo "installing google APIs add-on"
sdkmanager "add-ons;addon-google_apis-google-23"
echo "installing android platform"
sdkmanager "platforms;android-23"
echo "installing android sources"
sdkmanager "sources;android-23"
echo "installing android system image x86_64"
sdkmanager "system-images;android-23;default;x86_64"
echo "installing android system image google APIs x86_64"
sdkmanager "system-images;android-23;google_apis;x86_64"

echo "creating react_dev android virtual device"
avdmanager create avd -k "system-images;android-23;default;x86_64" -n react_dev

# nuclide extras setup
apm install nuclide tool-bar sort-lines language-ocaml language-babel haskell-grammar highlight-selected language-ini language-lua merge-conflicts nuclide-format-js set-syntax

