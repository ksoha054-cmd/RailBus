# RailBus Moovit route and Admin allocation

Build: RB-MOOVIT-ADMIN-ROUTE-ALLOCATOR-2026.10.30

## What Admin can do
1. Open Admin > "Moovit · Mysuru railway-station bus routes".
2. Select a confirmed RailBus dispatch (demo dispatches are available via Load demo tickets).
3. Select a KSRTC route number listed by Moovit for stops around Mysore Railway Station.
4. Check the live timetable on Moovit, enter the verified departure time, and assign the route.
5. The dispatch and its passenger bookings now carry the selected `service_line`, `service_name`, `departure_time` and Moovit schedule reference. The original RailBus vehicle ID (`bus_label`) remains unchanged so conductor credentials are not silently changed.

## Source data
Route numbers, route corridors, nearby stops and walking distances are based on Moovit's public "How to Get to Mysore Railway Station" page, last updated October 10, 2026. The page lists routes such as 117, 265, 118A, 15, 133, 150, 115, 116, 118, 119, 120, 95 and others. It reports the first nearby bus as route 2R at 5:04 AM and last nearby bus as route 118 at 11:23 PM. Those are overall nearby first/last observations, not per-route departure times.

Moovit route directory: https://moovitapp.com/index/en/public_transit-lines-Mysuru-4082-895898
Railway Station page: https://moovitapp.com/index/en/public_transit-Mysore_Railway_Station-Mysuru-site_27246759-4082

## Important limits
- A route number (e.g. 116) is NOT a vehicle registration / fleet bus number.
- The public Moovit railway-station page lists route numbers and stop proximity but does not expose every route's full departure rows in static page content. Admin must open the linked Moovit page and enter the current departure time shown there.
- RailBus does not scrape Moovit, call undocumented APIs, copy its proprietary full timetable database, or invent live vehicle positions.
- Actual vehicle registration numbers, fleet availability, capacity and GPS positions require an authorised KSRTC/Moovit fleet feed. Until then, RailBus's vehicle IDs and capacities remain prototype dispatch identifiers.
