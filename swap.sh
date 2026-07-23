#!/bin/bash
# swap.sh — replace one lettered photo slot on Mari's site and push it live.
#
#   ./swap.sh <SLOT> <path-to-new-photo>
#
# Examples:
#   ./swap.sh A  ~/Downloads/new-hero.jpg
#   ./swap.sh G5 ~/Desktop/latest-set.HEIC
#   ./swap.sh F  "/Users/you/Downloads/mani pedi.png"
#
# Slots (see map.html for the picture version):
#   A  = Hero photo (big portrait at the top)
#   B  = About / "Licensed & Cleveland-based" band photo
#   C  = Service card: Acrylic Full Set
#   D  = Service card: Gel-X Full Set
#   E  = Service card: Builder Gel
#   F  = Service card: Manicure
#   H  = Service card: Acrylic Fill
#   J  = Service card: Gel-X Fill
#   K  = Service card: Pedicure
#   G1..G11 = The Work gallery, left-to-right, top-to-bottom
#
# Handles iPhone HEIC, resizes + compresses, commits, and pushes to GitHub Pages.
# No dependencies — uses macOS built-in `sips`.

set -e
cd "$(dirname "$0")"

SLOT="$1"
SRC="$2"

VALID="A B C D E F H J K G1 G2 G3 G4 G5 G6 G7 G8 G9 G10 G11"

usage () {
  echo ""
  echo "Usage:  ./swap.sh <SLOT> <path-to-photo>"
  echo "Slots:  $VALID"
  echo "Example: ./swap.sh G5 ~/Downloads/newpic.jpg"
  echo ""
  exit 1
}

[ -z "$SLOT" ] && { echo "❌ No slot given."; usage; }
[ -z "$SRC" ]  && { echo "❌ No photo given."; usage; }

# normalize slot to uppercase
SLOT="$(echo "$SLOT" | tr '[:lower:]' '[:upper:]')"

# validate slot
case " $VALID " in
  *" $SLOT "*) ;;
  *) echo "❌ '$SLOT' is not a real slot."; usage;;
esac

[ ! -f "$SRC" ] && { echo "❌ Can't find that photo: $SRC"; exit 1; }

OUT="assets/site/${SLOT}.jpg"

echo "→ Slot $SLOT  ←  $SRC"

# sips reads HEIC/PNG/JPG and writes an optimized jpeg. -Z 1400 = max side 1400px.
sips -s format jpeg -s formatOptions 82 -Z 1400 "$SRC" --out "$OUT" >/dev/null 2>&1 \
  || { echo "❌ Couldn't process that image. Is it a real photo file?"; exit 1; }

SIZE=$(du -h "$OUT" | cut -f1)
echo "✓ Saved $OUT ($SIZE)"

git add "$OUT"
git commit -q -m "Swap photo slot $SLOT" || { echo "ℹ️  Nothing changed (same image?)."; exit 0; }
git push -q origin HEAD

echo ""
echo "✅ Slot $SLOT is live. Give GitHub Pages ~1 minute, then refresh the site."
echo "   https://codedbycb-afk.github.io/nailedbymariii-site/  (hard-refresh: Cmd+Shift+R)"
