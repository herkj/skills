# ADS Layout — the Layout component & the 6 canonical layouts

> **Source:** designsystem.aidn.no → Components → Layout (+ Overview, Focus, List detail, Supporting left, Supporting right, Dashboard). **Snapshot:** site version 8.1.0, captured 2026-06-19. Not in the MCP.
>
> This is the single most important file for getting page *structure* right. Pick a canonical layout first, then fill it — don't invent bespoke column arrangements ("Do not use for highly customised layouts: marketing pages, campaign banners, editorial designs").

---

## The Layout primitive
`import { Layout } from "@aidnas/design-system"` — a Flexbox tool for **single and dual-column** layouts with consistent scroll behaviour and page width. It lives *inside* an existing page shell (it does not own the side navigation):

```
<Page>
  <SideNavigation/>            ← primary nav, NOT part of Layout
  <Layout>
    <Layout.Top>…</Layout.Top> ← optional header band, spans all slots, can be sticky
    <Layout.Slot>…</Layout.Slot>  ← one column
    <Layout.Slot>…</Layout.Slot>  ← (optional) second column
  </Layout>
</Page>
```

**Anatomy:** ① `SideNavigation` (primary nav) · ② `Layout` (page content) · ③ `Layout.Top` (optional, sticky-able area above the columns).

### Props that drive every pattern
| Element | Prop | Effect |
|---|---|---|
| `Layout.Top` | `sticky` (bool) | Sticks at `top:0` in the nearest scrolling ancestor. |
| `Layout.Slot` | `open` (bool) | Whether the slot renders. On large screens an undefined `open` renders open; on small screens a slot hides if a sibling has `open=true`. Used to switch which single column is visible on mobile. |
| `Layout.Slot` | `persistent` (bool) | Slot keeps occupying its horizontal space even when closed (rows). Use to show/hide without shifting sibling widths on large viewports. |
| `Layout.Slot` | `scrollable` (bool) | Slot becomes its **own scroll container** (container-scroll). Only applies from `lg` up; below `lg` everything uses window-scroll. |

### Global rules (apply to all layouts)
- **12-column grid** (Figma) → **Flexbox** (code). Slot widths are Tailwind `w-N/12` classes.
- **Max content width = 1928px.** Beyond that the layout stays centred and the **side margins grow** — content never stretches past 1928px.
- **Scroll model:** by default **all columns use window-scroll**. To make an *aside* sticky with its own scroll, set `scrollable` on that slot. The **main column always uses window-scroll**.
- **Single-column layouts: NEVER set `scrollable`** on the lone `Layout.Slot` — it only works when there are multiple slots.
- **Breakpoints:** `sm 640 · md 768 · lg 1024 · xl 1280 · 2xl 1536`. Dual-column layouts collapse to one column **below `lg`** (except Dashboard, which steps at `md`). On small screens, split the columns across **separate pages** and use the `Header` Back button to navigate.

---

## Which layout? — decision guide

```
Need multiple cards/summaries at a glance? ────────────────► DASHBOARD
One focused task (form / single record)? ──────────────────► FOCUS
Dense table / filterable list / records (full width)? ─────► OVERVIEW
Two panels, browse a list + read a selected item? ─────────► LIST DETAIL
Main work + a narrower helper column…
        …helper on the LEFT (filters, nav, references)? ──► SUPPORTING LEFT
        …helper on the RIGHT (history, notes, tools)? ────► SUPPORTING RIGHT
```

| Layout | Columns (desktop) | Main use |
|---|---|---|
| Overview | 1 × full | Dense tables, filterable lists, multi-attribute records |
| Focus | 1 × centred (8–10/12) | Forms, reviewing a single record — removes distraction |
| List detail | 6 / 6 | Browse a collection + read the selected item side-by-side |
| Supporting left | aside 3–4 / main 8–9 | Filtering, related context/tools on the **left** |
| Supporting right | main 8 / aside 4 | History, notes, references on the **right** |
| Dashboard | up to 4, wrapping | Overview of multiple data sources / task summaries |

---

## 1. Overview — `1 column, full width`
Dense, structured info: tables, filterable lists, records with many attributes.
```
┌───────────────── Layout.Top (optional, sticky) ─────────────────┐
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│            Layout.Slot  className="w-full"  (window scroll)       │
│                                                                   │
└───────────────────────────────────────────────────────────────────┘
```
- **Code:** single `<Layout.Slot className="w-full">`. Page scroll = the main column.
- **Don't** set `scrollable` (single column).
- **Small screens:** tables get cramped — reorganise table content (e.g. collapse columns into Accordions) rather than forcing horizontal scroll.

## 2. Focus — `1 column, centred, narrows as it grows`
A single task needing uninterrupted attention (forms, single-record review). Centred to cut noise.
```
   width < lg            lg ≤ width < 2xl          2xl ≤ width
 ┌───────────┐          ┌───────────┐            ┌───────────┐
 │███████████│ 12/12    │ ░███████░ │ 10/12      │ ░░█████░░ │ 8/12
 └───────────┘          └───────────┘            └───────────┘
```
- **Code:** `Layout.Top` + single `Layout.Slot`, both `className="lg:w-10/12 xl:w-8/12"`… i.e. **12 cols < lg → 10 cols at lg → 8 cols at 2xl**, content centred. Window-scroll; never `scrollable`.

## 3. List detail — `6 / 6 equal columns`
Browse a collection (left) and interact with the selected item's detail (right), side-by-side.
```
┌───────────────── Layout.Top (optional, sticky) ─────────────────┐
├──────────────────────────────┬──────────────────────────────────┤
│  Layout.Slot  w-6/12          │  Layout.Slot  w-6/12  scrollable  │
│  MAIN — list  (window scroll) │  ASIDE — detail (container scroll)│
└──────────────────────────────┴──────────────────────────────────┘
       below lg ► one column at a time (use `open`); detail opens as its own page w/ Header Back
```
- **Code:** two `w-6/12` slots; first = main (window scroll), second = aside with `scrollable`. Use `open` to switch the single visible column < lg; `persistent`+`open` on large screens to keep a closed column's space.
- **Don't** show two columns on small screens (too compact). **Do** show an **Empty State** in the detail column when nothing is selected — and don't leave the aside empty (if it's usually empty, use **Focus** instead).

## 4. Supporting left — `aside 3–4 / main 8–9` (helper on the LEFT)
Narrow supporting column on the left (filters, references, tools); main task on the right. *Aside comes first in the markup.*
```
┌───────────────── Layout.Top (optional, sticky) ─────────────────┐
├──────────────┬───────────────────────────────────────────────────┤
│ ASIDE w-4/12 │  MAIN  w-8/12                                       │
│ (xl: 3/12)   │  (xl: 9/12)                                         │
│ scrollable   │  window scroll                                      │
└──────────────┴───────────────────────────────────────────────────┘
  < lg ► main only   │   lg ≤ w < xl ► aside 4 / main 8   │   xl+ ► aside 3 / main 9
```
- **Code:** aside `Layout.Slot scrollable className="w-4/12 xl:w-3/12"` **first**, then main `className="w-8/12 xl:w-9/12"`. Page scroll = main; aside scrolls in its own container.
- **Don't** show two columns on small viewports, and **don't leave the aside empty**. Below `lg`, split across pages (Header Back).

## 5. Supporting right — `main 8 / aside 4` (helper on the RIGHT)
Supporting column on the right (history, notes, references, tools); ideal for side-by-side reading/interaction. *Main comes first.*
```
┌───────────────── Layout.Top (optional, sticky) ─────────────────┐
├───────────────────────────────────────────────┬──────────────────┤
│ MAIN  w-8/12                                    │ ASIDE w-4/12     │
│ window scroll                                   │ scrollable       │
└───────────────────────────────────────────────┴──────────────────┘
  < lg ► main only   │   lg ≤ width ► main 8 / aside 4 (no further change at xl/2xl)
```
- **Code:** main `Layout.Slot className="w-8/12"` **first**, then aside `className="w-4/12" scrollable`. Page scroll = main; aside container-scroll.
- **Don't** use two columns on small viewports — use a **Content Switcher** to move between them. **Don't leave the aside empty** — prefer **Overview** or **Focus** instead.

## 6. Dashboard — `up to 4 wrapping columns`
Overview of multiple data sources / task summaries at a glance. The flexible one: slots **wrap onto a new row** when space runs out; mix full / half / smaller widths.
```
┌───────────────── Layout.Top (optional, sticky) ─────────────────┐
├───────────────────────────────────────────────────────────────────┤
│ Layout.Slot  w-full                                               │
├──────────────────────────────┬──────────────────────────────────┤
│ Layout.Slot  w-6/12          │ Layout.Slot  w-6/12               │
└──────────────────────────────┴──────────────────────────────────┘
     (more slots wrap to new rows as needed)
```
- **Steps differently — at `md`, not `lg`:** `< md` 1 col · `md–lg` 2 cols · `lg–xl` 3 cols · `xl+` 4 cols.
- **Code:** `Layout.Slot` elements with `w-full` / `w-6/12` etc.; they wrap automatically.

---

## Translating layouts into Paper (no breakpoints / no grid)
Paper artboards are a **single fixed width** — there's no responsive engine. So:
1. **Pick the breakpoint your artboard sits in** and build *that* column config. A 1440px desktop artboard is `xl` (1280 ≤ 1440 < 1536) → Focus = 10/12 · Supporting left = aside 3 / main 9 · Supporting right = 8/4 · List detail = 6/6 · Dashboard = 4 cols.
2. **Emulate `w-N/12`** with flex: give each slot `flex: N` and a column `gap`; cap the whole content row at **max-width 1928px**, centred, with growing side margins (use `justify-content:center` + `max-width`).
3. **Scroll cues** don't exist in a static mockup — but respect the *structure*: the aside is the narrower, self-contained column; the main is the wide one. Don't draw a scrollbar.
4. **Below-lg / mobile artboards:** show ONE column (the main), and put the aside content on a separate artboard with a `Header` Back button — never cram two columns into a phone width.
5. Outer page = `SideNavigation` + the `Layout`. The Oversikt test page is an **Overview** layout (single full-width column) inside that shell.
