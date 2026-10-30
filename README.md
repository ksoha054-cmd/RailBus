# RailBus — Mysuru Edition

Three separate applications, one shared backend: Passenger `/passenger/`, Admin `/admin/`, Conductor `/conductor/`.

## Run on Windows
1. Install Node.js LTS from https://nodejs.org/en/download/.
2. Extract this folder.
3. Open `backend` and double-click `start.bat`.
4. Keep the terminal open. It should say `RailBus shared backend running at http://localhost:3000`.
5. Open these URLs in Chrome:
   - http://localhost:3000/passenger/
   - http://localhost:3000/admin/
   - http://localhost:3000/conductor/

## Features
- One shared Node.js API and JSON database (`backend/railbus-db.json`, created on first write).
- Passenger booking and shared demand counts by destination + 30-minute arrival slot.
- Payment state is held as `PROCESSING_HOLD`; cutoff at 20+ seats confirms it; below 20 sets `CANCELLED_REFUND_REQUIRED`.
- Dispatch allocation splits confirmed demand into assumed 40-seat buses; admin can reassign a dispatch.
- Conductor ticket validation is one-time; repeat scans are rejected.
- English/Kannada toggle, light/dark mode, weather-aware palette, Mysuru destinations and train board.

## Live data setup and honest limitations
- **Weather:** GET `/api/weather` requests current Mysuru weather from Open-Meteo. If network access/provider is unavailable, the UI reports that; it does not invent conditions.
- **Train running status:** the backend adapter is prepared for the third-party RailRadar live API. Copy `.env.example` to `.env` in the project root and add a valid `RAILRADAR_API_KEY`. Restart the server. The API key stays server-side. Without a key, train status is timetable-only / unavailable. Confirm live train running status through official NTES: https://enquiry.indianrail.gov.in/mntes/.
- **Bus GPS/ETA:** not connected. Actual live bus location/delay needs an authorised KSRTC fleet/ITS feed. Dispatches in this prototype are allocation records only.
- **Payments:** no payment gateway is connected. The app simulates a processing hold and confirmation/cancellation state; it does not charge or refund real money. Add a gateway plus verified refund webhooks before production.
- **Fares:** all shown fares are illustrative demo values, not official KSRTC fares.
- **Assumptions:** 20-seat threshold, 30-minute arrival slot and 40-seat bus capacity are prototype assumptions, not approved KSRTC rules.
- **Security:** local demonstration only; no production authentication, role access control or concurrency-safe database. Do not expose this server publicly.

## Useful API endpoints
`GET /api/health`, `/api/trains`, `/api/routes`, `/api/live-status?train_no=...`, `/api/live-board`, `/api/weather`, `/api/bookings`, `/api/demand`, `/api/dispatches`, `/api/tickets`; `POST /api/bookings`, `/api/admin/seed`, `/api/admin/cutoff`, `/api/admin/rebalance`, `/api/conductor/validate`, `/api/admin/reset`.

## Multi-laptop demo
All devices must be on the same trusted Wi-Fi. Configure the backend to listen on the host machine's LAN interface, allow port 3000 through Windows Firewall, and update the front-end API base to the host's LAN IP. Do not expose the prototype to the public internet. The current default is localhost on one laptop.

## Round 2 + Round 3
See `ROUND2_ROUND3_PRESENTATION.md` for architecture, criteria mapping, implementation status, team split, test evidence checklist and demo script.


## Operations / QR update (October 2026)
- Passenger, Admin and Conductor share the same backend and RailBus illustration. Dark theme colours are retained; Passenger light mode now explicitly overrides labels, captions, hints, status chips, inputs and buttons for readable contrast.
- Passenger train and destination search now show selectable suggestions. Preferred bus time is entered and displayed in 12-hour AM/PM format; the API stores 24-hour HH:mm for grouping.
- Conductor sign-in uses assigned bus number plus a demo PIN. Demo buses use PIN `1234`; this is intentionally not production authentication.
- Conductor QR scanning uses the browser BarcodeDetector API and camera permission. Camera access requires localhost or HTTPS and a compatible browser (e.g. current Chrome); manual ticket-code entry remains available.
- Demo tickets can be loaded from Admin → Load demo tickets. Current package includes two confirmed demo tickets and buses `MYS-RB-001` / `MYS-RB-002`, both with demo PIN `1234`. Resetting the database clears them; click Load demo tickets again.
- Weather uses Open-Meteo current conditions for Mysuru. This is a live public weather feed when network access is available.
- The official Karnataka KSRTC portal is linked for current service and fare verification. The portal does not expose a public documented city-bus fleet/dispatch API to this prototype; RailBus does not scrape private operator systems or claim simulated bus allocations are KSRTC dispatches.
- A 122A city-bus schedule reference is included from a public third-party timetable page and is clearly marked as a reference, not an official/live KSRTC feed. Times should be verified with the operator before use.
- Fare values in RailBus remain illustrative demo estimates, not official KSRTC fares. Official reservation terms state that service fare is shown during the booking flow and may change before the journey.


## IMPORTANT: install this build as a fresh folder
1. Stop any older RailBus server with Ctrl+C in its terminal.
2. Extract this ZIP into a NEW folder (for example, Desktop\RailBus_Final). Do not merge it into an older extraction.
3. Open that new folder and run `backend\start.bat`.
4. Open Passenger at http://localhost:3000/passenger/, Admin at http://localhost:3000/admin/, and Conductor at http://localhost:3000/conductor/.
5. Hard-refresh each browser tab with Ctrl+Shift+R. The pages use versioned asset URLs to avoid stale cached CSS/JS.

## This build's verified scope
- Light-mode contrast overrides are scoped to `body.light`; the dark theme rules are not modified.
- Conductor camera scanning uses native BarcodeDetector where available and jsQR as a fallback (the jsQR library is loaded from a CDN, so internet is needed for that fallback). Manual ticket-code validation remains available.
- Camera access requires localhost or HTTPS and browser permission.
- Demo bus assignments and demo fares are not official KSRTC dispatch or fare data. No public KSRTC live fleet-dispatch API is configured in this prototype.
- Weather uses Open-Meteo and requires internet access.


## Moovit route allocation in Admin
See `MOOVIT_ADMIN_BUS_ALLOCATION.md`. Admin can select a confirmed dispatch, assign a Moovit-listed KSRTC route number near Mysuru Railway Station, enter the departure time verified on Moovit, and keep the RailBus vehicle ID/conductor login unchanged. Route numbers are not fleet registration numbers.


## Passenger/conductor accounts and boarding tickets
See `ACCOUNT_AND_TICKET_WORKFLOW.md` for sign-out/re-login, confirmed-ticket priority, passenger QR presentation and conductor scan validation.
