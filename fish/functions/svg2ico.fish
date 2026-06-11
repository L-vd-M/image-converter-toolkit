function svg2ico --description "Convert SVG to multi-resolution ICO via svg-icon-gen"
    if test (count $argv) -lt 1
        echo "Usage: svg2ico input.svg [output.ico]"
        return 1
    end

    set input $argv[1]
    set output (string replace -r '\.svg$' '.ico' $input)
    if test (count $argv) -ge 2
        set output $argv[2]
    end

    set tmpdir (mktemp -d)
    svg-icon-gen "$input" --out-dir "$tmpdir"
    set ico_file (find "$tmpdir" -name "*.ico" | head -1)
    if test -z "$ico_file"
        echo "svg2ico: svg-icon-gen produced no ICO file" >&2
        rm -rf "$tmpdir"
        return 1
    end
    mv "$ico_file" "$output"
    rm -rf "$tmpdir"
    echo "Created: $output"
end
