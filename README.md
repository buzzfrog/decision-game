# Outpost Sentinel - Microsoft-Decision-1 Tactical Defense Demo

A real-time 2D tactical defense game and interactive demonstrator for the **Microsoft-Decision-1** model available in [Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/foundry-models/how-to/use-foundry-models-microsoft-decision).

## Overview

Unlike generative large language models (LLMs) that produce free-form text, `Microsoft-Decision-1` operates as a high-speed, bounded **System-1 decision engine**. It evaluates a structured state payload and returns typed numerical judgments with probabilities in tens of milliseconds.

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
  - Live state JSON passed to the model.
  - Interactive probability distribution bars.
  - Real-time latency measurement in milliseconds.
- **Dual Engine**:
  - **Instant Simulator**: Runs locally with sub-50ms simulated inference (no Azure credentials required).
  - **Live Azure Foundry API**: Enter your Foundry resource endpoint, deployment name, and API key via the in-app **⚙️ Settings** modal to call your deployed model directly.
- **Synthesized Web Audio FX**: Lasers, tractor beams, shield hums, and explosions synthesized via Web Audio API.

## Running the Demo

Because the game is completely self-contained in a single HTML file with no build steps or external dependencies, you can run it immediately:

### Quick Run
Double-click `index.html` or open it in any modern browser:
```powershell
Start-Process .\index.html
```

### Local Web Server (Recommended for Live API to avoid CORS)
```powershell
python -m http.server 8080
```
Then navigate to [http://localhost:8080](http://localhost:8080).

## API Reference

- **Endpoint**: `<your-foundry-endpoint>/providers/microsoft/v1/systemone`
- **Method**: `POST`
- **Header**: `api-key: <your-key>` or `Authorization: Bearer <Entra-Token>`
