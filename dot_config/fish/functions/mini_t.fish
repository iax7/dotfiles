function mini_t -d "Print a small section header, e.g. mini_t update"
    set_color red
    echo -n -- " -- "
    set_color blue
    echo -n "$argv"
    set_color red
    echo -n -- " --"
    set_color normal
    echo
end
