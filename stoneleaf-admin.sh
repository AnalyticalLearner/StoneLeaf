!/bin/bash

# === Configuration ===
STONELEAF_ROOT="/var/www/html/stoneleaf/"  # Change as needed
MAP_OUTPUT_DIR="${STONELEAF_ROOT}/00.reference"
BACKUP_DIR="${STONELEAF_ROOT}/_backups"

# Ensure helper directories exist
mkdir -p "$MAP_OUTPUT_DIR" "$BACKUP_DIR"

# === Helper Functions ===

generate_map() {
    echo "Generating directory map..."
    mapfile="${MAP_OUTPUT_DIR}/map-$(date +%Y%m%d-%H%M%S).txt"
    tree "$STONELEAF_ROOT" > "$mapfile"
    echo "Map saved to: $mapfile"
}

view_map(){
   less $MAP_OUTPUT_DIR/map*.txt
}

search_keywords() {
    read -rp "Enter keyword to search for: " keyword
    echo

    echo "Searching in: $STONELEAF_ROOT"
    echo

    # -- Filename matches --
    echo "🔎 Filename matches:"
    mapfile -t name_matches < <(find "$STONELEAF_ROOT" -type f -iname "*$keyword*" ! -path "*/_*/*")

    if [ ${#name_matches[@]} -eq 0 ]; then
        echo "  (None found)"
    else
        for i in "${!name_matches[@]}"; do
            echo "  [N$((i + 1))] ${name_matches[$i]#$STONELEAF_ROOT/}"
            if (( (i + 1) % 20 == 0 )); then
                read -rp "Press Enter to continue..."
            fi
        done
    fi

    echo
    echo "📝 Content matches:"
    mapfile -t content_matches < <(grep -ril --exclude-dir="_*" "$keyword" "$STONELEAF_ROOT")

    if [ ${#content_matches[@]} -eq 0 ]; then
        echo "  (None found)"
    else
        for i in "${!content_matches[@]}"; do
            echo "  [C$((i + 1))] ${content_matches[$i]#$STONELEAF_ROOT/}"
            if (( (i + 1) % 20 == 0 )); then
                read -rp "Press Enter to continue..."
            fi
        done
    fi

    echo
    read -rp "Enter item ID to view (e.g., N2 or C3), or press Enter to skip: " choice

    if [[ "$choice" =~ ^N([0-9]+)$ ]]; then
        idx="${BASH_REMATCH[1]}"
        if [ "$idx" -le "${#name_matches[@]}" ]; then
            less "${name_matches[$((idx - 1))]}"
        fi
    elif [[ "$choice" =~ ^C([0-9]+)$ ]]; then
        idx="${BASH_REMATCH[1]}"
        if [ "$idx" -le "${#content_matches[@]}" ]; then
            less "${content_matches[$((idx - 1))]}"
        fi
    else
        echo "No valid selection made."
    fi
}


backup_library() {
    filename="$BACKUP_DIR/stoneleaf-full-$(date +%Y%m%d-%H%M%S).zip"
    echo "Creating full library backup at $filename..."
    zip -r "$filename" "$STONELEAF_ROOT" -x "*_backups*" "*_maps*"
    echo "Backup complete."
}

backup_directory() {
    read -rp "Enter relative path to directory (from $STONELEAF_ROOT): " dir
    fullpath="$STONELEAF_ROOT/$dir"
    if [ -d "$fullpath" ]; then
        filename="$BACKUP_DIR/${dir//\//_}-$(date +%Y%m%d-%H%M%S).zip"
        zip -r "$filename" "$fullpath"
        echo "Backup saved to $filename"
    else
        echo "Directory not found."
    fi
}

check_size() {
    command -v ncdu > /dev/null || { echo "ncdu not found. Install it first."; return; }
    ncdu "$STONELEAF_ROOT"
}

# === Main Menu ===

while true; do
    clear
    echo "╔═════════════════════════════════════════════╗"
    echo "║         🗂️  StoneLeaf Admin Menu            ║"
    echo "╠═════════════════════════════════════════════╣"
    echo "║  1. 📁 Generate Directory Map               ║"
    echo "║  2. 🔍 Search Library by Keyword            ║"
    echo "║  3. 🧰 Backup Entire Library                ║"
    echo "║  4. 📦 Backup Specific Directory            ║"
    echo "║  5. 📊 Check Library Size (ncdu)            ║"
    echo "║  6. 🗺️  View File Map                       ║"
    echo "║                                             ║"
    echo "║  99. ❌ Exit                                ║"
    echo "╚═════════════════════════════════════════════╝"
    echo

    read -rp "Enter your choice [1-99]: " choice
    echo

    case "$choice" in
        1) generate_map ;;
        2) search_keywords ;;
        3) backup_library ;;
        4) backup_directory ;;
        5) check_size ;;
        6) view_map ;;
        99) echo "Goodbye."; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac

    echo
    read -rp "Press Enter to return to menu..."
done
