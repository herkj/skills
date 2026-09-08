---
name: ads
description: Use the Aidn Design System (ADS) across Paper and Figma. Use when creating Aidn or ADS UI mockups, Paper designs, Figma files, design explorations, component instances, screen recreations, recoloring, or any interface that should follow Aidn tokens, typography, layout, brand assets, or component fidelity. Routes between the Paper replica workflow, the Figma exact-component workflow, and shared ADS foundation references.
---

# ADS

Use the Aidn Design System in design tools. The skill has one shared ADS foundation layer and two tool bridges:

- **Figma:** exact component instances from the published ADS and Bandaid libraries.
- **Paper:** fast high-fidelity replicas built with inline CSS, sourced from live ADS data.

The rule: **fetch canonical machine-readable data at runtime whenever a tool exposes it.** Bundled references are for non-machine-readable usage guidance, Figma library keys, and fallback values only.

## First-run setup

After installation, read and follow [`references/setup.md`](references/setup.md). Reuse connectors,
plugins, accounts, and permissions already approved in Claude, Cowork, or Codex. Do not create a
connection, edit client configuration, install software or fonts, or start OAuth without the
user's permission. If the user declines new access, continue in the documented limited mode and
state what could not be verified or edited.

## Route the Task

Use these signals to choose a bridge:

| Signal | Route |
|---|---|
| User shares a `figma.com` URL | Figma bridge |
| User says "in Figma", "push to Figma", "update the Figma file" | Figma bridge |
| Figma MCP/tools are active and the output target is a file/canvas | Figma bridge |
| User says "Paper", "paper.design", "mockup", "design exploration" | Paper bridge |
| Paper MCP/tools are available and no Figma target is named | Paper bridge |

If both tools are available and the user has not named a target, ask one concise question before doing work.

For any full page or screen, read `references/layout-patterns.md` first. For color role decisions, read `references/color.md`. For logo, pictograms, icons, or Blur, read `references/assets.md`. For Figma component/style keys and property strings, read `references/figma-library.md`.

## Shared ADS Sources

Use the `design-system` MCP as the source of truth for machine-readable ADS data:

- `list_components` - discover components by name/category.
- `get_design_tokens` - call every run for `colors`, `spacing`, `radius`, and `breakpoint`; parse the returned markdown. Do not rely on bundled hex values unless the MCP is unavailable.
- `get_component_api` and `get_component_examples` - use before recreating any ADS component.
- `get_guidelines` - developer/build guidelines only; it is not a replacement for layout, pattern, or content usage guidance.

The bundled `references/` snapshots cover guidance the MCP does not provide. They are version-stamped and should be updated as new design-system docs batches arrive. Do not bundle component API snapshots; components belong to the MCP or Figma libraries.

Capabilities for full fidelity:

- An authenticated Aidn Design System MCP connection for live tokens and component metadata.
- Paper Desktop running with a file open when using the Paper bridge.
- Figma MCP/tools connected to the target file when using the Figma bridge.

Match connectors by capability, not by a hardcoded local tool or plugin name. When live Design
System data is unavailable, use the bundled version-stamped guidance only as a disclosed fallback;
never present snapshot values as current.

## Figma Bridge

Use Figma when the user needs real published ADS/Bandaid component instances or text styles. Read `references/figma-library.md` before writing any Figma script that imports components, applies text styles, or sets component properties.

Fidelity order:

1. **ADS - Components** - published ADS component instances.
2. **Bandaid** - only pages whose title starts with the approved check mark in the library reference.
3. **Custom** - build from scratch only after the library route is exhausted.

Rules:

- Import components with `figma.importComponentByKeyAsync()` before creating instances.
- Import text styles with `figma.importStyleByKeyAsync()`, load the style font, then apply `textStyleId`.
- Define component and style keys as named constants; do not hardcode raw keys inline throughout a script.
- Set component properties after parenting the instance to the canvas.
- Use the exact property key strings from `references/figma-library.md`; many include emoji and ID suffixes.
- Use ADS text styles for text that maps to ADS. Do not manually set `fontName`/`fontSize` where a style exists.
- Use the 4px grid and ADS spacing scale: 4, 8, 12, 16, 20, 24, 32, 40, 48px.
- Use light theme for Aidn product/clinical surfaces unless the user explicitly asks for another mode.
- Default product-surface language is Norwegian bokmal.

When a component key or property name is missing, inspect the subscribed library or created instance. Do not invent a key or generic property name.

## Paper Bridge

Use Paper for fast mockups and design explorations. Paper cannot import React components or Figma library instances, so ADS components must be hand-built as replicas in inline CSS.

Paper workflow:

1. Identify the canonical layout first. For any page/screen, read `references/layout-patterns.md` and choose Overview, Focus, List detail, Supporting left, Supporting right, or Dashboard.
2. If recreating a real screen, find the source code first and build from code, not a screenshot. Search for distinctive UI strings and decode ADS Tailwind classes.
3. Get Paper context with `get_basic_info`, `get_selection`, and `get_font_family_info(["Inter","Nocturno Display L Variable","Georgia"])`.
4. Fetch live ADS tokens with `get_design_tokens` for colors, spacing, radius, and breakpoints.
5. Use `get_component_examples` and `get_component_api` for every ADS component being replicated.
6. Create the artboard, usually desktop `1440x900`; use fit-content height when content clips.
7. Write one visual group per `write_html` call with inline CSS and token values.
8. Take screenshots after each section; fix density, spacing, contrast, alignment, and component fidelity in place.
9. Finish with `finish_working_on_nodes`; never expose node IDs to the user.

Paper replica rules:

- Buttons and chips use pill radius; cards use `lg`/`xl` radius and ADS elevation.
- Use `x-paper-clone` to reuse repeated replicas once built.
- Component fidelity comes from live examples/API or source code, not screenshots.
- Use real ADS SVG icon paths from `packages/core/src/assets/system-icons/library/<Name>Icon.tsx`; do not hand-draw approximations.
- Paper artboards are fixed width. Choose the breakpoint for the artboard and map `w-N/12` to flex proportions.

### Paper Typography

ADS uses **Inter** for UI text and **Nocturno Display Std** for Display styles. In Paper, the installed Nocturno family name is `Nocturno Display L Variable` after converting/installing the repo font. If it is not installed or Paper has not restarted, use Georgia as the Display fallback; never render Display styles in Inter.

Use ADS weight remaps:

| Group | Weight |
|---|---:|
| BodyText | 399 |
| Heading | 599 |
| Display | 449 |
| Interactive | 499 |

Verified type scale:

| Group | Sizes |
|---|---|
| Display, Nocturno/serif, 449 | `xs 28`, `sm 36`, `md 45` |
| Heading, Inter, 599 | `xxs 12`, `xs 14`, `sm 16`, `md 18`, `lg 23`, `xl 28` |
| BodyText, Inter, 399 | `xs 12`, `sm 14`, `md 16`, `lg 20` |
| Interactive, Inter, 499 | Fetch exact values from examples; use for labels/buttons |

ADS has no marketing hero scale. For landing pages, any larger Display use is an intentional extension, not a token.

### Paper Fallback Tokens

Prefer live `get_design_tokens`. Use these only as a sanity-check fallback:

| Role | Token | Value |
|---|---|---|
| Page background | `background-default` | `#FFF4F1` |
| Card/surface | `surface-container` | `#FFFFFF` |
| Subtle fill | `surface-neutral-muted` | `#F8F7F9` |
| Brand | `surface-interactive-brand` | `#603D6D` |
| Strong/inverted surface | `surface-interactive-strong` / `surface-inverted` | `#382441` / `#1c1221` |
| Accent | `text-interactive-accent` | `#9256A1` |
| Text default | `text-default` | `#1c1221` |
| Text muted | `text-muted` | `rgba(28,18,33,0.64)` |
| Text on dark | `text-on-inverted` / muted | `#FFFFFF` / `rgba(255,255,255,0.64)` |
| Border | `border-default` / `-emphasis` / `-strong` | `rgba(146,86,161,.16)` / `.25` / `#9256A1` |
| Positive | `surface-positive` / `text-on-positive` | `#D0F3E0` / `#26352D` |

Radius fallback: `xs 2`, `sm 4`, `md 8`, `lg 12`, `xl 16`, `pill 9999`.

Spacing fallback: `100=8`, `150=12`, `200=16`, `250=20`, `300=24`, `400=32`, `500=40`, `600=48`, `800=64`, `1200=96`.

Elevation fallback:

- `sm`: `0 2px 4px 0 rgba(56,36,65,.1), 0 1px 1px 0 rgba(56,36,65,.03)`
- `md`: `0 6px 16px 0 rgba(56,36,65,.1), 0 2px 4px 0 rgba(56,36,65,.06)`
- `lg`: `0 20px 58px 0 rgba(56,36,65,.16), 0 4px 12px 0 rgba(56,36,65,.06)`

## Code and Density Checks

In source code, Tailwind classes often map directly to ADS tokens. Decode them rather than approximating:

- `bg-surface-interactive-strong` -> matching surface token.
- `text-on-inverted` -> paired on-inverted text token.
- `rounded-md` -> radius `md`.
- `size-ds-400`, `p-ds-150`, `gap-ds-50` -> ADS spacing keys.
- `shadow-sm` -> ADS elevation `sm`.

When recreating an existing screen, compare density more than color: card padding, inter-card gaps, line-height, icon treatment, and shadow weight are usually what reveal an inaccurate mockup.
