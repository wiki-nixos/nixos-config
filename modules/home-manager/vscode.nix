{ pkgs, ... }:

{
  programs.vscode = {
  enable = true;
  extensions = with pkgs.vscode-extensions; [
    ms-azuretools.vscode-docker
    github.copilot
    unifiedjs.vscode-mdx
    serayuzgur.crates
    tamasfe.even-better-toml
    svelte.svelte-vscode
    ms-python.python
    rust-lang.rust-analyzer
    emmanuelbeziat.vscode-great-icons
    esbenp.prettier-vscode
    dbaeumer.vscode-eslint
    oderwat.indent-rainbow
    jnoortheen.nix-ide
  ];
 };
}
