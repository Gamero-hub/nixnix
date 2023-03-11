{
...
}:{
    programs.kitty = {
        enable = true;
	    extraConfig = import ./colors/decayce.nix;
	    settings = {
            font_size = "15";
	        font_family = "Iosevka Term Nerd Font Complete Medium Italic";
	        confirm_os_window_close = "0";
	        cursor_shape = "Beam";
            window_padding_width = "10";

	    tab_bar_edge = "top";
	    tab_bar_style = "powerline";
	    tab_bar_align = "left";
	    tab_powerline_style = "round";
	    tab_title_template = "{fmt.fg.tab}{title}";
	};
    };
}
