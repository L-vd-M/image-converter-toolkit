function png2ico --description "Convert PNG to multi-resolution ICO via ImageMagick"
    if test (count $argv) -lt 1
        echo "Usage: png2ico input.png [output.ico]"
        return 1
    end

    set input $argv[1]
    set output (string replace -r '\.png$' '.ico' $input)
    if test (count $argv) -ge 2
        set output $argv[2]
    end

    convert "$input" -define icon:auto-resize="256,128,64,48,32,16" "$output"
    echo "Created: $output"
end
