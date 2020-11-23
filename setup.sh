echo "Installing oh-my-zsh ..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

echo "Installing Docker"
brew install Docker

echo "Installing Minikube"
brew install minikube
export MINIKUBE_HOME=/goinfre/$(whoami)
minikube start
eval $(minikube -p minikube docker-env)