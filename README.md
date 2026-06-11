# image-converter-toolkit

CLI toolkit for PNG/SVG/ICO/QR conversion. Ansible role installs all tools; Fish functions provide ergonomic wrappers.

## What it installs

| Tool | Source | Purpose |
|------|--------|---------|
| imagemagick | apt | PNG resize, threshold, ICO creation |
| librsvg2-bin | apt | SVG → PNG via `rsvg-convert` |
| potrace | apt | B&W bitmap → SVG vector |
| libcairo2 | apt | Cairo rendering library |
| python3-pip | apt | pip installer |
| inkscape | apt | SVG → PNG multi-size export |
| pngquant | apt | Lossy PNG compression |
| optipng | apt | Lossless PNG optimization |
| nodejs + npm | apt | Node.js runtime for svgo |
| qrencode | apt | QR code generator (SVG/PNG) |
| vtracer | GitHub binary | Color/photo PNG → SVG tracing |
| oxipng | GitHub binary | Lossless PNG optimizer (Rust) |
| svg-icon-gen | pip | SVG → multi-resolution ICO/ICNS |
| segno | pip | QR code with transparent/color support |
| svgo | npm | SVG optimizer |

## Fish functions

### Conversion
- `png2svg input.png [output.svg] [--bw|--poster|--photo]` — trace PNG to SVG
- `bw-trace input.png [output.svg]` — B&W trace via potrace
- `svg2ico input.svg [output.ico]` — SVG → multi-resolution ICO
- `png2ico input.png [output.ico]` — PNG → multi-resolution ICO
- `img2favicon input.[png|svg] [basename]` — full favicon set (`.svg` + `.ico`)

### Enhancement
- `enhance-img input.png [output.png] [--size N] [--sharpen]` — upscale, sharpen, strip metadata
- `optimize-svg input.svg [output.svg]` — SVGO optimization, keeps viewBox
- `export-svg-sizes input.svg [basename] [sizes...]` — export to PNG at 16/32/48/64/128/256/512px
- `compress-png input.png [output.png] [--lossy]` — oxipng (lossless) or pngquant (lossy)

### QR codes
- `qr-gen TEXT [output.svg|png] [--transparent] [--bg COLOR] [--fg COLOR] [--size N] [--level L|M|Q|H]`

## Usage

### Standalone (run the role directly)
```bash
cd ~/repos/image-converter-toolkit
ansible-playbook playbook.yml --ask-become-pass
# Optional: install PixelToPath GUI
ansible-playbook playbook.yml -e enable_pixeltopath=true --ask-become-pass
```

### Via kubuntu-setup
```bash
ansible-playbook setup.yml --tags image-converter
# or answer "yes" at the prompt during full setup run
```

### Fish functions (after install)
```fish
# PNG → SVG → ICO pipeline
png2svg logo.png
optimize-svg logo.svg
svg2ico logo.min.svg

# Favicon set from PNG
img2favicon logo.png

# QR code
qr-gen "https://example.com" qr.svg
qr-gen "WIFI:S:MyNet;T:WPA;P:pass123;;" wifi.svg
qr-gen "https://example.com" qr.png --transparent
```

## Defaults

See `roles/image_converter/defaults/main.yml` to override `vtracer_version`, binary URLs, or `enable_pixeltopath`.
