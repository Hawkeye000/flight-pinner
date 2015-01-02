Flight Pinner
=============

This application provides a means for users to log airline flights they have taken and see the routes be mapped together.  

Setup
-----
To seed the database, run
```
    $ rake db:migrate
    $ rake db:seed
```
Seeding the database will take a while.Flight data is provided by https://openflights.org and the seed action will validate each data set before saving to the database.  

Application
-----------
Once seeded, the sign up as a user and you can either search directly with an IATA/FAA airport code and Airline, or browse by looking through the index of Airports or Airlines.  

The user view will provide stats on the total miles flown and the unique countries visited.  

Deployment
----------
This application is not deployed as its database size exceeds the hobby dev size allowed by Heroku, however it is configured to use SQLite in development and Postgres in Production so it may be easily deployed to Heroku.  
