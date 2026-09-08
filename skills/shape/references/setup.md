# Shape setup

Run this after installing Shape. The goal is to choose where its output goes, not to provision new
data access.

## Setup

1. Confirm that the complete `shape` folder is installed in the current Claude, Cowork, or Codex
   skills location.
2. Inspect only the workspaces and connectors the host already exposes. Do not add a connector,
   change client configuration, or start an authorization flow during setup.
3. Resolve the default output location:
   - use an explicitly selected workspace or vault;
   - otherwise use the single accessible workspace containing `Aidn/Shaping learnings.md` or
     `Aidn/initiatives/`;
   - otherwise offer a forced choice between the current writable workspace and chat.
4. Report Shape as **Ready**. Missing Slack, Notion, Productboard, Amplitude, Figma, or vault access
   makes the evidence thinner, but never blocks shaping.

Do not create an empty vault, memory file, or shaping folder just to complete setup.

## Access during a shaping session

Shape performs its cold read before retrieval. When retrieval begins, use an already approved
connector if it can test a specific claim.

If useful evidence needs access the host does not currently have, offer one concrete choice:

- continue without it and record the claim as `[unknown]`; or
- let the host connect or authorize that source now.

Recommend continuing without it when the source is not likely to change the decision. If the user
declines access, continue the session normally. Never request credentials directly or persist them
in the pitch.

