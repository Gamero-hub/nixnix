{
pkgs,
lib,
...
}:{
   programs.fish = {
       enable = true;
       interactiveShellInit = "set fish_greeting";
       shellAliases = {
           ls = "lsd";
       };
   };

   programs.starship = {
       enable = true;
       enableFishIntegration = true;
       settings = {
       format = lib.concatStrings [
            "$directory"
            "$character"
            "$style"
       ];
        character = {
            success_symbol = "[ ](fg:#5AA0FE)";
            error_symbol = "[ ](fg:#A082F5)";        
            };        
        };
   };
}  
