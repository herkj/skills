# ADS Figma Library Reference

Reference for the unified ADS skill's Figma bridge. Read this file when placing real ADS or Bandaid components, applying ADS text styles, setting component properties, or following Aidn layout conventions in Figma.

Use the ADS Components, Design System Bandaid, ADS Light Theme, ADS Text Styles, ADS Numeric Tokens,
and ADS Assets libraries available to the signed-in Aidn Figma account. The current user must have
access and the libraries must be enabled in the target file. Component and style keys do not grant
access or bypass Figma permissions.

Design system documentation: https://designsystem.aidn.no/foundations/

---

## Fidelity hierarchy

Always follow this order. Never jump tiers without exhausting the tier above.

1. **ADS - Components** — real published ADS component instances. Search by name or use keys below.
2. **🩹 Bandaid** — any page whose title starts with ✅ is in scope. Each ✅ page = one component. Use if ADS doesn't cover it.
3. **Custom** — build freely from scratch. No restrictions.

Never apologise for going custom when the libraries don't have it.

---

## How to import and use ADS components

**Always import before creating an instance. Never hardcode component keys inline — define them as named constants.**

```js
// 1. Import the component by key
const comp = await figma.importComponentByKeyAsync("COMPONENT_KEY_HERE");

// 2. Create an instance
const instance = comp.createInstance();

// 3. Parent and position it
parentFrame.appendChild(instance);
instance.x = 0;
instance.y = 0;

// 4. Set variant properties if needed
instance.setProperties({ "Sentiment": "Positive", "Density": "Comfortable" });
```

**To swap to a specific variant directly:**
```js
// Use the variant's own key instead of the component set key
const variant = await figma.importComponentByKeyAsync("SPECIFIC_VARIANT_KEY");
const instance = variant.createInstance();
```

---

## How to apply ADS text styles

**Always import the style, then apply by ID. Never set fontName/fontSize manually on text that could use a style.**

```js
// 1. Import the style (idempotent — safe to call multiple times)
const style = await figma.importStyleByKeyAsync("TEXT_STYLE_KEY_HERE");

// 2. Load the font first (required before setting textStyleId)
await figma.loadFontAsync(style.fontName);

// 3. Create text node
const t = figma.createText();
t.characters = "Your text here";

// 4. Apply style
t.textStyleId = style.id;
```

**Batch import at the top of a script:**
```js
const STYLES = {};
const styleKeys = {
  "heading_xl": "39188b69e557ba5620a7fa4cd462ddeecc7f03db",
  "heading_md": "c4c526be7af04ef7f923fb5e44c66168a883ce5f",
  "body_sm": "deccef436367dfab55ab458ff1fd253ab2c4e1ab",
};
for (const [name, key] of Object.entries(styleKeys)) {
  const s = await figma.importStyleByKeyAsync(key);
  await figma.loadFontAsync(s.fontName);
  STYLES[name] = s;
}
// Then use: t.textStyleId = STYLES.body_sm.id;
```

---

## Text style lookup table

The keys below were verified against the published ADS Text Styles library. They still require the
current user's Figma access.

| Style name | Key | Size | Weight | Use for |
|---|---|---|---|---|
| `Heading/xl` | `39188b69e557ba5620a7fa4cd462ddeecc7f03db` | 28 | Display Semi Bold | Page titles, hero headings |
| `Heading/md` | `c4c526be7af04ef7f923fb5e44c66168a883ce5f` | 18 | Semi Bold | Section titles |
| `Heading/sm` | `b9ed674730048bf005b831f2c25c147c7080df88` | 16 | Semi Bold | Card titles, subsections |
| `Heading/xs` | `7c8b7272c35d2ea5ac30d9ad6d34aeab9d475665` | 14 | Semi Bold | Small labels, column headers |
| `Body/md` | `389c26894afd8a777bed0177ca63abd54ca79572` | 16 | Regular | Primary body text |
| `Body/sm` | `deccef436367dfab55ab458ff1fd253ab2c4e1ab` | 14 | Regular | Secondary body, descriptions |
| `Body/sm-strong` | `dc92b85cd5a82fce866dced48255ea259efa270c` | 14 | Semi Bold | Emphasized body text |
| `Body/xs` | `a1d9bddd2d6af2feb22b7185a08491136ab3a39c` | 12 | Regular | Captions, metadata |
| `Body/xs-strong` | `2a9eee2eaf100ea99f9eddcaeb1985b82029673f` | 12 | Semi Bold | Small labels, tags |
| `Interactive/md` | `0849b30fc69184fac259a0d4abf8669044da2be1` | 16 | Medium | Button labels (large) |
| `Interactive/sm` | `6f91eab48c875d1a6b058c0b15e37821da69553a` | 14 | Medium | Button labels (default), nav items |
| `Tabular/md` | `40952c87938a7f2e52d53e0d4336189a5d520efc` | 16 | Regular | Numbers in tables |
| `Tabular/xs` | `bdef82cc8f69f1f4732539e0902c464858e9838e` | 12 | Regular | Small numbers |

---

## ADS component key lookup table

Keys confirmed from the ADS Components file. Use with `importComponentByKeyAsync`.

### Button (`→ Button` page)
| Variant | Key |
|---|---|
| COMPONENT_SET | `6ef031f59cd2fc28ce203df991c4d298a41511f9` |
| Elevated / None / Compact / Enabled (primary CTA) | `99f858c1b92e3fec049f6cfda9e4c696fa0bfd8f` |
| Ghost / None / Compact / Enabled (secondary) | `34c3ea07cde9d4ba62124ca009b6333b15d742a2` |
| Subtle / None / Compact / Enabled | `f292b60828c1d25916a64232b97c272d88ff40ff` |
| Destructive / None / Compact / Enabled | `22df7e5ebe5c3d86141054907643215475910be0` |
| Ghost inverted / None / Compact / Enabled | `7d398b4e3dfe3bc9248d410a3196dd14037746f7` |

### Tag (`→ Tag` page)
| Variant | Key |
|---|---|
| COMPONENT_SET | `be7d3f0ae5afdc7b7ae5b811eb16a4dbb9b91ce3` |
| Neutral | `280ed7192f89c27f5384b51bc1af198f6cfe001c` |
| Informative | `88e4dbf051c89e50a2c51dbd0bcfa58dc1573f8d` |
| Positive | `1ae555274a467f0229f23d3e9c561cdb8e7a99fb` |
| Negative | `8e4ce914e8e15d8ae9ecb0fe751b09d6f1bb5b02` |
| Attentive | `e4ed413e3d58b8be7dec7a050087df64cf80df34` |
| Warning | `f230ee8801ea5150aa469f4276f65c51bcea6395` |
| Critical | `2d4dc1306ad461b40757c10a627c4872219706df` |

### Message (`→ Message` page)
| Variant | Key |
|---|---|
| COMPONENT_SET | `04647bc1f2e0ea1a59344eb3646a6b2ba9e79988` |
| Neutral / Comfortable | `e2cee3d69cbc32ae57c15015582140c8b061aff8` |
| Informative / Comfortable | `0f1bbc8b86a53b37d9bd83f5b2d4871828409cce` |
| Positive / Comfortable | `b104d2bcf926440dc899de8ee330a924e4922d9e` |
| Negative / Comfortable | `1ced2f2382cad028a09f6536f317e69874894542` |
| Attentive / Comfortable | `23fcede915ab72d36f839b19b87f2efbe9fbecfc` |

### Switch (`→ Switch` page, ADS)
| Variant | Key |
|---|---|
| COMPONENT_SET | `5ae25ddb3b7661631374b7d343212c9cc2a17a3e` |
| Label=False (clean toggle) | `c61e6539f59733d2dd2154c4ea20b20c1e2a03be` |
| Label=True (with label) | `4f3af59fa956d7fbc07150fa13d830b974fb186d` |

### Checkbox (`→ Checkbox` page)
| Variant | Key |
|---|---|
| COMPONENT_SET | `0d1c9a004731e5e782e635b57c2748b1f2d49958` |
| Compact / Unchecked / Enabled | `308c9ebae154ed4140aba0341af26832515948ce` |
| Compact / Checked / Enabled | `7caed0b35fdeb64566c4a1f0e880e93f7952f619` |

### Interactive Card (`→ Interactive Card` page)
| Variant | Key |
|---|---|
| Comfortable / Resting / Radius lg | `3c1663d52bca7ff6e8c41d071f075eb32c195f29` |
| Comfortable / Resting / Radius md | `ec5ce55a1931d91e0972298c8f841ddf9d2a8fc4` |
| Comfortable / Active / Radius lg | `8c5fe2e7c52ec98d380dcc6803c8e9ceb3e22a8e` |

---

## Bandaid component key lookup table (✅ pages only)

Keys confirmed from the Bandaid file.

### ✅ Switch (Bandaid — use when you need a toggle with Ant Design style)
| Variant | Key |
|---|---|
| COMPONENT_SET | `a2ea5f1155f65efc46ada46a3a4c67e0b7de4e56` |
| Default / Active=True | `d11d32ebdd523545a057a7aa4120bf66ed85f260` |

### ✅ Table (Bandaid)
| Variant | Key |
|---|---|
| COMPONENT_SET | `bb2c301dbe9b1d96a01dadc5232eaf7f9217a821` |
| Default / Bordered=False | `2229495f159b3b071b012c1a62b6268f2e667511` |
| Default / Bordered=True | `df74a8dd2aabe490af49eb702024994a2235feb1` |

### ✅ Badge (Bandaid)
| Variant | Key |
|---|---|
| Status COMPONENT_SET | `573eb53b6302a1c9d1074c91610c00f86b215197` |
| Status=Success | `5b974a1f2b08e392308b0821309f5171772f1071` |
| Status=Error | `2f983669ed515ce5be53321c5d44ef2729e84e46` |
| Status=Processing | `8057f3abaa9a1e233fc973cd6afcbd388fb9f136` |
| Status=Warning | `9a64060495aa297c60720a10628f5d9d5f581855` |

### ✅ Tabs (Bandaid)
| Variant | Key |
|---|---|
| COMPONENT_SET | `a6c34a1a3cbd29c99dcb96f269bfd739877ce81d` |
| Top / Default | `e329f2b49e172636a618585b071c9ad17b177639` |

---

## Bandaid ✅ pages (full list)

These pages are in scope. Each page name = one component/pattern available to use.

**Navigation:** Anchor, Dropdown, Menu, Pagination, Steps
**Data Entry:** AutoComplete, Cascader, ColorPicker, Mentions, Rate, Slider, Switch, TreeSelect, Upload
**Data Display:** Transfer, Badge, Calendar, Carousel, Collapse, Image, List, Popover, QRCode, Segmented, Statistic, Table, Tabs, Timeline, Tooltip, Tour, Tree
**Feedback:** Message, Popconfirm, Notification, Progress, Skeleton, Watermark, Spin

**⛔️ pages are NOT in scope** — use ADS instead for: Button, Checkbox, Input, Select, Radio, Tag, Avatar, Card, Alert, Drawer, Modal.

---

## ADS color palette (hardcoded fallback — use until variable file is mapped)

These are the resolved values behind ADS - Light Theme tokens.

```js
const ADS = {
  // Backgrounds
  bgDefault:    { r: 1,     g: 0.957, b: 0.945 }, // #FFF4F1 peach canvas
  bgWhite:      { r: 1,     g: 1,     b: 1     }, // white card surface
  bgContainer:  { r: 0.980, g: 0.969, b: 0.973 }, // #FAF7F9 subtle container

  // Brand / interactive
  violet:       { r: 0.573, g: 0.337, b: 0.631 }, // #9256A1 primary
  violetSubtle: { r: 0.937, g: 0.902, b: 0.953 }, // #EFE6F3 hover/active bg

  // Text
  textDefault:  { r: 0.102, g: 0.071, b: 0.094 }, // #1A1218
  textMuted:    { r: 0.447, g: 0.384, b: 0.424 }, // #72626C
  textDisabled: { r: 0.671, g: 0.624, b: 0.651 }, // #AB9FA6

  // Border
  borderDefault:{ r: 0.898, g: 0.875, b: 0.886 }, // #E5DFE2
  borderStrong: { r: 0.737, g: 0.694, b: 0.718 }, // #BCB1B7

  // Sentiments (background / text)
  positiveBg:   { r: 0.878, g: 0.965, b: 0.910 }, // #E0F6E8
  positiveText: { r: 0.102, g: 0.502, b: 0.282 }, // #1A8048
  informativeBg:{ r: 0.878, g: 0.921, b: 0.988 }, // #E0EBFC
  informativeText:{ r: 0.102, g: 0.329, b: 0.702 }, // #1A54B3
  attentiveBg:  { r: 0.988, g: 0.945, b: 0.820 }, // #FCF1D1
  attentiveText:{ r: 0.600, g: 0.380, b: 0.020 }, // #996105
  negativeBg:   { r: 0.988, g: 0.878, b: 0.878 }, // #FCE0E0
  negativeText: { r: 0.702, g: 0.102, b: 0.102 }, // #B31A1A
};
```

---

## Layout principles

- **4px grid.** All sizing and placement snaps to 4px.
- **Spacing scale:** 4, 8, 12, 16, 20, 24, 32, 40, 48px — no invented values.
- **Light theme only** for product/clinical screens.
- **Foundations page** (https://designsystem.aidn.no/foundations/) is the authority on layout and grid. When in doubt, check there.
- **Norwegian bokmål** is the default language for Aidn product surfaces.

---

## Script template: importing components + styles

Use this as the opening of any build script.

```js
// --- STYLE IMPORTS ---
const STYLE_KEYS = {
  heading_xl:  "39188b69e557ba5620a7fa4cd462ddeecc7f03db",
  heading_md:  "c4c526be7af04ef7f923fb5e44c66168a883ce5f",
  heading_sm:  "b9ed674730048bf005b831f2c25c147c7080df88",
  heading_xs:  "7c8b7272c35d2ea5ac30d9ad6d34aeab9d475665",
  body_md:     "389c26894afd8a777bed0177ca63abd54ca79572",
  body_sm:     "deccef436367dfab55ab458ff1fd253ab2c4e1ab",
  body_sm_strong: "dc92b85cd5a82fce866dced48255ea259efa270c",
  body_xs:     "a1d9bddd2d6af2feb22b7185a08491136ab3a39c",
  body_xs_strong: "2a9eee2eaf100ea99f9eddcaeb1985b82029673f",
  interactive_sm: "6f91eab48c875d1a6b058c0b15e37821da69553a",
};

const S = {};
for (const [name, key] of Object.entries(STYLE_KEYS)) {
  const style = await figma.importStyleByKeyAsync(key);
  await figma.loadFontAsync(style.fontName);
  S[name] = style;
}

// Helper: create a text node with an ADS style
function styledText(chars, styleName, color, fixedW) {
  const t = figma.createText();
  t.textStyleId = S[styleName].id;
  t.fills = [{ type: 'SOLID', color }];
  if (fixedW) { t.textAutoResize = 'HEIGHT'; t.resize(fixedW, 20); }
  t.characters = chars;
  return t;
}

// --- COMPONENT IMPORTS ---
const COMP_KEYS = {
  button_primary:       "99f858c1b92e3fec049f6cfda9e4c696fa0bfd8f",
  button_ghost:         "34c3ea07cde9d4ba62124ca009b6333b15d742a2",
  tag_neutral:          "280ed7192f89c27f5384b51bc1af198f6cfe001c",
  tag_positive:         "1ae555274a467f0229f23d3e9c561cdb8e7a99fb",
  tag_informative:      "88e4dbf051c89e50a2c51dbd0bcfa58dc1573f8d",
  tag_attentive:        "e4ed413e3d58b8be7dec7a050087df64cf80df34",
  tag_negative:         "8e4ce914e8e15d8ae9ecb0fe751b09d6f1bb5b02",
  switch_off:           "c61e6539f59733d2dd2154c4ea20b20c1e2a03be",
  switch_on:            "4f3af59fa956d7fbc07150fa13d830b974fb186d",
  checkbox_unchecked:   "308c9ebae154ed4140aba0341af26832515948ce",
  checkbox_checked:     "7caed0b35fdeb64566c4a1f0e880e93f7952f619",
  interactive_card:     "3c1663d52bca7ff6e8c41d071f075eb32c195f29",
  message_informative:  "0f1bbc8b86a53b37d9bd83f5b2d4871828409cce",
  message_attentive:    "23fcede915ab72d36f839b19b87f2efbe9fbecfc",
};

const C = {};
for (const [name, key] of Object.entries(COMP_KEYS)) {
  C[name] = await figma.importComponentByKeyAsync(key);
}

// Usage: const instance = C.button_primary.createInstance();
```

---

## Component property names (confirmed via inspection)

Use these exact property name strings in `instance.setProperties({})`. Property names include emoji and ID suffixes — copy them exactly.

### Tag
| Property | Key string | Type | Notes |
|---|---|---|---|
| Label text | `"↪️ ✏️ Label#10545:5"` | TEXT | The visible label string |
| Show icon | `"Icon#10545:6"` | BOOLEAN | Set `false` to hide the icon prefix |
| Sentiment | `"Sentiment"` | VARIANT | `"Neutral"`, `"Informative"`, `"Positive"`, `"Negative"`, `"Attentive"` |

```js
const t = C.tag_informative.createInstance();
parent.appendChild(t);
t.setProperties({ "↪️ ✏️ Label#10545:5": "Skjema", "Icon#10545:6": false });
```

### Button
| Property | Key string | Type | Notes |
|---|---|---|---|
| Label text | `"↪️ ✏️ Label#73:3"` | TEXT | Button label |
| Show end icon (arrow) | `"Icon end#79:4"` | BOOLEAN | Default true. Set `false` for plain text buttons |
| Show start icon | `"Icon start#79:0"` | BOOLEAN | Default false |

```js
const btn = C.button_primary.createInstance();
parent.appendChild(btn);
btn.setProperties({ "↪️ ✏️ Label#73:3": "Lagre endringer", "Icon end#79:4": false });
```

### Message
| Property | Key string | Type | Notes |
|---|---|---|---|
| Heading text | `"Heading#4005:5"` | TEXT | Bold heading |
| Body text | `"↪ ✏️ Text#4111:20"` | TEXT | Secondary body text |
| Show body | `"✏️ Text#4214:0"` | BOOLEAN | Set `true` to show the body text |
| Sentiment | `"Sentiment"` | VARIANT | `"Informative"`, `"Attentive"`, `"Positive"`, `"Negative"`, `"Neutral"` |

```js
const msg = C.message_informative.createInstance();
parent.appendChild(msg);
msg.setProperties({
  "Heading#4005:5": "Meldingens tittel",
  "↪ ✏️ Text#4111:20": "Utfyllende informasjon om meldingen.",
  "✏️ Text#4214:0": true,
});
```

### Switch
| Property | Key string | Type | Notes |
|---|---|---|---|
| Label text | `"↪️ ✏️ Label#15629:2"` | TEXT | Text shown next to the toggle |
| Description visible | `"Description#15629:5"` | BOOLEAN | Set `false` to hide the description subtext |

- `switch_on` key (Label=True variant): shows label text next to toggle. Use for enabled/on state.
- `switch_off` key (Label=False variant): hides label text. Use for disabled/off state.
- The toggle's X icon is its visual handle — this is expected ADS behavior.

```js
// Enabled feature with "Aktiv" label
const swOn = C.switch_on.createInstance();
row.appendChild(swOn);
swOn.setProperties({ "↪️ ✏️ Label#15629:2": "Aktiv", "Description#15629:5": false });

// Disabled feature — no label shown
const swOff = C.switch_off.createInstance();
row.appendChild(swOff);
swOff.setProperties({ "Description#15629:5": false });
```

---

## Gotchas

- **Set properties AFTER parenting.** `instance.setProperties(...)` works reliably once the instance is in the canvas. Don't call it before `parent.appendChild(instance)`.
- **Interactive Card is a container** — after creating the instance, add your own text/content inside it. It provides the surface (border, background, hover state), not the label.
- **Property names include emoji and ID suffixes** — `"↪️ ✏️ Label#10545:5"` not `"Label"`. Copy from the table above exactly.
- **`componentPropertyDefinitions` throws on variant components** — only works on component sets. Use `instance.componentProperties` to inspect a created instance instead.
- **Switch state** — use `switch_on` key for on-state (Label=True, shows label text), `switch_off` for off-state (Label=False, hides label text). Both show the X toggle handle — this is ADS behavior.
- **importComponentByKeyAsync throws if the library isn't enabled or accessible** — the keys above
  do not bypass the current user's Figma permissions.
