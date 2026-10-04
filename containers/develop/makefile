build:
	cp ~/Software/dotfiles/dotfiles/emacs/.emacs.d/init.el .
	podman build -f Containerfile -t develop-image .
	rm -f init.el

run:
	podman run --rm -it \
	  -e TERM=xterm-256color \
	  -e COLORTERM=truecolor \
	  -v ~/Software/dotfiles/dotfiles/emacs/.emacs.d:/home/x/.emacs.d \
	  -v ~/Software/:/home/x/Software/ \
	  -v ~/Documents/:/home/x/Documents/ \
	  -v ~/Downloads/:/home/x/Downloads/ \
	  --name develop \
	  develop-image
