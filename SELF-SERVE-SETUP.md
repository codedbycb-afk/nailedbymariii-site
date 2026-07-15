# Self-serve photo editor (v2) — one-time setup

Mari opens a PIN-protected page, taps a photo, picks a new one from her phone,
and it goes live herself — no texting CB. This runs on the existing
`codedbycb-platform` Vercel app (endpoint `/api/booking/mari-photo`).

**One-time setup: ~5 minutes.** After that it just works.

## What's already built & deployed
- `edit.html` (this repo) — the PIN-gated editor page → live at
  `https://codedbycb-afk.github.io/nailedbymariii-site/edit.html`
- `app/api/booking/mari-photo/route.ts` (codedbycb-platform) — the upload
  endpoint that commits the photo into this repo via the GitHub API.

## Step 1 — Make a GitHub token (fine-grained, 1 repo only)
1. GitHub → **Settings → Developer settings → Personal access tokens → Fine-grained tokens → Generate new token**.
2. Name: `mari-photo-editor`. Expiration: 1 year (or No expiration).
3. **Resource owner:** `codedbycb-afk`.
4. **Repository access → Only select repositories →** `nailedbymariii-site`.
5. **Permissions → Repository permissions → Contents → Read and write**.
   (Leave everything else as No access.)
6. Generate, copy the token (starts with `github_pat_...`).

## Step 2 — Add two env vars in Vercel
Vercel → project **codedbycb-platform** → **Settings → Environment Variables**
(Production). Add:
- `GH_TOKEN_MARI` = the token from Step 1
- `MARI_EDIT_PIN` = a PIN you pick for Mari (e.g. `2468`)

## Step 3 — Redeploy
Vercel → **Deployments → ⋯ on the latest → Redeploy** (so it picks up the env vars).
Done.

## Give it to Mari
Send her:
- The link: `https://codedbycb-afk.github.io/nailedbymariii-site/edit.html`
- Her PIN.
- (Optional) tell her to "Add to Home Screen" so it's a tap away.

That's the whole thing. She unlocks with the PIN, taps **Change photo** on any
slot, picks from her camera roll — the page resizes it and it's live in ~1 min.

## Security notes
- The token is scoped to **one repo, contents only** — worst case, it can only
  edit this site's files, nothing else.
- The PIN is checked **server-side**; it's never in the page source.
- Change the PIN anytime by editing `MARI_EDIT_PIN` in Vercel + redeploy.
- CB's `swap.sh` (v1) still works too — both paths write the same slot files.
