# Editing Mari's photos — cheat sheet

Mari can't touch code, so we gave every photo on her site a **letter**. She sends
you the new photo + the letter; you run one command; it's live in ~1 minute.

## The two links
- **Live site:** https://codedbycb-afk.github.io/nailedbymariii-site/
- **Photo Map (send this to Mari):** https://codedbycb-afk.github.io/nailedbymariii-site/map.html
  Every photo, stamped with its letter. Screenshot it or send her the link.

## The slots
| Letter | Where it is |
|---|---|
| A | Hero photo (big one at the top) |
| B | About band — "Licensed & Cleveland-based" |
| C | Service card — Acrylic Full Set |
| D | Service card — Gel-X Full Set |
| E | Service card — Builder Gel |
| F | Service card — Manicure |
| H | Service card — Acrylic Fill |
| J | Service card — Gel-X Fill |
| K | Service card — Pedicure |
| G1–G11 | "The Work" gallery, left→right, top→bottom |

## When Mari sends a new photo
1. Save the photo she sent (Downloads is fine). iPhone HEIC is OK — it converts automatically.
2. Run one command from this folder:
   ```
   cd ~/Documents/JARVIS/Twenty47/nailedbymariii-site
   ./swap.sh G5 ~/Downloads/hernewpic.jpg
   ```
   (swap `G5` for whichever slot, and the path for wherever you saved the photo.)
3. Wait ~1 min, hard-refresh the site (Cmd+Shift+R). Done.

The script resizes + compresses for the web, overwrites just that one slot,
commits, and pushes. Slots are independent — changing G5 never touches anything else.

## The text to send Mari (copy-paste)
> Hey! Made it super easy to swap photos on your site. Here's a "photo map" —
> every picture has a letter: [map link]. Whenever you want to change one, just
> text me the new pic and the letter (like "swap G5" or "new hero pic, that's A").
> I'll have it live in a minute. 💅

## Notes
- Original IG photos are still in `assets/posts/` (untouched backup).
- `index.html.bak` is the pre-slot version of the page, just in case.
- Want Mari to do it herself with no texting? See "Self-serve upgrade" — a
  PIN-protected upload page. Ask CB's Claude to build it.
