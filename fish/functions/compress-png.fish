function compress-png --description "Optimize PNG: lossless (oxipng) or lossy (pngquant)"
    if test (count $argv) -lt 1
        echo "Usage: compress-png input.png [output.png] [--lossy]"
        return 1
    end

    set input $argv[1]
    set output $input
    set lossy false

    for arg in $argv[2..]
        switch $arg
            case "--lossy"
                set lossy true
            case "*.png"
                set output $arg
        end
    end

    if test "$lossy" = true
        pngquant --quality=80-90 "$input" --output "$output" --force
        echo "Compressed (lossy): $output"
    else
        if test "$output" != "$input"
            cp "$input" "$output"
            oxipng -o 3 "$output"
        else
            oxipng -o 3 "$input"
        end
        echo "Compressed (lossless): $output"
    end
end
