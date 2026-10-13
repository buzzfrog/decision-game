---
title: Outpost Sentinel - Microsoft-Decision-1 Tactical Defense Demo
description: A real-time tactical defense game demonstrating Microsoft-Decision-1.
---

## Outpost Sentinel - Microsoft-Decision-1 Tactical Defense Demo

A real-time 2D tactical defense game and interactive demonstrator for the **Microsoft-Decision-1** model available in [Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/foundry-models/how-to/use-foundry-models-microsoft-decision).

## Overview

Unlike generative large language models (LLMs) that produce free-form text, `Microsoft-Decision-1` operates as a high-speed, bounded **System-1 decision engine**. It evaluates a structured state payload and returns typed numerical judgments with probabilities in tens of milliseconds.

For a general explanation of the term, see [System-1 decision engine](SYSTEM-1-DECISION-ENGINE.md).

This demo illustrates all three core decision primitives supported by the API:

| Primitive | Decision-1 API Type | Demo In-Game Role | Result Format |
|---|---|---|---|
| **Gate / Filter** | `noul` | Target hostility classification (`is_hostile`) | Probability from 0.0 to 1.0 |
| **Routing / Classification** | `choice` | Tactical response selection (`tactical_response`) | Selected action + per-option probabilities (`intercept`, `shield`, `dock`, `ignore`) |
| **Grading / Ranking** | `score` | Incident severity rating (`threat_level`) | Ordered scale value ($0 \to 3$) and level distribution |

## Features

- **2D Radar Canvas Simulation**: Approaching bogeys (Raider gunships, stellar plasma storms, civilian distress pods, inert space debris) move toward the station core.
- **Autonomous AI Co-Pilot vs. Manual Duel**:
  - **Autonomous Mode**: The Decision-1 model continuously evaluates contacts and triggers defenses automatically.
  - **Manual Mode**: Test your own reaction speed with keyboard shortcuts `[1]` through `[4]` against model predictions.
- **Real-Time Telemetry Inspector**:
  - Interactive probability distribution bars.
  - Real-time latency measurement in milliseconds.
  - **"In plain English" explanation** of each decision: what the contact is, how hostile and dangerous the AI thinks it is, and the recommended action.
  - The AI's chosen action is also labelled on the target in the radar view, and action buttons have tooltips explaining when to use them.
- **JSON Pane** (hidden by default, toggle with **`J`** or the **{ } JSON** header button):
  - Shows the complete `{ request, response }` exchange with Decision-1: model, live game state, the three questions with their criteria, and the raw response (`"pending..."` until the AI answers).
  - Live-synced with the game: distance, hull, and shield values update as the target approaches; late responses for an old target are ignored.
  - Scrolls independently, so it never disturbs the game view.
  - Select any part of the JSON and click **📋 Copy** (or Ctrl+C) to copy it; with nothing selected, Copy takes the whole JSON.
- **Pause**: **⏸ Pause** button in the header, or press **`P`** / **Space**. The radar freezes and the auto-pilot and next spawn wait until you resume.
- **Dual Engine**:
  - **Instant Simulator**: Runs locally with sub-50ms simulated inference (no Azure credentials required).
  - **Live Azure Foundry API**: Enter your Foundry resource endpoint, deployment name, and API key via the in-app **⚙️ Settings** modal to call your deployed model directly. Settings are saved in the browser's `localStorage`. If a saved connection exists, the game starts in live mode, and the status pill reflects it; if a live call fails, it falls back to the simulator.
- **Synthesized Web Audio FX**: Lasers, tractor beams, shield hums, and explosions synthesized via Web Audio API.

## Controls

| Key | Action |
|---|---|
| `1` / `2` / `3` / `4` | Laser Intercept / Shield Boost / Tractor Dock / Hold-Ignore |
| `P` or `Space` | Pause / resume |
| `J` | Show / hide the JSON pane |

## Running the Demo

Because the game is completely self-contained in a single HTML file with no build steps or external dependencies, you can run it immediately:

### Start Script (Recommended)
```powershell
.\start.ps1            # serves on http://localhost:8080
.\start.ps1 -Port 9000 # custom port
```
With Python installed, it starts a local web server, waits until it responds, and then opens the browser (Ctrl+C stops the server). A stable `http://localhost` origin keeps saved settings between runs and avoids CORS problems with the live API. Without Python, it simply opens `index.html`.

### Quick Run
Double-click `index.html` or open it in any modern browser:
```powershell
Start-Process .\index.html
```

### Local Web Server (manual)
```powershell
python -m http.server 8080
```
Then navigate to [http://localhost:8080](http://localhost:8080).

## API Reference

- **Endpoint**: `<your-foundry-endpoint>/providers/microsoft/v1/systemone`
- **Method**: `POST`
- **Header**: `api-key: <your-key>` or `Authorization: Bearer <Entra-Token>`
