{ config, pkgs, ... }:
# TODO: refactor
let 
  config = ''
    [[columns]]
    kind = "Pid"
    style = "BrightYellow"
    numeric_search = true
    nonnumeric_search = false
    align = "Left"

    [[columns]]
    kind = "User"
    style = "BrightGreen"
    numeric_search = false
    nonnumeric_search = true
    align = "Left"

    [[columns]]
    kind = "Separator"
    style = "White"
    numeric_search = false
    nonnumeric_search = false
    align = "Left"

    [[columns]]
    kind = "Tty"
    style = "BrightWhite"
    numeric_search = false
    nonnumeric_search = false
    align = "Left"

    [[columns]]
    kind = "UsageCpu"
    style = "ByPercentage"
    numeric_search = false
    nonnumeric_search = false
    align = "Right"

    [[columns]]
    kind = "UsageMem"
    style = "ByPercentage"
    numeric_search = false
    nonnumeric_search = false
    align = "Right"

    [[columns]]
    kind = "CpuTime"
    style = "BrightCyan"
    numeric_search = false
    nonnumeric_search = false
    align = "Left"

    [[columns]]
    kind = "Separator"
    style = "White"
    numeric_search = false
    nonnumeric_search = false
    align = "Left"

    [[columns]]
    kind = "Command"
    style = "BrightWhite"
    numeric_search = false
    nonnumeric_search = true
    align = "Left"

    [style]
    header = "BrightWhite"
    unit = "BrightWhite"
    tree = "BrightWhite"

    [style.by_percentage]
    color_000 = "BrightBlue"
    color_025 = "BrightGreen"
    color_050 = "BrightYellow"
    color_075 = "BrightRed"
    color_100 = "BrightRed"

    [style.by_state]
    color_d = "BrightRed"
    color_r = "BrightGreen"
    color_s = "BrightBlue"
    color_t = "BrightCyan"
    color_z = "BrightMagenta"
    color_x = "BrightMagenta"
    color_k = "BrightYellow"
    color_w = "BrightYellow"
    color_p = "BrightYellow"

    [style.by_unit]
    color_k = "BrightBlue"
    color_m = "BrightGreen"
    color_g = "BrightYellow"
    color_t = "BrightRed"
    color_p = "BrightRed"
    color_x = "BrightBlue"

    [search]
    numeric_search = "Exact"
    nonnumeric_search = "Partial"
    logic = "And"

    [display]
    show_self = false
    cut_to_terminal = true
    cut_to_pager = false
    cut_to_pipe = false
    color_mode = "Auto"
    separator = "│"
    ascending = "▲"
    descending = "▼"
    tree_symbols = ["│", "─", "┬", "├", "└"]
    abbr_sid = true

    [sort]
    column = 0
    order = "Ascending"

    [docker]
    path = "unix:///var/run/docker.sock"

    [pager]
    mode = "Auto"
  '';
in {
  home.packages = [ pkgs.procs ];
  home.file.".config/procs/config.toml".text = config;
}
