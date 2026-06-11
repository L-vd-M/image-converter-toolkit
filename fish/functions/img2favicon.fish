function img2favicon --description "PNG/SVG → favicon.ico + favicon.svg set"
    if test (count $argv) -lt 1
        echo "Usage: img2favicon input.[png|svg] [basename]"
        return 1
    end

    set input $argv[1]
    set base "favicon"
    if test (count $argv) -ge 2
        set base $argv[2]
    end

    set ext (string lower (path extension $input))

    if test "$ext" = ".svg"
        cp "$input" "$base.svg"
        svg2ico "$input" "$base.ico"
    else if test "$ext" = ".png"
        png2svg "$input" "$base.svg"
        png2ico "$input" "$base.ico"
    else
        echo "img2favicon: unsupported input format '$ext'" >&2
        return 1
    end

    echo "Favicon set created: $base.svg + $base.ico"
end
