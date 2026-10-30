# RailBus Passenger Easy Mode — setup and integration notes

## Start
1. Extract the ZIP.
2. Keep `.env` in the project root (same level as `backend`, `passenger`, `admin`, `conductor`).
3. Start `backend/start.bat` on Windows.
4. Open `http://localhost:3000/passenger/`.

## Passenger changes
- Simplified four-step booking flow: train, destination/time, passenger, request bus.
- Searchable train number/name field and searchable destinations.
- 12-hour arrival-time choices (AM/PM).
- Expanded destination catalogue (49 places in this package; more can be added to `data/sample_routes.json`).
- New RailBus SVG mark and train/bus illustration; Mysuru ambience hero, daytime flying birds and night-time stars.
- Kannada/English switch, dark/light switch, mobile-friendly controls.
- Account flow supports mobile OTP, optional email and optional password. Passwords are stored as scrypt hashes.

## Authentication limitation — important
The included OTP flow is **development-only**. It prints the six-digit OTP in the backend terminal/Command Prompt. It does not send an SMS. Before public deployment, connect a real SMS OTP provider, enforce provider-side rate limits, add HTTPS, secure session cookies, CSRF protections, account recovery, consent/privacy terms, and production-grade abuse controls. Do not expose OTPs in API responses.

## Train data
Train data continues to use the configured third-party RailRadar adapter. A configured API key does not guarantee a successful live response; check `/api/health` and the passenger train board. Verify important journeys using official NTES.

## KSRTC bus data and dispatch
No KSRTC live GPS feed or operator dispatch integration is included. The passenger page clearly marks this as pending. Real vehicle tracking requires an authorised KSRTC/VTMS feed, credentials, documented fields, permission to use the data, and an operator-approved dispatch process. Do not use guessed vehicle locations or ETAs. Current booking/cutoff/dispatch logic remains a prototype simulation and is not a real KSRTC booking.

## Fares and destinations
Fares are illustrative demo estimates, not official KSRTC fares. Destination catalogue entries are selectable prototype destinations; operator routes, boarding points, service hours and actual fares require validation.
