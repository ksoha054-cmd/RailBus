# RAILBUS — Round 2 + Round 3 Cumulative Presentation Pack

**Project:** RailBus — demand-responsive last-mile bus pooling from Mysuru Junction  
**Tagline:** ರೈಲಿನಿಂದ ನಿಮ್ಮ ಗಮ್ಯಸ್ಥಾನಕ್ಕೆ | From rail to your destination  
**Build:** Three role-specific applications, one shared backend

## 1. 60-second problem statement

Passengers arriving at Mysuru Junction often need onward transport to different city destinations. Individual passengers may face uncertainty about onward availability, cost and coordination. At the same time, a bus operator may not have a consolidated view of demand arriving from multiple trains. RailBus proposes a demand-aggregation layer: passengers select their train and destination, the system pools people travelling to the same destination in a common arrival window, and operations staff allocate bus capacity when sufficient demand is reached.

## 2. Proposed solution and novelty

- Pool demand by **destination + 30-minute train-arrival slot**, not by train number. People arriving on different trains can be grouped when their arrival windows overlap.
- Display the current number of opted-in seats before a passenger commits.
- Hold the payment state as `PROCESSING_HOLD`; at the cutoff, 20 or more seats changes it to `CONFIRMED`. Fewer than 20 changes it to `CANCELLED_REFUND_REQUIRED`.
- Split demand across assumed 40-seat buses. Admin can reassign a dispatch to an alternate bus label.
- Passenger, Admin and Conductor have separate front ends but share the same API and data store.
- Conductor validation accepts only confirmed ticket codes and rejects duplicate boarding.
- English/Kannada interface, light/dark themes and weather-aware visual palette.

## 3. Round 2 — Design & Proof of Concept (15 marks)

### Architecture

`Passenger Web App ─┐`  
`Admin Web App ─────┼── HTTP REST API (Node.js) ── Shared JSON database`  
`Conductor Web App ─┘`

Backend services: train catalogue/live-status adapter, weather adapter, route catalogue, booking and demand aggregation, cutoff/payment-state engine, dispatch allocation/reassignment, ticket validation.

### Technology selection

- Front end: HTML5, CSS3, vanilla JavaScript; responsive browser applications.
- Backend: Node.js built-in HTTP, filesystem and crypto modules; no npm dependencies.
- Prototype persistence: JSON file. Production recommendation: PostgreSQL/SQLite with transactions and backups.
- Railway status: optional server-side RailRadar third-party adapter, requiring a private API key. Timetable snapshots remain clearly distinguished from live running status. Verify journeys with official NTES.
- Weather: Open-Meteo current-weather endpoint for Mysuru; adapter reports unavailable rather than inventing weather if network/provider fails.
- QR: QRCodeJS browser library; secure ticket-code validation is performed by backend.

### Data and resource suitability

- Train timetable snapshot for Mysuru Junction; it is not a promise of live running data.
- 40 Mysuru destination records with illustrative prototype fares. Fares are not official KSRTC tariffs.
- Demand, booking and dispatch records persist in one shared JSON database.
- Threshold 20 seats, 30-minute grouping window and 40-seat bus capacity are prototype assumptions for evaluation, not approved KSRTC policy.

### POC proof

1. Passenger booking writes to shared backend.
2. Admin sees the booking and group count without refreshing a separate database.
3. At 20+ seats, cutoff confirms booking and creates a ticket code.
4. Below 20, cutoff cancels the booking/payment state.
5. Conductor validates the confirmed code once; a second validation is rejected.
6. Dispatch allocation creates additional buses for demand above 40 seats; admin can reassign a bus.

### Round 2 execution / task split

| Role | Responsibility | Deliverable |
|---|---|---|
| Member 1 | Passenger experience, destination selection, booking and demand display | Passenger app |
| Member 2 | Admin dashboard, cutoff, payment state and bus balancing | Admin app |
| Member 3 | Conductor ticket validation and boarding register | Conductor app |
| Member 4 | Shared API, train/weather adapters, data, integration and test | Backend + integration |

## 4. Round 3 — Development Progress Review (25 marks)

### Implemented

- Three independent role URLs backed by one Node server.
- Shared REST endpoints for trains, routes, live-status, live-board, weather, bookings, demand, dispatches, cutoff, rebalance and conductor validation.
- Route + arrival-slot demand pooling.
- Pending payment hold, threshold confirmation and below-threshold cancellation state.
- Ticket code creation and one-time boarding validation.
- Capacity-aware dispatch splitting (40 assumed seats per bus) and manual admin reassignment.
- Mysuru destination catalogue (40 locations), bilingual-ready interface, theme toggle and weather-driven page palette.
- Auto-refresh of train board, demand and booking information in the browser.

### Testing checklist / evidence to demonstrate

| Test | Steps | Expected result |
|---|---|---|
| Shared backend | Book from Passenger; open Admin | Same booking appears |
| Pooling | Book same route/slot using different train numbers | Seats aggregate in one group |
| Threshold pass | Create 20+ seats; run cutoff | CONFIRMED + ticket code |
| Threshold fail | Create fewer than 20; run cutoff | UNAVAILABLE + CANCELLED_REFUND_REQUIRED |
| Capacity | Create more than 40 confirmed seats | Multiple dispatch records, each <=40 |
| Bus reassignment | Admin clicks Move bus | Dispatch label changes and status RESCHEDULED |
| Ticket validation | Validate confirmed code twice | First succeeds; second is rejected |
| Theme/language | Toggle theme and Kannada | Theme and language preferences apply |
| Provider fallback | Remove API key / disable provider | No fabricated LIVE label; timetable/unavailable state shown |

## 5. Demo script (6–8 minutes)

1. **Passenger (90 sec):** select train and destination; show visible opted-in seat count; make a booking; point out `PROCESSING_HOLD`.
2. **Admin (2 min):** show same booking in demand dashboard; add 18 demo pledges to bring a one-seat booking to 19 or use the 20+ test; run cutoff; show confirmation/cancellation; show dispatch list and Move bus.
3. **Conductor (60 sec):** enter ticket code; show accepted boarding; repeat it and show duplicate rejection.
4. **Shared-data proof (30 sec):** explain all three apps use one backend and one database.
5. **Weather / live data (60 sec):** show live-weather tile when network is available; show railway live-feed state. Explain the API-key requirement and fallback honestly.
6. **Close (30 sec):** highlight the differentiated value: train-agnostic demand pooling, visible demand, threshold-based payment decision and balanced fleet allocation.

## 6. What is not yet production-ready (say this transparently)

- No real payment gateway is connected. Payment status is simulated; `CANCELLED_REFUND_REQUIRED` is a workflow state, not an actual bank refund. A gateway integration and verified refund webhook are required before taking money.
- Live train running data requires a valid provider API key and terms-compliant access. Without it, the app shows timetable-only / unavailable. Confirm critical journey data through NTES.
- Live bus GPS/ETA is not connected. Bus dispatch records are allocation records, not GPS telemetry. A KSRTC-authorised ITS/GPS feed is required for actual bus location and delay.
- Weather uses Open-Meteo and may be unavailable if network access is blocked. The interface does not invent weather readings.
- No production authentication, payment security, role permissions, concurrency controls, or cloud hosting. JSON persistence is for a small demonstration only.
- Operating assumptions (20-seat threshold, 30-minute window, 40-seat bus) need validation with KSRTC and station stakeholders.

## 7. Expected impact and validation plan

Measure: demand conversion by route, percentage of groups reaching threshold, average wait from train arrival to bus departure, seat utilisation, cancellation rate, on-time departure, passenger satisfaction and dispatch balancing frequency. Validate through passenger interviews, station observation, sample arrival windows and operator feedback. Do not claim measured savings until field trials are completed.

## 8. Closing pitch

“RailBus turns scattered train arrivals into visible, pooled last-mile demand. Passengers see how many people are travelling their way; operations staff can confirm demand, allocate capacity and avoid sending an under-filled bus. Three simple role-based apps, one shared backend — ರೈಲಿನಿಂದ ನಿಮ್ಮ ಗಮ್ಯಸ್ಥಾನಕ್ಕೆ.”
