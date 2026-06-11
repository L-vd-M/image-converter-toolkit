function png2svg --description "Trace PNG to SVG using VTracer"
    if test (count $argv) -lt 1
        echo "Usage: png2svg input.png [output.svg] [--bw|--poster|--photo]"
        return 1
    end

    set input $argv[1]
    set output (string replace -r '\.png$' '.svg' $input)
    set preset "photo"

    for arg in $argv[2..]
        switch $arg
            case "*.svg"
                set output $arg
            case "--bw"
                set preset "bw"
            case "--poster"
                set preset "poster"
            case "--photo"
                set preset "photo"
        end
    end

    if test "$preset" = "bw"
        convert "$input" -threshold 50% pbm:- | potrace -s -o "$output" -
    else
        vtracer --input "$input" --output "$output" --preset "$preset"
    end
end
