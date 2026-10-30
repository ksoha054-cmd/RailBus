# RailBus authentication update

Passenger registration and login now use an email address plus a RailBus password. Email OTP and Gmail SMTP configuration are not required for the passenger demo flow. Passwords are stored as salted scrypt hashes, not plain text.

This is a hackathon prototype: use HTTPS when publicly hosted, add rate limiting and server-side authenticated sessions before production, and use a persistent database before deploying to ephemeral hosting. The admin and conductor login flows are unchanged.
