
# Visual Studio Code configuration backup

Files: 

- `settings.json`: The Global configuration files, just copy its content.

  Use hard links on Mac OS so the contents are always in sync.
  `ln /Users/<username>/Library/Application\ Support/Code/User/settings.json settings.json`

- `extensions.txt`: List of extensions used.

   * Get the list and update the file: `code --list-extensions > extensions.txt`.
   * Install every extension in the list: `cat extensions.txt | xargs -n 1 code --install-extension`.
   * To remove every extension installed: `code --list-extensions | xargs -n 1 code --uninstall-extension`.

