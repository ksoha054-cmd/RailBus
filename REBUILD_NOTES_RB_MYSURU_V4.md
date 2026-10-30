# RailBus rebuild — RB-MYSURU-2026.11.01

## What is included
- Passenger light-mode contrast rules scoped to `body.light`; the existing dark theme palette is unchanged.
- Passenger train and destination autocomplete suggestions; choose a suggestion to set the selected train/destination.
- 12-hour AM/PM display and preferred-time entry.
- 73 Mysuru destination entries and 42 train timetable entries from the local prototype catalogue.
- Weather fetched from Open-Meteo through the backend.
- Admin recurring station-connection demo plan (36 half-hour slots), explicitly marked DEMO / NOT KSRTC LIVE DATA.
- Conductor camera scanner using BarcodeDetector where supported and jsQR fallback; manual code validation remains available.
- Bus-number/PIN conductor login and demo tickets via Admin → Load demo tickets.
- Admin and Conductor use the same RailBus illustration asset as Passenger.

## Run the correct build
1. Stop any old server with Ctrl+C.
2. Extract this ZIP to a NEW folder.
3. Run `START_RAILBUS.bat` from the extracted root.
4. Confirm each page footer/header displays build `RB-MYSURU-2026.11.01`.
5. Hard refresh each browser tab with Ctrl+Shift+R.

## URLs
- Passenger: http://localhost:3000/passenger/
- Admin: http://localhost:3000/admin/
- Conductor: http://localhost:3000/conductor/

## Data honesty / integration limits
- The RailBus recurring timetable is generated demonstration data, not a KSRTC schedule.
- Fares remain illustrative; no official KSRTC fare API is configured. Use https://ksrtc.in/ for reserved intercity services/fares and the Mysuru MITRA portal (http://mitra.ksrtc.in/MysoreMBus/index_e.jsp) for city-bus information. The MITRA portal returned a gateway error during this build, so no live Mysuru ITS feed could be verified or integrated.
- Weather is live from Open-Meteo when internet is available.
- Train live status requires an optional RailRadar key in `.env`; without it the app shows timetable snapshots.
- Bus GPS, real KSRTC dispatch and real payments are not integrated.
- QR camera needs localhost/HTTPS and camera permission. If browser decoding support or CDN jsQR is unavailable, manual ticket-code entry works.
- Demo conductor logins: MYS-RB-001 / 1234 and MYS-RB-002 / 1234 after using Admin → Load demo tickets.
