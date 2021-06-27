echo "Installing brew ..."
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

echo "Installing yarn with its dependencies... (node, nghttp2, openssl, jemalloc, libev, ...)"
brew install yarn

echo "clone Reop"
cd /goinfre/$(whoami)
git clone https://github.com/ayour-labs/modern-stream.git

echo "Run Modern Stream Project"
cd /goinfre/$(whoami)/modern-stream && yarn install && code . && yarn start
