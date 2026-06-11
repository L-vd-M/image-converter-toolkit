function enhance-img --description "Sharpen, upscale, strip metadata from PNG"
    if test (count $argv) -lt 1
        echo "Usage: enhance-img input.png [output.png] [--size 2000] [--sharpen]"
        return 1
    end

    set input $argv[1]
    set output (string replace -r '\.png$' '-clean.png' $input)
    set max_size 2000
    set extra_sharpen false

    for arg in $argv[2..]
        switch $arg
            case "*.png"
                set output $arg
            case "--sharpen"
                set extra_sharpen true
        end
    end

    set size_idx (contains -i -- "--size" $argv)
    if test -n "$size_idx"
        set max_size $argv[(math $size_idx + 1)]
    end

    if test "$extra_sharpen" = true
        convert "$input" -resize {$max_size}x{$max_size}\> -unsharp 0x1.5+1+0.05 -strip "$output"
    else
        convert "$input" -resize {$max_size}x{$max_size}\> -unsharp 0x1 -strip "$output"
    end
    echo "Enhanced: $output"
end
