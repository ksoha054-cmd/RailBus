# RailBus password-login update

## Passenger account flow
- Register with name, email address, and a RailBus password (minimum 8 characters).
- Log in with the same email address and password.
- Use the Passenger header button to log out.
- Email OTP and Gmail SMTP setup are not required for passenger registration/login.
- Passenger bookings and ticket lookup are associated with the account email.

## Local run
1. Extract the ZIP.
2. Run `START_RAILBUS.bat`.
3. Open `http://localhost:3000/passenger/`.
4. Choose Register / Log in, create an account, then log out and log in again to test.

## Important prototype limitations
- Passwords are stored as salted scrypt hashes, never as plain text.
- This version keeps the existing JSON-file database and prototype-style browser login state. It is suitable for local hackathon testing only, not production or public deployment as-is.
- Before independent hosting, add server-side authenticated sessions and rate limiting, move account/booking data to a persistent database, and use HTTPS.
- Forgot-password email reset is not included in this update.
- Admin and Conductor login flows are unchanged.
