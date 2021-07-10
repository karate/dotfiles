My dotfiles for various cli applications that I use on a daily basis.

I'm using [gnu stow](https://www.gnu.org/software/stow) to manage them.

Usage:
```bash
# Clone repo. Make sure you checkout in a directory
# directly under your home directory. If you prefer not to,
# you should use something like `--target=$HOME` to make stow
# know your where to install files
git clone https://github.com/karate/dotfiles.git ~/karate_dotfiles
cd karate_dotfiles

# Install files per program
stow vim
stow i3

# Or install everything at once
for dir in */ ; do stow "$dir"; done
```
