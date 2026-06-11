function export-svg-sizes --description "Export SVG to PNG at multiple sizes via Inkscape"
    if test (count $argv) -lt 1
        echo "Usage: export-svg-sizes input.svg [basename] [sizes...]"
        return 1
    end

    set input $argv[1]
    set base (string replace -r '\.svg$' '' $input)
    set sizes 16 32 48 64 128 256 512

    if test (count $argv) -ge 2
        if string match -qr '^\d+$' $argv[2]
            set sizes $argv[2..]
        else
            set base $argv[2]
            if test (count $argv) -ge 3
                set sizes $argv[3..]
            end
        end
    end

    for size in $sizes
        set outfile "$base-$size.png"
        inkscape "$input" --export-type=png --export-filename="$outfile" -w $size -h $size
        echo "Exported: $outfile"
    end
end
