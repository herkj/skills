# Design Audit setup

Run this after installing Design Audit. Reuse the current client's approved tools before proposing
any new connection.

## Core readiness

1. Inspect the currently available connectors and tools for these capabilities:
   `list_components`, `get_design_tokens`, `get_component_api`, `get_component_examples`, and
   `get_guidelines`.
2. If all five come from the authenticated Aidn Design System service, run a harmless catalog or
   token lookup as a smoke test and report the core audit as **Ready**.
3. If they are missing, explain that live conformance findings require
   `https://designsystem.aidn.no/mcp`. Ask permission before adding it with the host's native MCP or
   connector flow. OAuth must happen in the host UI; never ask for or store a token.
4. If the user declines the Design System connection, report Design Audit as **Blocked for
   conformance audits**. It may still offer an explicitly non-conformance design critique, but must
   not present that as a Design Audit result.

Do not replace or duplicate an existing working Design System connection because its display name
differs. Match by service and capabilities.

## Optional capabilities

- **Figma:** needed only to inspect Figma nodes directly. Use an existing approved Figma connector.
  If it is unavailable, screenshots, descriptions, and source code still support a partial audit.
  Ask about connecting Figma only when the user supplies a Figma target and direct inspection would
  materially improve the result.
- **ADS skill:** optional but recommended for people who regularly audit Aidn product screens. It
  improves layout-pattern, color-role, asset, and Figma-library context. It does not replace live
  Design System evidence and does not make a conformance claim authoritative by itself.

Finish with **Ready**, **Limited** (usually no direct Figma inspection or no ADS context), or
**Blocked**, naming the exact capability involved.

