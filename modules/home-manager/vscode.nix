{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions;
      [
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
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "discord-vscode";
          publisher = "icrawl";
          version = "5.8.0";
          sha256 = "sha256-IU/looiu6tluAp8u6MeSNCd7B8SSMZ6CEZ64mMsTNmU=";
        }
        {
          publisher = "Vue";
          name = "volar";
          version = "1.8.27";
          sha256 = "sha256-KfWgdz61NURmS1cwFsE9AmIrEykyN5MXIKfG8gDfmac=";
        }
      ];
  };
}
