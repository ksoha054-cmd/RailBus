# RailBus account, ticket priority and boarding workflow

Build: RB-ACCOUNT-TICKETS-LIGHTMODE-2026.10.31

## Passenger
- The header account button is the sign-in/sign-out control.
- After OTP verification, the button identifies the signed-in account.
- Selecting it while signed in signs out, clears the local passenger session, and returns ticket area to the signed-out state. The passenger can sign in again using OTP.
- The My Confirmed Tickets section sorts CONFIRMED first, then BOARDED, then pending/unavailable.
- A QR code is displayed for CONFIRMED tickets only. Passenger shows this QR to the conductor.
- Ticket card is simplified to destination, passenger/seats, ticket code, bus, bus code, date and departure time.

## Conductor
- After bus-number/PIN sign-in, a Sign out of this bus control appears.
- Sign-out stops the camera, invalidates the backend session token, clears the browser session and returns to the login form.
- Another conductor can sign in with their assigned bus number and PIN.
- Ticket register sorts CONFIRMED tickets first, then BOARDED.
- Conductor scans the QR shown by the passenger, or enters the ticket code manually.
- Backend validates ticket status and assigned bus. A ticket cannot be boarded twice.

## Light mode
- Added explicit readable dark text for Admin and Conductor cards, labels, tables, forms, notices and ticket lists when `body.light` is active.
- Dark-mode palette and rules are not changed.

## Validation performed
- `node --check` passed for passenger, admin, conductor, shared and backend JavaScript.
- Backend smoke test: conductor login succeeded; logout succeeded; previously issued token was rejected with HTTP 401 after logout.
- Full browser visual test and physical camera test were not available in this build step.


## Passenger ticket preview update (31 Oct 2026)

The My Tickets / Confirmed Tickets section is placed immediately below the passenger dashboard near the top of the page. Confirmed tickets sort before boarded, pending, and other statuses. A confirmed ticket is rendered as a boarding-ticket preview with a larger QR code and the ticket code, destination, passenger/seat count, bus label, bus code, journey date, and departure time. The QR payload is intended for conductor-side validation. Pending tickets do not show a valid boarding QR.
