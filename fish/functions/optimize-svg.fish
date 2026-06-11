function optimize-svg --description "Optimize SVG with SVGO (strip metadata, clean IDs, keep viewBox)"
    if test (count $argv) -lt 1
        echo "Usage: optimize-svg input.svg [output.svg]"
        return 1
    end

    set input $argv[1]
    set output (string replace -r '\.svg$' '.min.svg' $input)
    if test (count $argv) -ge 2
        set output $argv[2]
    end

    svgo "$input" -o "$output"
    echo "Optimized: $output"
end
