/*
SIROM 
(c) Dimiter Prodanov 2020
*/


/*
creating the database structure
*/

/*table matching the file ECDC structure */
CREATE TABLE corona(
  "dateRep" TEXT,
  "day" INTEGER,
  "month" INTEGER,
  "year" INTEGER,
  "cases" INTEGER,
  "deaths" INTEGER,
  "countriesAndTerritories" TEXT,
  "geoId" TEXT,
  "countryterritoryCode" TEXT,
  "popData2018" INTEGER,
  "continentExp" TEXT
);

/* cases and deaths table */
CREATE TABLE coronalite(
  "dateRep" TEXT,
  "day" INTEGER,
  "month" INTEGER,
  "year" INTEGER,
  "cases" INTEGER,
  "deaths" INTEGER,
  "geoId" TEXT,
  "popData2018" INTEGER,
  PRIMARY KEY (dateRep, geoId) ON CONFLICT IGNORE
);
 

CREATE INDEX cnt1 ON coronalite(geoId);
CREATE INDEX date1 ON coronalite(day, month, year);

INSERT INTO coronalite SELECT dateRep, day, month, year, cases, deaths, geoId, popData2018 FROM corona;

/* auxilliary table table */
CREATE TABLE countries (
 "geoId" TEXT,
  "countryterritoryCode" TEXT,
  "countriesAndTerritories" TEXT,
   PRIMARY KEY (geoId)
);

/*
data fitting
*/

CREATE TABLE datafit(
  "fid", PRIMARY KEY,
  "geoId" TEXT,
  "varname" TEXT,
  "shape" REAL,
  "height" REAL,
  "center" REAL,
  "scaling" REAL,
  "timef" REAL
);

/*
importing the ECDC data file
*/
.mode csv
.import download16Dec.csv corona


INSERT INTO countries SELECT DISTINCT geoId, countryterritoryCode, countriesAndTerritories FROM corona;

/*
saving the data on disk
*/
.backup main  corona.db

