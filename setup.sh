#!/bin/bash
function removeApps()
{
	[ -L "/goinfre/$(whoami)/ln/.vscode" ] && rm -rf /Users/$(whoami)/.vscode
	[ -L "/goinfre/$(whoami)/ln/Caches" ] && rm -rf /Users/$(whoami)/Library/Caches
	[ -L "/goinfre/$(whoami)/ln/Code" ] && rm -rf /Users/$(whoami)/Library/Application\ Support/Code
	[ -L "/goinfre/$(whoami)/ln/Google" ] && rm -rf /Users/$(whoami)/Library/Application\ Support/Google
}

function openApps()
{
	/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --kiosk
	sleep 3
	killall Google\ Chrome
	VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode"
	sleep 3
	killall Electron
}

function moveApps()
{
	[ -d "/goinfre/$(whoami)/ln/.vscode" ] && mv /Users/$(whoami)/.vscode /goinfre/$(whoami)/ln/
	[ -d "/goinfre/$(whoami)/ln/Caches" ] && mv /Users/$(whoami)/Library/Caches /goinfre/$(whoami)/ln/
	[ -d "/goinfre/$(whoami)/ln/Code" ] && mv /Users/$(whoami)/Library/Application\ Support/Code /goinfre/$(whoami)/ln/
	[ -d "/goinfre/$(whoami)/ln/Google" ] && mv /Users/$(whoami)/Library/Application\ Support/Google /goinfre/$(whoami)/ln/
}

function linkApps()
{
	ln -s /goinfre/$(whoami)/ln/.vscode /Users/$(whoami)/.vscode
	ln -s /goinfre/$(whoami)/ln/Caches /Users/$(whoami)/Library/Caches
	ln -s /goinfre/$(whoami)/ln/Code /Users/$(whoami)/Library/Application\ Support/Code
	ln -s /goinfre/$(whoami)/ln/Google /Users/$(whoami)/Library/Application\ Support/Google
}

function installBrew()
{
	brew > brew_check 2>&1
	check=$(cat brew_check |  wc -l | tr -d " ")
	if [ $check -lt 5 ]
	then
		path_to="/goinfre/$(whoami)/"
		echo 'export path_to="/goinfre/$(whoami)/"' >> $HOME/.zshrc
		git clone https://github.com/Homebrew/brew $path_to/.brew
		echo 'export PATH=$path_to/.brew/bin:$PATH' >> $HOME/.zshrc
		source $HOME/.zshrc
		brew help
	fi
	rm brew_check
}

function createAliases()
{
	# push commites using (push "message") command
	echo "function push(){git add . && git commit -m "$1" && git push}" >> ~/.zshrc
	# open vs Code using (code) command
	echo "code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}" >> ~/.zshrc
}


[ ! -d "/bin/zsh" ] && echo "\n\nInstalling ZSH ..." && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "\n\nRemoving applications"
removeApps

echo "\n\nRestart applications"
openApps

echo "\n\nMoving applications to goinfre"
moveApps

echo "\n\nInstall Homebrew"
installBrew

echo "\n\nCreate aliases"
createAliases

# Install Node
node --version | grep "v" &> /dev/null
if [ $? == 1 ]; then
 echo "\n\nInstalling Node"
 brew install node
fi
