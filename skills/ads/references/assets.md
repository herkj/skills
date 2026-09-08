# ADS Assets — Logo, Pictograms, Icons, Blur

> **Source:** designsystem.aidn.no → Foundations → Assets. **Snapshot:** site version 8.1.0, captured 2026-06-19.

## Logo
- The Aidn logo (wordmark `aidn`) is inspired by broad-nib calligraphy — elegance + sturdiness. Code: `import { AidnLogo } from '@aidnas/design-system'` → `<AidnLogo />`.
- **Logomark** — simplified `a` symbol for app icons / favicons. Retains brand language at small sizes.
- **Size (fixed):** Logo = **44px width**. Logomark = **24×24px**. Do not scale arbitrarily.
- **Color:** use predominantly on `surface/background`; may sit on other `surface` colors. ❌ Don't place Logo/Logomark on non-surface colors. ❌ Don't change the logo color.
- **Legibility / exclusion zone:** always apply the exclusion zone to isolate the logo from competing elements (busy imagery, low-contrast areas, text). Built into the components.
- **Misuse:** keep appearance consistent — don't misinterpret, modify, recolor, or add to it.
- **Accessibility:** screen readers read alt text — use it to communicate the Aidn name.

**Paper:** render the wordmark as a small serif-ish `aidn` lockup or the `a` logomark in a dark rounded square (`surface-inverted` #1c1221, radius ~md, white glyph). Keep 44px / 24px. Never recolor onto brand/semantic fills.

## Pictograms
- Non-interactive illustrative marks used **exclusively inside Empty State components**. They give subtle contextual support — why a section is empty and what to do next.
- **Paper:** only draw a pictogram inside an `EmptyState`; never as a standalone decorative icon elsewhere.

## System Icons
- The full system icon set ships in the latest release. **Icon patterns:** some icons have specific, fixed use cases to keep functionality consistent across the product — don't repurpose a known icon for a different meaning (one icon = one meaning).
- **Paper — use the real SVG, don't hand-draw:** if the Aidn design-system source is already
  accessible in the current workspace, find the named icon under
  `packages/core/src/assets/system-icons/library/` and use its exact SVG for the required size. If
  the source is not available, use an official icon exposed by the Design System or design tool.
  Do not request repository access solely for an icon unless the user approves it.

## Blur (effect)
- A soft, rounded **background** element on key pages to create a calm or energised atmosphere — enhances emotional tone without distracting from content. Built from **effect color tokens** (`effect-ambience-calm*`, `effect-ambience-energized*`).
- **Variants:** `calming` (default) · `energized` (time-sensitive content — notifications, errors, alerts).
- **Do:** use on visually light pages with minimal content — homepage, marketing screens, login, empty states.
- **Don't:** ❌ content-heavy pages, forms, or dense/functional information views (interferes with readability). ❌ on any surface other than the background. ❌ change default blur colors. ❌ combine an energized color with a calming color (stay within one category, max two colors). ❌ change layer-blur settings / leave visible outlines.
- **Form:** organic, rounded, irregular shapes; combining two effect colors merges the shapes into one Blur.
- **Placement:** allowed on mobile/touch + desktop/cursor; sits centered behind background content.
- **Focus / Movement:** coded component can optionally focus the Blur on one element (e.g. a CTA) and allow subtle in-viewport movement; both off by default.
- **Accessibility:** avoid animated Blurs on content-heavy pages and don't speed up the animation — content must not be designed in a way known to cause seizures/physical reactions.

**Paper:** fake Blur with large `border-radius:9999px` ellipses in `effect-ambience-*` colors at low opacity + a heavy CSS `filter: blur(...)`, placed absolutely behind content on a light page only. Two blobs max, same ambience category.
