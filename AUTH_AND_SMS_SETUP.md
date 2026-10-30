# RailBus email OTP setup

Passenger registration requires both a 10-digit mobile number and an email address. RailBus sends a six-digit OTP to that email address; the code expires after 10 minutes and is limited to five verification attempts. The code is never returned to the browser.

## Configure free Gmail SMTP sending
1. Sign in to the Gmail account that RailBus will send from.
2. Enable Google 2-Step Verification: https://myaccount.google.com/signinoptions/two-step-verification
3. Create an App Password: https://myaccount.google.com/apppasswords
4. Open the project-root `.env` file (copy `.env.example` to `.env` if needed) and set:

```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=465
SMTP_USER=yourgmail@gmail.com
SMTP_PASS=your16characterapppassword
SMTP_FROM=yourgmail@gmail.com
```

Use the 16-character App Password, not your normal Gmail password. Keep `.env` private and never commit or share it. Restart RailBus after changing it.

Gmail's free sending is subject to Google's account limits and anti-abuse controls; it is suitable for a prototype, not a guaranteed high-volume production service. Email OTP will not work until valid SMTP settings are configured.


## Email OTP configuration correction
Create `.env` in the main project folder (same level as `START_RAILBUS.bat`) or `backend/.env`. The updated backend reads both locations. Use your Gmail address for both `SMTP_USER` and `SMTP_FROM`, and the 16-character Google App Password for `SMTP_PASS`. Do not use your regular Gmail password. Restart the server after editing.
