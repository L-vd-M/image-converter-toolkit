function qr-gen --description "Generate QR code from text/URL → SVG or PNG"
    if test (count $argv) -lt 1
        echo "Usage: qr-gen TEXT [output.svg|output.png] [--transparent] [--bg COLOR] [--fg COLOR] [--size N] [--level L|M|Q|H]"
        return 1
    end

    set text $argv[1]
    set output "qr.svg"
    set transparent false
    set bg "white"
    set fg "black"
    set size 10
    set level "M"

    set i 2
    while test $i -le (count $argv)
        set arg $argv[$i]
        switch $arg
            case "*.svg" "*.png"
                set output $arg
            case "--transparent"
                set transparent true
            case "--bg"
                set i (math $i + 1)
                set bg $argv[$i]
            case "--fg"
                set i (math $i + 1)
                set fg $argv[$i]
            case "--size"
                set i (math $i + 1)
                set size $argv[$i]
            case "--level"
                set i (math $i + 1)
                set level (string upper $argv[$i])
        end
        set i (math $i + 1)
    end

    set ext (string lower (path extension $output))

    if test "$ext" = ".svg"
        qrencode -t SVG -s $size -l $level --foreground=(string replace '#' '' $fg) -o "$output" "$text"
        echo "QR code: $output"
    else if test "$transparent" = "true"
        segno --dark="$fg" --light=transparent -s $size -e (string lower $level) -o "$output" "$text"
        echo "QR code (transparent): $output"
    else if test "$bg" != "white" -o "$fg" != "black"
        segno --dark="$fg" --light="$bg" -s $size -e (string lower $level) -o "$output" "$text"
        echo "QR code (colored): $output"
    else
        qrencode -t PNG32 -s $size -l $level -o "$output" "$text"
        echo "QR code: $output"
    end
end
