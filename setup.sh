echo "\n\e[92mInstalling ZSH ...\e[39m"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "\n\e[92mInstalling brew ...\e[39m"
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

echo "alias code='/goinfre/$(whoami)/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'" >> ~/.zshrc
echo "function push(){git add . && git commit -m "$1" && git push}" >> ~/.zshrc
echo "\n\e[92mInstalling yarn with its dependencies... (node, nghttp2, openssl, jemalloc, libev, ...)\e[39m"
brew install yarn

echo "\n\e[92mCloning Moder Stream...\e[39m"
git clone https://github.com/ayour-labs/modern-stream.git /goinfre/$(whoami)/modern-stream

echo "\n\e[92mRun Modern Stream Project\e[39m"
cd /goinfre/$(whoami)/modern-stream && code . && yarn install && yarn start
