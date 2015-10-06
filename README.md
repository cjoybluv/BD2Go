# BD2Go

###next steps: 8/2/2015:

*   add note (no cust);  add customer
*   on note.history & index note-block.  >>  add Note/Task/Appt icons
*   get geoCoder Gem install,  add independent Where_Search with pin
    *   and add.Location,  new Model, location placeName, address, latlng, marker-icon, [customer_id], location_type="Primary"
    *   refit customer to has_many :locations
    *   refit customer to has_many :contacts, new Model: name, phone, email, [location], [customer_id], contact_type="Primary"
*  set Task/Appt to has_many(or none)  :contacts,  1-1(0): location
*  company preferences, branding,
*  sysParam:  model,  id,  codes (backslash-del), descriptions (backslash-del)
*  fileLoader gem for Rails,  load Customer, Contacts, locations, company.logo

*   **SANDBOX geoCoder w/ nifty:scaffold Location RailsCast #273 in BOG_APP**
