function bw-trace --description "B&W logo trace via potrace (sharper curves than VTracer)"
    if test (count $argv) -lt 1
        echo "Usage: bw-trace input.png [output.svg]"
        return 1
    end

    set input $argv[1]
    set output (string replace -r '\.png$' '.svg' $input)
    if test (count $argv) -ge 2
        set output $argv[2]
    end

    convert "$input" -threshold 50% pbm:- | potrace -s -o "$output" -
    echo "Created: $output"
end
