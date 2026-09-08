# ADS Color — which token role, and when

> **Source:** designsystem.aidn.no → Foundations (Color principles, Surfaces, Text, Semantic, Borders, Graphic, Effect). **Snapshot:** site version 8.1.0, captured 2026-06-19.
>
> **Token VALUES come from the MCP** (`get_design_tokens(category:"colors")`) — do not transcribe hex here. The token *name* already encodes its role (see taxonomy). This page is the non-derivable part: the **usage rules** for picking the right role.

## Naming taxonomy — read the name to know the role
A token name is built from up to five parts:

| Part | Values | Meaning |
|---|---|---|
| **Context** | `surface`, `container`, `background`, `text`, `border`, `graphic`, `interactive` | What it's for. `text-*` → text + icons only. `graphic-*` → data-viz only. |
| **Emphasis** | `subtle`, `ghost`, `brand`, `strong`, `destructive`, `neutral` | Emphasize / de-emphasize. |
| **Sentiment** | `neutral`, `informative`, `positive`, `negative`, `attentive`, `warning`, `critical` | Meaning / status. |
| **On** | `on` | Color for content placed **on top of** a paired parent surface (e.g. `text-on-positive` on a positive surface). |
| **State** | `interactive`, `hover`, `pressed`, `disabled`, `visited` | Interactive element states. |

## Surfaces — backgrounds & containers
- **`background-default` is THE page background** for the whole interface — surfaces sit *on top* of it. Never use a container color as the page background.
- **`surface-container` (white)** is the default card/container. Emphasis ladder for fills: `surface-muted` < `surface-subtle` < `surface-neutral` etc. (subtle→accent get stronger).
- **Interactive surfaces** = `surface-interactive-*` (emphasis: `subtle`/`ghost`/`brand`/`strong`/`destructive`/`neutral`/`container`) each with `-hover`/`-pressed`/`-disabled`. Pick the **state token**, not just the base, when showing states. `ghost` = transparent resting → use for resting interactive elements; `subtle` = the selected/active fill (see interactivity matrix below).
- **Semantic surfaces** come in `-muted` / `-subtle` / `-accent` per sentiment, plus strong/subtle interactive `*-on-{sentiment}` sets for content sitting on a semantic surface.

## Text
- **`text-default`** — default, high contrast, good readability on all screens.
- **`text-subtle`** (80%) — hierarchy / longer passages, less strain.
- **`text-muted`** (64%) — less-important text, input placeholders, secondary info.
- **`text-disabled`** (40%) — disabled on light surfaces.
- **On dark:** `text-on-inverted` (+ `-subtle` / `-muted` / `-disabled`) for inverted surfaces.
- **Semantic text — two distinct jobs:**
  - `text-critical` / `text-informative` / `text-positive` → emphasise a status **without** using a supportive (colored) background.
  - `text-on-{neutral|positive|attentive|informative|negative|critical|warning}` → used **in combination with** that sentiment's surface/background.
- **Interactive text:** `text-interactive-default` (+hover/pressed/visited) for interactive text; **`text-interactive-accent` for links**; `text-interactive-subtle` for subtle interactive text; `text-interactive-on-inverted` on dark; `text-interactive-destructive` for destructive buttons with outline.

## Interactivity — resting vs selected (surfaces)
| State | Resting | Selected |
|---|---|---|
| Enabled | `surface-interactive-ghost` | `surface-interactive-subtle` |
| Hover | `…-ghost-hover` | `…-subtle-hover` |
| Pressed | `…-ghost-pressed` | `…-subtle-pressed` |
| Disabled | `…-ghost-disabled` | `…-subtle-disabled` |

## Borders
- **`border-default`** (default) < **`border-emphasis`** (emphasised) < **`border-strong`** (highest emphasis). Inverted trio: `border-on-inverted{,-emphasis,-strong}`.
- **Interactive borders:** `border-interactive-focus` (focus ring — the keyboard-focus outline), `border-interactive-focus-accent` (secondary focus for contrast), `border-interactive-subtle`(+hover/pressed), `border-interactive-default`(+hover/pressed), `border-interactive-destructive`, `border-interactive-disabled`.
- **Semantic borders** per sentiment (`border-positive`, `border-attentive`, …) plus `border-interactive-on-{sentiment}-subtle` state sets.

## Graphic — DATA-VIZ ONLY
- `graphic-{violet,blue,green,yellow,red,rose,gray,clementine,neutral}-{muted,subtle,accent,default,emphasis,strong}`. **For graphics and data visualisation only** — do NOT use these for UI surfaces, text, or borders (those have their own roles above). The violet family doubles as the brand ramp.

## Effect
- `effect-shadow-default` (the shadow tint, `#382441`) — drives the purple-tinted elevation shadows.
- `effect-ambience-{calm,calm-alt,calm-positive,energized,energized-alt,energized-attentive}` — the **Blur** ambience colors. Calming vs energized; never mix the two categories. See `assets.md` → Blur.

## Pairing recipe (a worked example — improper mappings break accessibility)
- Page background → `background-default` · Card → `surface-container` · Card header / primary text → `text-default` · Interactive border (filter chip) → `border-interactive-subtle` · Interactive text → `text-interactive-default` · Button fill → `surface-interactive-subtle`.

## Sentiments — meaning (for Message, Tag, semantic surfaces/text/borders)
| Sentiment | Use for |
|---|---|
| `neutral` | Default / general information |
| `informative` | New information, not urgent |
| `positive` | Improvements / successes |
| `negative` | Decline / problems |
| `attentive` | Careful attention / monitoring |
| `warning` | Potential risks, not urgent |
| `critical` | Urgent, demands immediate action |

## Accessibility (applies throughout)
Always sufficient text/background contrast; pair semantic color with **text + icon** (not color alone — not everyone perceives color the same). Reduced-opacity/muted roles are for hierarchy, used sparingly; be extra careful below 16px.
