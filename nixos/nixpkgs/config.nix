{

  allowUnfree = true;

  packageOverrides = pkgs : with pkgs; {
  
   myTexLive = texLiveAggregationFun {
     paths = [
       texLive texLiveExtra texLiveBeamer texLiveCMSuper #mathpartir
     ];
   };

   base-env = buildEnv {
     name = "base-env";
     paths = [
       acpi
       bgs
       bmon
       dmenu
       dunst
       i3lock
       inotify-tools
       htop
       networkmanagerapplet
       rxvt_unicode
       trayer
       unison
       haskellPackages.xmobar
       xclip
       xbindkeys
       xdotool
       xlibs.xinput
       xlibs.xmodmap
       zile
       zip
     ];
   };

   tools-env = buildEnv {
     name = "tools-env";
     paths = [
       binutils
       file
       ghostscript
       nox
       nix-repl
       imagemagick
       parallel
       psmisc
       pinpoint
       xfce.tumbler
       xfce.ristretto
       zsh-navigation-tools
     ];
   };

   archivers-env = buildEnv {
     name = "archivers-env";
     paths = [
       atool
       zip
       unzip
     ];
   };

   emacs-env = buildEnv {
     name = "emacs-env";
     paths = [
       emacs24
       emacs24Packages.autoComplete
       emacs24Packages.haskellMode
       emacs24Packages.magit
       emacs24Packages.org
       emacs24Packages.scalaMode2
       emacs24Packages.structuredHaskellMode
       emacs24Packages.writeGood
     ];
   };

   apps-env = buildEnv {
     name = "apps-env";
     paths = [
       calibre
       chromium
       feh
       firefox
       thunderbird
       llpp
       pass
       geeqie
       pcmanfm
       electrum
       quasselClient_qt5
     ];
   };

   spelling-env = buildEnv {
     name = "spelling-env";
     paths = [
       aspell
       aspellDicts.de
       aspellDicts.en
     ];
   };

   development-env = buildEnv {
     name = "development-env";
     paths = [
       gitFull
     ];
   };

   security-env = buildEnv {
     name = "security-env";
     paths = [
       apg
       gnupg
       pinentry
     ];
   };
   
  };
}





