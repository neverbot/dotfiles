
# Visual Studio Code 

## Command line

```bash
mkdir $HOME/bin
ln -s "/Applications/dev/Visual Studio Code.app/Contents/Resources/app/bin/code" $HOME/bin/code
```

## Configuration backup

Files: 

- `settings.json`: The Global configuration file, just copy its content.
- `keybindings.json`: The key bindings configuration file, just copy its content.

- `extensions.txt`: List of extensions used.

   * Get the list and update the file: `code --list-extensions > extensions.txt`.
   * Install every extension in the list: `cat extensions.txt | xargs -n 1 code --install-extension`.
   * To remove every extension installed: `code --list-extensions | xargs -n 1 code --uninstall-extension`.

- `custom-vscode.css` and `vscode-script.js` are for customizing the UI with the *Custom CSS and JS Loader* add-on.

  Add the following lines to `settings.json`:
  ```json
  "vscode_custom_css.imports": [
    "file://<path of this project>/dotfiles/vscode/custom-vscode.css",
    "file://<path of this project>/dotfiles/vscode/vscode-script.js"
  ],
  ```

Notes: Use soft links so the contents of this project are always in sync. 

```bash
rm /Users/<username>/Library/Application\ Support/Code/User/keybindings.json 
rm /Users/<username>/Library/Application\ Support/Code/User/settings.json 

ln -s /<path of this project>/dotfiles/vscode/settings.json /Users/<username>/Library/Application\ Support/Code/User/settings.json
ln -s /<path of this project>/dotfiles/vscode/keybindings.json /Users/<username>/Library/Application\ Support/Code/User/keybindings.json
```

Lots of examples taken from:

- https://github.com/glennraya/vscode-settings-json
- https://www.youtube.com/watch?v=9_I0bySQoCs