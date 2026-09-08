# Agent installation contract

Use this flow when a user says something like:

> Install the skills from https://github.com/herkj/skills

## 1. Offer a choice before installing

Show the available skills and ask which ones to install:

1. **Shape** (`skills/shape`) — shape an Aidn product idea. No required connectors.
2. **Design Audit** (`skills/design-audit`) — audit Aidn UI against the live Aidn Design System.
3. **ADS** (`skills/ads`) — create Aidn UI in Figma or Paper with ADS components and foundations.
4. **All three**.

Mention that ADS is an optional companion to Design Audit: it improves Aidn layout, asset, color-role,
and Figma-library context, but the live Design System connector remains the authority for audit
findings.

Do not install a skill the user did not select.

## 2. Install complete skill folders

Install the complete selected directories, including their `references/` folders, using the host's
normal Agent Skills mechanism. In Codex, prefer the built-in skill installer. In Claude or Cowork,
use the supported personal skill or plugin installation flow.

If a destination already exists, do not silently overwrite it. Compare versions and ask before
updating. Tell the user when the host needs a new turn or restart before discovering a newly
installed skill.

## 3. Run only the selected setup guides

Immediately after installation, read and follow each selected skill's setup guide:

- Shape: `skills/shape/references/setup.md`
- Design Audit: `skills/design-audit/references/setup.md`
- ADS: `skills/ads/references/setup.md`

Setup must inspect and reuse plugins, MCP servers, connectors, accounts, and workspace permissions
that are already available in Claude or Codex. It must not create a new connection, edit client
configuration, or start OAuth merely because a skill was installed.

If a requested workflow later needs missing access, explain the benefit and ask permission at that
point. A refusal is valid: continue in the documented limited mode when one exists, and say exactly
what could not be verified or changed.

## 4. Protect credentials and private data

- Never ask the user to paste an OAuth token, API key, session cookie, or password into chat.
- Use the host application's native OAuth or connector flow after the user approves it.
- Never copy credentials into this repository, a skill folder, generated output, or logs.
- Do not upload Aidn workspace content to a new service as part of setup.
- Treat repository, Figma, Slack, Notion, Productboard, and vault access as separate permissions.

## 5. Finish with a setup result

Report each selected skill as:

- **Ready** — its core workflow can run.
- **Limited** — it can run, but name the unavailable optional evidence or output capability.
- **Blocked** — the requested core workflow cannot run; name the missing requirement and the safe
  next action.

