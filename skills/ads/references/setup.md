# ADS setup

Run this after installing ADS. Use the connectors, plugins, accounts, and permissions already
approved in Claude, Cowork, or Codex. Installation alone must not create a connection or trigger
OAuth.

## Shared Design System access

1. Look for an existing authenticated connector exposing the Aidn Design System capabilities,
   including live tokens, components, examples, APIs, and guidelines.
2. If present, run a harmless lookup and mark live ADS data **Ready**.
3. If absent, explain that `https://designsystem.aidn.no/mcp` provides current values. Ask permission
   before adding it through the host's native connection flow. Never request or store credentials.
4. If the user declines, ADS can still use its bundled, version-stamped references in **Limited**
   mode. Clearly label fallback values as snapshots and do not claim current component fidelity.

## Output tools

- **Figma route:** use an existing approved Figma tool and the user's signed-in Aidn account. The
  published ADS/Bandaid library keys do not grant library access. If Figma is unavailable, ask about
  connecting it only when the user requests a Figma deliverable; otherwise provide a design plan or
  use another already available output tool.
- **Paper route:** use Paper only when its existing tool is available and Paper Desktop has an open
  file. If it is unavailable, do not install or launch software without permission.
- **Fonts:** detect installed fonts. Do not download or install fonts during setup. Use the documented
  fallback when Nocturno is unavailable.

ADS is **Ready** when live Design System data and the requested output tool are available. It is
**Limited** when snapshots or an alternate output are sufficient. It is **Blocked for the requested
output** only when the user asks for a direct Figma/Paper edit and declines or cannot provide that
tool's access.

