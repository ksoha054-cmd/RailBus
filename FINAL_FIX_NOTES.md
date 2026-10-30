# RailBus final passenger fixes

## Fixes
- Passenger logo and train/bus SVG are referenced relative to `/passenger/`, so the static server resolves both assets from the correct folder.
- Removed the NTES verification sentence from the passenger homepage.
- Train board now combines the full local timetable catalogue with any live provider rows. Live rows replace matching timetable entries; the remaining timetable entries stay visible and are labelled TIMETABLE.
- Added a train-board search field and visible count.
- Development OTP is returned to the local browser UI and labelled as a development code. This makes local testing possible without checking the Command Prompt.
- Fixed duplicate passenger/account name field IDs in the sign-in modal.
- Booking now asks the passenger to sign in first.

## Important production limitation
The current OTP mode is development-only. It does not send SMS. Real OTP delivery requires an SMS provider account, approved sender/template where applicable, and server-side credentials. Do not expose those credentials in browser code or commit them to source control.

The train catalogue contains the existing 42 timetable records. Live provider responses are overlaid on that catalogue; the UI does not mislabel timetable-only trains as live. More scheduled trains can be added only from a verified current timetable source. Live tracking coverage depends on what the provider actually returns for MYS.

KSRTC bus GPS and dispatch are not connected. They require an authorised KSRTC/VTMS data feed and operational approval.


## October 2026 — Light theme, operations and ticket confirmation update
- Preserved the existing dark theme; improved light-mode contrast for body text, labels, form controls, tables, badges and cards across all three portals.
- Added animated theme transitions and synchronized theme persistence across Passenger, Admin and Conductor.
- Standardized the RailBus logo asset and header treatment across the three apps.
- Passenger quick navigation now has clear links for booking, train board, destinations and confirmed tickets.
- Latin UI uses Roboto; Kannada uses Nemmadi if installed locally, with Hind Mysuru and Noto Sans Kannada web-font fallbacks. A standard hosted webfont named Nemmadi was not available in the font catalog search.
- Demand groups are separated by destination, journey date and 30-minute arrival slot. The backend now respects the 20-minute pre-slot cutoff. Groups below 20 seats at cutoff become unavailable/refund-required; groups at or above 20 seats are confirmed.
- Confirmed groups receive unique ticket codes and unique bus codes. Bus allocations are limited to the prototype capacity of 40 seats; groups over 40 seats are split across multiple buses.
- Passenger and Admin portals show QR tickets with passenger, destination, journey date, preferred time/slot, ticket code, bus code and bus label. Conductor register displays bus assignment and slot. QR rendering uses QRCode.js from a CDN, so QR images require an internet connection; the unique ticket code remains visible as a fallback.
- Reassigning a bus updates the linked passenger booking records.
- This remains a prototype: payment is simulated, and bus labels/allocations are not real KSRTC dispatches. Real SMS, payments, fleet GPS and operator integration still require authorised services.


## Final layout and email configuration repair (2026-10-31)
- Passenger confirmed ticket panel moved to the first content section immediately below the site header, before hero/weather/booking content.
- Conductor confirmed-ticket boarding-priority table moved to the first content section immediately below the header.
- Backend now reads Gmail SMTP settings from either project-root `.env` or `backend/.env` to avoid the earlier path confusion.
- SMTP configuration now gives a clear error if the app password is not 16 characters or email addresses are malformed.
