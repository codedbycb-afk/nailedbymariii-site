# Wiring the GHL booking widget into the custom page

The page (`index.html`) is fully custom and yours to extend. The **only** GHL-dependent part is the booking modal. Here's how to connect it once the calendar exists.

## 1. Build the calendar (automated)
Once `GHL_PIT_MARI` is in `ghl-export/.env` and prices/hours are in `../ghl/services.json`, run:
```
node ../ghl/build.mjs
```
That creates the "Nailed by Mari — Booking" calendar + service products and writes the calendar id to `../ghl/created-ids.json`.

## 2. Require the deposit on the calendar (GHL UI)
In the calendar's settings → **Payment** → turn ON "Accept payments" → set the deposit amount → connect **Stripe** (CB-CHECKLIST #3). Now the GHL widget collects the deposit before confirming.

## 3. Get the embed + drop it in
GHL → Calendar → **Share/Embed** → copy the booking link. It looks like:
`https://api.leadconnectorhq.com/widget/booking/XXXXXXXXXXXX`

Two ways to use it:

**A. Fastest —** set one line in `index.html`:
```js
const GHL_WIDGET_BASE = "https://api.leadconnectorhq.com/widget/booking/XXXXXXXXXXXX";
```
The modal then loads the live widget, and each service card passes `?service=Name` so the right appointment type is preselected. Done.

**B. Full control —** replace the `#ghlSlot` placeholder markup with GHL's own iframe snippet + `<script src="https://link.msgsndr.com/js/form_embed.js"></script>` (auto-resizes). Use this if you want GHL's native height behavior.

## 4. Confirmations, reminders, ManyChat, iPhone sync
These are GHL-side and independent of the page — see `../ghl/BUILD-SPEC.md` and `../CB-CHECKLIST.md`:
- Confirmation + reminder **workflows** (SMS + email) → GHL Workflow builder.
- **ManyChat** IG-DM "book" flow → sends this page's URL → webhook creates the GHL contact.
- **iPhone** calendar → connect GHL ⇄ Google, add that Google account on her iPhone.

## Deploy
The `booking/` folder is self-contained (assets included). Host it like Nuclear's site (GitHub Pages / any static host). Put the final URL in her IG bio + ManyChat. To add features later, just edit `index.html` — the booking widget keeps working.
