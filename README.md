# Aidn skills

Three Agent Skills for Aidn product and design work. They are intended for Aidn colleagues using
Claude, Cowork, or Codex, while keeping credentials and machine-specific configuration outside the
repository.

## Install with an agent

Tell Claude or Codex:

> Install the skills from https://github.com/herkj/skills

The agent should first show the available skills, let you choose, install only those choices, and
then run each selected skill's own setup. The complete agent-facing flow is in
[`INSTALL.md`](INSTALL.md).

| Skill | What it does | Core requirement |
| --- | --- | --- |
| [`shape`](skills/shape/) | Shapes an Aidn product or design idea into an evidence-grounded Shape Up pitch. | None. Existing workspaces and evidence connectors are optional. |
| [`design-audit`](skills/design-audit/) | Audits Figma designs or coded UI against the live Aidn Design System. | Authenticated Aidn Design System connection. |
| [`ads`](skills/ads/) | Creates Aidn UI in Figma or Paper using ADS foundations and published components. | The output tool requested by the user; live Design System access is recommended. |

ADS is an optional companion to Design Audit. It adds Aidn layout patterns, color-role guidance,
asset rules, and Figma-library context. It does not replace the live Design System evidence required
for a conformance finding.

## Setup and access policy

Each skill owns its setup guide:

- [`shape` setup](skills/shape/references/setup.md)
- [`design-audit` setup](skills/design-audit/references/setup.md)
- [`ads` setup](skills/ads/references/setup.md)

The skills reuse connectors and plugins already approved in Claude or Codex. Installation does not
add an MCP server, start OAuth, install fonts, or request access to a data source. If a workflow
would benefit from missing access, the skill asks at that point. Declining optional access leaves
the skill usable in its documented limited mode.

Design Audit is the exception for core conformance: without the Aidn Design System service it cannot
make Design System findings and reports itself blocked instead of guessing.

## Manual installation

Each skill is self-contained in `skills/<skill-name>/`. Copy the entire selected folder—including
`references/`—into the personal skills directory supported by the client.

- Codex: use its built-in skill installer, or install under `$CODEX_HOME/skills/` (normally
  `~/.codex/skills/`).
- Claude Code: install under `~/.claude/skills/`.
- Cowork: upload the selected skill through **Customize → Skills**, or upload the combined plugin
  from [`packages/aidn-product-skills.plugin`](packages/aidn-product-skills.plugin).

The combined plugin contains all three skills but deliberately contains no credentials or automatic
connector configuration. Run the setup for the skill you plan to use.

## Security and privacy

- No OAuth tokens, API keys, passwords, session cookies, or private workspace data belong in this
  repository.
- Authentication uses the host application's native flow after explicit user approval.
- Figma component/style identifiers in ADS are references, not credentials; Figma still enforces the
  signed-in user's library permissions.
- A private repository requires GitHub access. If this repository becomes public, anyone can read
  the skill instructions, but they do not gain access to Aidn services or Figma libraries.

## Updating

The repository is the distributed source. After changing a skill, rebuild the plugin with
`bash scripts/package-plugin.sh` and re-upload it in Cowork. Locally uploaded Cowork plugins do not
update automatically from GitHub.
