# RailBus architecture

Passenger, Admin and Conductor are independent browser applications served by one Node.js process. They call the same REST API at `/api/*`. The backend owns booking aggregation, ticket-code generation, one-time boarding validation, shared database writes, and the optional live train data adapter.

Live train status is fetched server-side from the configured third-party provider and cached for 60 seconds. Provider credentials are read from the root `.env`; they are never sent to browsers. Without credentials the API returns an explicit schedule-only state.

Train pooling key: destination route ID + 30-minute scheduled arrival slot. The prototype uses a 20-seat threshold and 40-seat assumed bus capacity.
