# RailBus Passenger Frontend

## Start
1. Install Node.js LTS.
2. From this folder, run `backend/start.bat` on Windows.
3. Open `http://localhost:3000/passenger/`.

## Passenger UI
- English / Kannada toggle and persistent light / dark mode. Kannada uses the Hind Mysuru typeface (the Mysuru-named Kannada UI font); English uses Space Grotesk for a more contemporary product feel. Fonts load from Google Fonts, so the first visit needs internet access.
- Responsive Mysuru-inspired UI and custom vector RailBus logo.
- Train selection, journey date and editable arrival time.
- Arrival time is converted by the backend into a 30-minute demand slot.
- Route demand count is read from the shared backend and pooled across trains in the same route/slot.
- Fare is explicitly marked as a demo estimate.
- Weather is fetched from Open-Meteo via `/api/weather`.
- Train status uses the backend `/api/live-status` and `/api/live-board` endpoints. The live board calls the RailRadar Mysuru station-board endpoint once for the station instead of firing one request per catalogue train. Results are cached for 5 minutes; the page auto-refreshes the train feed every 15 minutes and offers a manual refresh. A valid provider key is required in `.env` for third-party live data. Without it, the UI clearly shows timetable-only mode.

## Live data truthfulness
- Official Indian Railways live running information is available through NTES. This project uses a third-party RailRadar API adapter, not a direct official NTES API. Verify important information at https://enquiry.indianrail.gov.in/mntes/.
- The passenger page does not invent KSRTC bus GPS or ETA. It shows dispatch information after backend confirmation and indicates that an authorised KSRTC VTMS/GPS feed is not connected. A live bus location/ETA requires an approved data endpoint and credentials.
- Weather changes the hero colour palette based on current Open-Meteo weather code; it does not claim to alter transport operations.
- Payment is simulated. No actual charge or refund is processed.

## Provider key
Copy `.env.example` to `.env` in the project root and set `RAILRADAR_API_KEY` to a valid key obtained from the provider. Never put this key in browser JavaScript or share it publicly.


## Enable live Mysuru train tracking
1. Create an account with RailRadar and obtain your own API key. Check its current plan, monthly request quota, pricing and permitted use before using it in a public demo.
2. Copy `.env.example` to `.env` in the project root (the same folder that contains `backend/` and `passenger/`).
3. Replace the placeholder with `RAILRADAR_API_KEY=your_real_key`. Do not paste the key into the frontend, GitHub, screenshots or chat.
4. Restart `backend/start.bat`, then open `/passenger/` and use **Refresh live** in the Mysuru train board.
5. The backend calls `GET https://api.railradar.in/v1/stations/MYS/live?hours=8` and keeps the key server-side. The station board is cached for 5 minutes. A provider response is marked live; a missing record, future journey date, invalid key, quota limit or provider outage falls back to timetable-only status.

The RailRadar documentation describes the station live-board endpoint and Bearer-key authentication. Its live-status documentation lists a 100-requests/month free sandbox quota, so confirm your actual plan and do not leave rapid polling enabled. The app therefore uses a 15-minute background refresh plus manual refresh, with a 5-minute server cache. Live railway status is third-party data, not an official NTES feed; passengers should verify important changes through NTES.
