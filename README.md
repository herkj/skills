# Aidn product skills

Two reusable Agent Skills for Aidn product and design work. The repository is also a Cowork/Claude
Code plugin, so the skills and the Aidn Design System connector can be installed together.

## Included skills

| Skill | What it does | Required dependencies |
| --- | --- | --- |
| [`design-audit`](skills/design-audit/) | Audits an Aidn Figma design or UI implementation against the live Aidn Design System. | Authenticated Aidn Design System connector, included in the plugin. |
| [`shape`](skills/shape/) | Shapes Aidn product or design ideas into evidence-grounded Shape Up pitches and appropriately sized research plans. | None. An attached workspace and Slack, Notion, or Productboard access improve the result but are optional. |

Neither skill depends on the local `ADS` skill. `design-audit` may use ADS or other design-review
skills when present, but they are optional references rather than requirements.

## Install in Claude Cowork

1. Download [`packages/aidn-product-skills.plugin`](packages/aidn-product-skills.plugin).
2. In Cowork, open **Customize → Plugins** and upload the file.
3. Authenticate the Aidn Design System connector when prompted.
4. Enable `shape` and `design-audit` in the plugin.

The Design System server is remote and uses OAuth; no credentials are stored in this repository.
Direct Figma inspection additionally requires the user's Figma connector. Without Figma, the audit
can still work from screenshots, descriptions, or source code and will label the result partial.

## Install an individual skill

Each skill is self-contained in `skills/<skill-name>/`. Copy the entire selected folder into the
personal skills directory supported by the client. For Claude Code that is
`~/.claude/skills/<skill-name>/`; restart only if the top-level skills directory did not previously
exist.

Cowork users who do not want the combined plugin can ZIP one skill folder so the ZIP contains the
skill directory at its root, then upload it through **Customize → Skills**. The combined plugin is
recommended for `design-audit` because it also supplies the connector configuration.

## Portability behavior

- `shape` first uses a user-provided or attached Aidn vault. If none is available, it offers to
  save under the current writable workspace or complete the pitch in chat.
- Slack, Notion, Productboard, Amplitude, and other evidence sources are optional. Missing access is
  recorded as unknown evidence rather than replaced with guesses.
- `design-audit` requires the five baseline Design System capabilities documented in its skill. It
  stops cleanly when the connector cannot provide them.
- This is a private repository. GitHub users need explicit repository access to download the source
  or packaged plugin.

## Updating

The repository is the distributed source. After changing a skill, rebuild the plugin package and
re-upload it in Cowork. Run `bash scripts/package-plugin.sh` from the repository to rebuild
`packages/aidn-product-skills.plugin`. Locally uploaded Cowork plugins do not update automatically
from GitHub.
