# Project 1: Query Project

- In the Query Project, you will get practice with SQL while learning about
  Google Cloud Platform (GCP) and BiqQuery. You'll answer business-driven
  questions using public datasets housed in GCP. To give you experience with
  different ways to use those datasets, you will use the web UI (BiqQuery) and
  the command-line tools, and work with them in Jupyter Notebooks.

#### Problem Statement

- You're a data scientist at Lyft Bay Wheels (https://www.lyft.com/bikes/bay-wheels), formerly known as Ford GoBike, the
  company running Bay Area Bikeshare. You are trying to increase ridership, and
  you want to offer deals through the mobile app to do so. 
  
- What deals do you offer though? Currently, your company has several options which can change over time.  Please visit the website to see the current offers and other marketing information. Frequent offers include: 
  * Single Ride 
  * Monthly Membership
  * Annual Membership
  * Bike Share for All
  * Access Pass
  * Corporate Membership
  * etc.

- Through this project, you will answer these questions: 

  * What are the 5 most popular trips that you would call "commuter trips"? 
  
  * What are your recommendations for offers (justify based on your findings)?

- Please note that there are no exact answers to the above questions, just like in the proverbial real world.  This is not a simple exercise where each question above will have a simple SQL query. It is an exercise in analytics over inexact and dirty data. 

- You won't find a column in a table labeled "commuter trip".  You will find you need to do quite a bit of data exploration using SQL queries to determine your own definition of a communter trip.  In data exploration process, you will find a lot of dirty data, that you will need to either clean or filter out. You will then write SQL queries to find the communter trips.

- Likewise to make your recommendations, you will need to do data exploration, cleaning or filtering dirty data, etc. to come up with the final queries that will give you the supporting data for your recommendations. You can make any recommendations regarding the offers, including, but not limited to: 
  * market offers differently to generate more revenue 
  * remove offers that are not working 
  * modify exising offers to generate more revenue
  * create new offers for hidden business opportunities you have found
  * etc. 

#### All Work MUST be done in the Google Cloud Platform (GCP) / The Majority of Work MUST be done using BigQuery SQL / Usage of Temporary Tables, Views, Pandas, Data Visualizations

A couple of the goals of w205 are for students to learn how to work in a cloud environment (such as GCP) and how to use SQL against a big data data platform (such as Google BigQuery).  In keeping with these goals, please do all of your work in GCP, and the majority of your analytics work using BigQuery SQL queries.

You can make intermediate temporary tables or views in your own dataset in BigQuery as you like.  Actually, this is a great way to work!  These make data exploration much easier.  It's much easier when you have made temporary tables or views with only clean data, filtered rows, filtered columns, new columns, summary data, etc.  If you use intermediate temporary tables or views, you should include the SQL used to create these, along with a brief note mentioning that you used the temporary table or view.

In the final Jupyter Notebook, the results of your BigQuery SQL will be read into Pandas, where you will use the skills you learned in the Python class to print formatted Pandas tables, simple data visualizations using Seaborn / Matplotlib, etc.  You can use Pandas for simple transformations, but please remember the bulk of work should be done using Google BigQuery SQL.

#### GitHub Procedures

In your Python class you used GitHub, with a single repo for all assignments, where you committed without doing a pull request.  In this class, we will try to mimic the real world more closely, so our procedures will be enhanced. 

Each project, including this one, will have it's own repo.

Important:  In w205, please never merge your assignment branch to the master branch. 

Using the git command line: clone down the repo, leave the master branch untouched, create an assignment branch, and move to that branch:
- Open a linux command line to your virtual machine and be sure you are logged in as jupyter.
- Create a ~/w205 directory if it does not already exist `mkdir ~/w205`
- Change directory into the ~/w205 directory `cd ~/w205`
- Clone down your repo `git clone <https url for your repo>`
- Change directory into the repo `cd <repo name>`
- Create an assignment branch `git branch assignment`
- Checkout the assignment branch `git checkout assignment`

The previous steps only need to be done once.  Once you your clone is on the assignment branch it will remain on that branch unless you checkout another branch.

The project workflow follows this pattern, which may be repeated as many times as needed.  In fact it's best to do this frequently as it saves your work into GitHub in case your virtual machine becomes corrupt:
- Make changes to existing files as needed.
- Add new files as needed
- Stage modified files `git add <filename>`
- Commit staged files `git commit -m "<meaningful comment about your changes>"`
- Push the commit on your assignment branch from your clone to GitHub `git push origin assignment`

Once you are done, go to the GitHub web interface and create a pull request comparing the assignment branch to the master branch.  Add your instructor, and only your instructor, as the reviewer.  The date and time stamp of the pull request is considered the submission time for late penalties. 

If you decide to make more changes after you have created a pull request, you can simply close the pull request (without merge!), make more changes, stage, commit, push, and create a final pull request when you are done.  Note that the last data and time stamp of the last pull request will be considered the submission time for late penalties.

---

## Parts 1, 2, 3

We have broken down this project into 3 parts, about 1 week's work each to help you stay on track.

**You will only turn in the project once  at the end of part 3!**

- In Part 1, we will query using the Google BigQuery GUI interface in the cloud.

- In Part 2, we will query using the Linux command line from our virtual machine in the cloud.

- In Part 3, we will query from a Jupyter Notebook in our virtual machine in the cloud, save the results into Pandas, and present a report enhanced by Pandas output tables and simple data visualizations using Seaborn / Matplotlib.

---

## Part 1 - Querying Data with BigQuery

### SQL Tutorial

Please go through this SQL tutorial to help you learn the basics of SQL to help you complete this project.

SQL tutorial: https://www.w3schools.com/sql/default.asp

### Google Cloud Helpful Links

Read: https://cloud.google.com/docs/overview/

BigQuery: https://cloud.google.com/bigquery/

Public Datasets: Bring up your Google BigQuery console, open the menu for the public datasets, and navigate to the the dataset san_francisco.

- The Bay Bike Share has two datasets: a static one and a dynamic one.  The static one covers an historic period of about 3 years.  The dynamic one updates every 10 minutes or so.  THE STATIC ONE IS THE ONE WE WILL USE IN CLASS AND IN THE PROJECT. The reason is that is much easier to learn SQL against a static target instead of a moving target.

- (USE THESE TABLES!) The static tables we will be using in this class are in the dataset **san_francisco** :

  * bikeshare_stations

  * bikeshare_status

  * bikeshare_trips

- The dynamic tables are found in the dataset **san_francisco_bikeshare**

### Some initial queries

Paste your SQL query and answer the question in a sentence.  Be sure you properly format your queries and results using markdown. 

- What's the size of this dataset? (i.e., how many trips)

  * Answer: 
    * The number of trips are 983648
  * SQL query:
  
```sql
    #standardSQL
    SELECT
      COUNT(*) AS num_trips
    FROM `bigquery-public-data.san_francisco.bikeshare_trips`
```
- What is the earliest start date and time and latest end date and time for a trip?

  * Answer: 
    * Earliest start date and time is 2013-08-29 09:08:00 UTC
    * Latest end date and time is 2016-08-31 23:48:00 UTC
  * SQL query:
  
```sql
    #standardSQL
    SELECT
      min(start_date) AS first_start_date,
      max(end_date) as last_end_date
    FROM `bigquery-public-data.san_francisco.bikeshare_trips`
```

- How many bikes are there?

  * Answer: 
    * The number of bikes available at the time of the last snapshot (2016-08-31 23:58:59 UTC) are 570
  * SQL query:
  
```sql
    #standardSQL
    SELECT
      sum(bikes_available) AS num_bikes,
      max(time) as time_last_snapshot
    FROM `bigquery-public-data.san_francisco.bikeshare_status`
    WHERE time = (select max(time) from `bigquery-public-data.san_francisco.bikeshare_status`)
```


### Questions of your own
- Make up 3 questions and answer them using the Bay Area Bike Share Trips Data.  These questions MUST be different than any of the questions and queries you ran above.

- Question 1: What station saw the most unique throughput of bikes, and how many?
  * Answer:
    * San Francisco Caltrain (Townsend at 4th) saw 517 unique bikes go through in the three years captured
  * SQL query:
  
```sql
    #standardSQL
    SELECT station_id, name, (SELECT count(*) FROM (SELECT DISTINCT station_id, bike_id
                                          FROM
                                          (SELECT
                                            start_station_id as station_id, 
                                            bike_number as bike_id
                                          FROM
                                            `bigquery-public-data.san_francisco.bikeshare_trips`
                                          UNION ALL
                                          SELECT
                                            end_station_id as station_id, 
                                            bike_number as bike_id
                                          FROM
                                            `bigquery-public-data.san_francisco.bikeshare_trips`)) as station_bikes
                                   WHERE station_bikes.station_id = a.station_id) as num_unique_bikes
    FROM `bigquery-public-data.san_francisco.bikeshare_stations` a
    GROUP BY station_id, name
    ORDER BY num_unique_bikes DESC
    LIMIT 1
```

- Question 2: What station saw the least unique throughput of bikes, and how many?
  * Answer:
    * 5th S. at E. San Salvador St only saw 28 unique bikes in the 3 years captured
  * SQL query:
```sql
    #standardSQL
    SELECT station_id, name, (SELECT count(*) FROM (SELECT DISTINCT station_id, bike_id
                                          FROM
                                          (SELECT
                                            start_station_id as station_id, 
                                            bike_number as bike_id
                                          FROM
                                            `bigquery-public-data.san_francisco.bikeshare_trips`
                                          UNION ALL
                                          SELECT
                                            end_station_id as station_id, 
                                            bike_number as bike_id
                                          FROM
                                            `bigquery-public-data.san_francisco.bikeshare_trips`)) as station_bikes
                                   WHERE station_bikes.station_id = a.station_id) as num_unique_bikes
    FROM `bigquery-public-data.san_francisco.bikeshare_stations` a
    GROUP BY station_id, name
    ORDER BY num_unique_bikes ASC
    LIMIT 1
```


- Question 3: What was the installation date for the station with the least amount of unique bike throughput?
  * Answer:
      * The installation date for 5th S. at E. San Salvador St was 2016-06-05. Only 3 months worth of activity. No wonder!
  * SQL query:
```sql
    #standardSQL
    SELECT stations.station_id, stations.name, stations.installation_date
    FROM `bigquery-public-data.san_francisco.bikeshare_stations` stations,
    (SELECT station_id, name, (SELECT count(*) FROM (SELECT DISTINCT station_id, bike_id
                                              FROM
                                              (SELECT
                                                start_station_id as station_id, 
                                                bike_number as bike_id
                                              FROM
                                                `bigquery-public-data.san_francisco.bikeshare_trips`
                                              UNION ALL
                                              SELECT
                                                end_station_id as station_id, 
                                                bike_number as bike_id
                                              FROM
                                                `bigquery-public-data.san_francisco.bikeshare_trips`)) as station_bikes
                                       WHERE station_bikes.station_id = a.station_id) as num_unique_bikes
        FROM `bigquery-public-data.san_francisco.bikeshare_stations` a
        GROUP BY station_id, name
        ORDER BY num_unique_bikes ASC
        LIMIT 1) b
    WHERE stations.station_id = b.station_id
```


### Bonus activity queries (optional - not graded - just this section is optional, all other sections are required)

The bike share dynamic dataset offers multiple tables that can be joined to learn more interesting facts about the bike share business across all regions. These advanced queries are designed to challenge you to explore the other tables, using only the available metadata to create views that give you a broader understanding of the overall volumes across the regions(each region has multiple stations)

We can create a temporary table or view against the dynamic dataset to join to our static dataset.

Here is some SQL to pull the region_id and station_id from the dynamic dataset.  You can save the results of this query to a temporary table or view.  You can then join the static tables to this table or view to find the region:
```sql
#standardSQL
select distinct region_id, station_id
from `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info`
```

- Top 5 popular station pairs in each region

- Top 3 most popular regions(stations belong within 1 region)

- Total trips for each short station name in each region

- What are the top 10 used bikes in each of the top 3 region. these bikes could be in need of more frequent maintenance.

---

## Part 2 - Querying data from the BigQuery CLI 

- Use BQ from the Linux command line:

  * General query structure

    ```
    bq query --use_legacy_sql=false '
        SELECT count(*)
        FROM
           `bigquery-public-data.san_francisco.bikeshare_trips`'
    ```

### Queries

1. Rerun the first 3 queries from Part 1 using bq command line tool (Paste your bq
   queries and results here, using properly formatted markdown):

  * What's the size of this dataset? (i.e., how many trips)

    * Answer: 
      * The number of trips are 983648
    * SQL query:

```
        bq query --use_legacy_sql=false '
        SELECT
          COUNT(*) AS num_trips
        FROM `bigquery-public-data.san_francisco.bikeshare_trips`'
```

   * What is the earliest start time and latest end time for a trip?
    
      * Answer: 
        * Earliest start date and time is 2013-08-29 09:08:00 UTC
        * Latest end date and time is 2016-08-31 23:48:00 UTC
      * SQL query:

```
        bq query --use_legacy_sql=false '
         SELECT
          min(start_date) AS first_start_date,
          max(end_date) as last_end_date
        FROM `bigquery-public-data.san_francisco.bikeshare_trips`'
```

   * How many bikes are there?
     * Answer: 
       * The number of bikes available at the time of the last snapshot (2016-08-31 23:58:59 UTC) are 570
     * SQL query:
  
```
       bq query --use_legacy_sql=false '
        SELECT
          sum(bikes_available) AS num_bikes,
          max(time) as time_last_snapshot
        FROM `bigquery-public-data.san_francisco.bikeshare_status`
        WHERE time = (select max(time) from `bigquery-public-data.san_francisco.bikeshare_status`)'
```

2. New Query (Run using bq and paste your SQL query and answer the question in a sentence, using properly formatted markdown):

  * How many trips are in the morning vs in the afternoon?
     * Answer: 
       * The number of trips in the morning (6am-12pm) are 426252
       * The number of trips in the afternoon (12pm-6pm) are 428818
     * SQL query:
  
```
       bq query --use_legacy_sql=false '
        SELECT
              CASE 
                   WHEN EXTRACT(HOUR FROM start_date) > 6 and EXTRACT(HOUR FROM start_date) <= 12 THEN "Morning"
                   WHEN EXTRACT(HOUR FROM start_date) > 12 and EXTRACT(HOUR FROM start_date) <= 18 THEN "Afternoon"
                   ELSE "Other"
              END AS start_hour_str,
              COUNT(*) as num_trips
        FROM `bigquery-public-data.san_francisco.bikeshare_trips`
        GROUP BY start_hour_str'
```



### Project Questions
Identify the main questions you'll need to answer to make recommendations (list below, add as many questions as you need).


- Question 1: What are the 5 most popular bike trips during commuter time periods?

- Question 2: How long is the average trip?

- Question 3: Calculate the average weekly ride volume between stations since the route became active. What regions have the top 5 highest and top 5 lowest number of weekly riders?

- Question 4: Calculate the average, shortest and longest trip from station to station. What are the top 5 stations that have the shortest trips (on average) where the number of trips per week are > 40 and the station connection has been active for *more than 16 weeks*?

- Question 5: What are the 5 most popular bike trips for station connections that have been active for *less than 16 weeks*?

- Question 6: Calculate the utilization rate for stations in terms of capacity and availability. Which 5 stations are least utilized by time of day (excluding Evenings and Nightime)?


### Answers

Answer at least 4 of the questions you identified above You can use either
BigQuery or the bq command line tool.  Paste your questions, queries and
answers below.

- Question 1: What are the 5 most popular bike trips during commuter time periods?
  * Answer:
  
```
+------------------------------------------+-----------------------------------------------+----------------+------------------+--------------------+----------------------+
|            start_station_name            |               end_station_name                | start_hour_str | average_duration |   trips_per_week   | weeks_station_active |
+------------------------------------------+-----------------------------------------------+----------------+------------------+--------------------+----------------------+
| Harry Bridges Plaza (Ferry Building)     | 2nd at Townsend                               | Morning        |         00:09:35 | 25.088607594936708 |                  158 |
| San Francisco Caltrain (Townsend at 4th) | Temporary Transbay Terminal (Howard at Beale) | Morning        |         00:11:23 | 19.196202531645568 |                  158 |
| Embarcadero at Sansome                   | Steuart at Market                             | Afternoon      |         00:07:28 | 18.645569620253166 |                  158 |
| 2nd at South Park                        | Market at Sansome                             | Afternoon      |         00:07:34 | 18.544303797468356 |                  158 |
| San Francisco Caltrain (Townsend at 4th) | Embarcadero at Folsom                         | Morning        |         00:10:24 | 18.132911392405063 |                  158 |
+------------------------------------------+-----------------------------------------------+----------------+------------------+--------------------+----------------------+```
  * SQL query:
```
     bq query --use_legacy_sql=false '
     SELECT  start_station_name,
             end_station_name,
             start_hour_str,
             TIME_ADD(TIME "00:00:00", interval (CAST(AVG(trips.duration_sec) AS INT64)) SECOND) as average_duration,
             COUNT(*) / routes.num_weeks as trips_per_week,
             routes.num_weeks as weeks_station_active
       FROM `ambient-fuze-257001.bike_trip_data.trips` trips,
            `ambient-fuze-257001.bike_trip_data.station_routes` routes
      WHERE  routes.start_station_id = trips.start_station_id AND
             routes.end_station_id = trips.end_station_id AND
             start_hour_str in ("Morning", "Afternoon") AND
             dow_weekday = "Weekday"
    GROUP BY start_station_name, end_station_name, start_hour_str, num_weeks
    ORDER BY trips_per_week DESC
      LIMIT 5'
```

View for trips

```sql
SELECT trip_id, 
       start_date,
       EXTRACT(ISOYEAR from start_date) as year,
       EXTRACT(ISOWEEK from start_date) as week,
       EXTRACT(DAYOFWEEK FROM start_date) AS dow_int,
       CASE EXTRACT(DAYOFWEEK FROM start_date)
           WHEN 1 THEN "Sunday"
           WHEN 2 THEN "Monday"
           WHEN 3 THEN "Tuesday"
           WHEN 4 THEN "Wednesday"
           WHEN 5 THEN "Thursday"
           WHEN 6 THEN "Friday"
           WHEN 7 THEN "Saturday"
           END AS dow_str,
       CASE 
           WHEN EXTRACT(DAYOFWEEK FROM start_date) IN (1, 7) THEN "Weekend"
           ELSE "Weekday"
           END AS dow_weekday,
       EXTRACT(HOUR FROM start_date) AS start_hour,
       duration_sec, 
       CAST(ROUND(duration_sec / 60.0) AS INT64) AS duration_minutes,
       CAST(ROUND(duration_sec / 3600.0) AS INT64) AS duration_hours_rounded,
       ROUND(duration_sec / 3600.0, 1) AS duration_hours_tenths,
       CASE 
           WHEN EXTRACT(HOUR FROM start_date) <= 5  OR EXTRACT(HOUR FROM start_date) >= 23 THEN "Nightime"
           WHEN EXTRACT(HOUR FROM start_date) >= 6 and EXTRACT(HOUR FROM start_date) <= 8 THEN "Morning"
           WHEN EXTRACT(HOUR FROM start_date) >= 9 and EXTRACT(HOUR FROM start_date) <= 10 THEN "Mid Morning"
           WHEN EXTRACT(HOUR FROM start_date) >= 11 and EXTRACT(HOUR FROM start_date) <= 13 THEN "Mid Day"
           WHEN EXTRACT(HOUR FROM start_date) >= 14 and EXTRACT(HOUR FROM start_date) <= 16 THEN "Early Afternoon"
           WHEN EXTRACT(HOUR FROM start_date) >= 17 and EXTRACT(HOUR FROM start_date) <= 19 THEN "Afternoon"
           WHEN EXTRACT(HOUR FROM start_date) >= 20 and EXTRACT(HOUR FROM start_date) <= 22 THEN "Evening"
           END AS start_hour_str,
      start_station_id,
      start_station.name as start_station_name,
      end_station_id,
      end_station.name as end_station_name,
      bike_number,
      zip_code,
      subscriber_type
FROM `bigquery-public-data.san_francisco.bikeshare_trips` trips,
     `bigquery-public-data.san_francisco.bikeshare_stations` start_station,
     `bigquery-public-data.san_francisco.bikeshare_stations` end_station
WHERE trips.start_station_id = start_station.station_id AND
      trips.end_station_id = end_station.station_id
ORDER BY start_date ASC
```

- Question 2: How long is the average trip?
  * Answer:
  
```
+-----------------------+
| average_duration_time |
+-----------------------+
|              00:16:59 |
+-----------------------+
```
  * SQL query:
```
     bq query --use_legacy_sql=false '
     SELECT TIME_ADD(TIME "00:00:00", interval (CAST(AVG(duration_sec) AS INT64)) SECOND) as average_duration_time
       FROM `bigquery-public-data.san_francisco.bikeshare_trips`'
```
      
- Question 3: Calculate the average weekly ride volume between stations since the route became active. What regions have the top 5 highest and top 5 lowest number of weekly riders?
  * Answer:
  
```
+---------------------------------+-----------------------------------------------+------------------------+----------------------+
|       start_station_name        |               end_station_name                | num_weeks_route_active |    trips_per_week    |
+---------------------------------+-----------------------------------------------+------------------------+----------------------+
| Grant Avenue at Columbus Avenue | Market at Sansome                             |                     16 |             197.0625 |
| Grant Avenue at Columbus Avenue | Embarcadero at Folsom                         |                     16 |                100.5 |
| Grant Avenue at Columbus Avenue | San Francisco Caltrain (Townsend at 4th)      |                     16 |               97.875 |
| Market at Sansome               | Grant Avenue at Columbus Avenue               |                     16 |              80.0625 |
| Grant Avenue at Columbus Avenue | Temporary Transbay Terminal (Howard at Beale) |                     16 |              73.6875 |
| Paseo de San Antonio            | Market at 4th                                 |                    158 | 0.006329113924050633 |
| Mountain View Caltrain Station  | Japantown                                     |                    158 | 0.006329113924050633 |
| Mountain View City Hall         | 5th at Howard                                 |                    158 | 0.006329113924050633 |
| San Mateo County Center         | Park at Olive                                 |                    158 | 0.006329113924050633 |
| MLK Library                     | Market at 4th                                 |                    158 | 0.006329113924050633 |
+---------------------------------+-----------------------------------------------+------------------------+----------------------+
```
  * SQL query:
  
```
     bq query --use_legacy_sql=false ' 
  (SELECT trips.start_station_name,
          trips.end_station_name,
          routes.num_weeks as num_weeks_route_active,
          trips.num_trips / routes.num_weeks as trips_per_week
     FROM `ambient-fuze-257001.bike_trip_data.route_trips` trips,
          `ambient-fuze-257001.bike_trip_data.station_routes` routes
     WHERE routes.start_station_id = trips.start_station_id AND
           routes.end_station_id = trips.end_station_id
  ORDER BY trips_per_week ASC
     LIMIT 5)
 UNION ALL
  (SELECT trips.start_station_name,
          trips.end_station_name,
          routes.num_weeks as num_weeks_route_active,
          trips.num_trips / routes.num_weeks as trips_per_week
     FROM `ambient-fuze-257001.bike_trip_data.route_trips` trips,
          `ambient-fuze-257001.bike_trip_data.station_routes` routes
     WHERE routes.start_station_id = trips.start_station_id AND
           routes.end_station_id = trips.end_station_id
  ORDER BY trips_per_week DESC
     LIMIT 5)'
```

View for route_trips

```sql
    #standardSQL
       SELECT trips.start_station_id,
          trips.start_station_name,
          trips.end_station_id,
          trips.end_station_name,
          count(*) as num_trips
      FROM `ambient-fuze-257001.bike_trip_data.trips` trips
  GROUP BY trips.start_station_id,
           trips.start_station_name,
           trips.end_station_id,
           trips.end_station_name
  ORDER BY num_trips ASC
```

View for station_routes

```sql
    #standardSQL
   SELECT start_station_weeks.station_id as start_station_id,
          end_station_weeks.station_id as end_station_id,
          count(*) as num_weeks
     FROM `ambient-fuze-257001.bike_trip_data.station_weeks` start_station_weeks,
          `ambient-fuze-257001.bike_trip_data.station_weeks` end_station_weeks
    WHERE start_station_weeks.year = end_station_weeks.year AND
          start_station_weeks.week = end_station_weeks.week
 GROUP BY start_station_id, end_station_id
```

View for station_weeks

```sql
    #standardSQL
  SELECT DISTINCT
         station.station_id,
         station.name,
         EXTRACT(ISOYEAR from calendar_day) as year,
         EXTRACT(ISOWEEK from calendar_day) as week
    FROM (SELECT *
            FROM UNNEST(GENERATE_DATE_ARRAY(EXTRACT(DATE FROM (SELECT MIN(time)
                                                                 FROM `bigquery-public-data.san_francisco.bikeshare_status` status
                                                               WHERE status.station_id = station_id)),
                                            EXTRACT(DATE FROM (SELECT MAX(time)
                                                                 FROM `bigquery-public-data.san_francisco.bikeshare_status` status
                                                                WHERE status.station_id = station_id)),
                                            INTERVAL 1 DAY)) AS calendar_day),
        `bigquery-public-data.san_francisco.bikeshare_stations` station
 #' installation_date not accurate! Changing to subquery earliest trip time from the station. '
 # 'WHERE calendar_day > station.installation_date '
 WHERE  calendar_day > (Select EXTRACT(DATE from min(start_date)) from `bigquery-public-data.san_francisco.bikeshare_trips` trips where trips.start_station_id = station.station_id)
 ORDER BY station.station_id, station.name, year, week
```


- Question 4: Calculate the average, shortest and longest trip from station to station. What are the top 5 stations that have the shortest trips (on average) where the number of trips per week are > 40 and the station connection has been active for more than 16 weeks?
  * Answer:
  
```
+-----------------------------------------+-----------------------------------------+------------------+-------------------+------------------+--------------------+------------------------+
|           start_station_name            |            end_station_name             | average_duration | shortest_duration | longest_duration |   trips_per_week   | num_weeks_route_active |
+-----------------------------------------+-----------------------------------------+------------------+-------------------+------------------+--------------------+------------------------+
| Townsend at 7th                         | San Francisco Caltrain 2 (330 Townsend) |         00:04:39 |          00:01:43 |         18:30:15 | 43.265822784810126 |                    158 |
| San Francisco Caltrain 2 (330 Townsend) | Townsend at 7th                         |         00:05:07 |          00:02:24 |         01:25:22 | 53.848101265822784 |                    158 |
| Embarcadero at Sansome                  | Steuart at Market                       |         00:08:31 |          00:03:48 |         21:42:03 |  43.50632911392405 |                    158 |
| 2nd at Townsend                         | Harry Bridges Plaza (Ferry Building)    |         00:09:42 |          00:04:54 |         19:46:28 |  48.22784810126582 |                    158 |
| Harry Bridges Plaza (Ferry Building)    | 2nd at Townsend                         |         00:10:38 |          00:05:25 |         10:31:47 |  43.59493670886076 |                    158 |
+-----------------------------------------+-----------------------------------------+------------------+-------------------+------------------+--------------------+------------------------+

```
  * SQL query:
```
     bq query --use_legacy_sql=false ' 
       SELECT bike_trips.start_station_name,
            bike_trips.end_station_name,
            TIME_ADD(TIME "00:00:00", interval (CAST(AVG(bike_trips.duration_sec) AS INT64)) SECOND) as average_duration,
            TIME_ADD(TIME "00:00:00", interval (CAST(MIN(bike_trips.duration_sec) AS INT64)) SECOND) as shortest_duration,
            TIME_ADD(TIME "00:00:00", interval (CAST(MAX(bike_trips.duration_sec) AS INT64)) SECOND) as longest_duration,
            MIN(route_trips_per_week.trips_per_week) as trips_per_week,
            MIN(num_weeks_route_active) as num_weeks_route_active
       FROM `bigquery-public-data.san_francisco.bikeshare_trips` bike_trips,
            `ambient-fuze-257001.bike_trip_data.route_trips_per_week` route_trips_per_week
      WHERE bike_trips.start_station_id = route_trips_per_week.start_station_id AND
            bike_trips.end_station_id = route_trips_per_week.end_station_id
   GROUP BY start_station_name, end_station_name
     HAVING trips_per_week > 40 and num_weeks_route_active > 16
   ORDER BY average_duration ASC
      LIMIT 5'
```

View for route_trips_per_week

```sql
    #standardSQL
       SELECT trips.start_station_id,
          trips.start_station_name,
          trips.end_station_id,
          trips.end_station_name,
          routes.num_weeks as num_weeks_route_active,
          trips.num_trips / routes.num_weeks as trips_per_week
     FROM `ambient-fuze-257001.bike_trip_data.route_trips` trips,
          `ambient-fuze-257001.bike_trip_data.station_routes` routes
     WHERE routes.start_station_id = trips.start_station_id AND
           routes.end_station_id = trips.end_station_id
```
     
- Question 5: What are the 5 most popular bike trips for station connections have been active for less than 16 weeks?
  * Answer:
  
```
+---------------------------------+-----------------------------------------------+------------------+-------------------+------------------+----------------+------------------------+
|       start_station_name        |               end_station_name                | average_duration | shortest_duration | longest_duration | trips_per_week | num_weeks_route_active |
+---------------------------------+-----------------------------------------------+------------------+-------------------+------------------+----------------+------------------------+
| Grant Avenue at Columbus Avenue | Clay at Battery                               |         00:06:14 |          00:02:17 |         07:50:46 |        59.5625 |                     16 |
| Grant Avenue at Columbus Avenue | Commercial at Montgomery                      |         00:06:27 |          00:01:29 |         21:06:39 |        65.3125 |                     16 |
| Grant Avenue at Columbus Avenue | Beale at Market                               |         00:07:47 |          00:03:55 |         05:34:35 |        67.1875 |                     16 |
| Grant Avenue at Columbus Avenue | Temporary Transbay Terminal (Howard at Beale) |         00:09:01 |          00:05:26 |         04:37:37 |        73.6875 |                     16 |
| Grant Avenue at Columbus Avenue | Market at Sansome                             |         00:09:09 |          00:03:31 |         10:48:21 |       197.0625 |                     16 |
+---------------------------------+-----------------------------------------------+------------------+-------------------+------------------+----------------+------------------------+
```
  * SQL query:
```
   bq query --use_legacy_sql=false ' 
     SELECT bike_trips.start_station_name,
            bike_trips.end_station_name,
            TIME_ADD(TIME "00:00:00", interval (CAST(AVG(bike_trips.duration_sec) AS INT64)) SECOND) as average_duration,
            TIME_ADD(TIME "00:00:00", interval (CAST(MIN(bike_trips.duration_sec) AS INT64)) SECOND) as shortest_duration,
            TIME_ADD(TIME "00:00:00", interval (CAST(MAX(bike_trips.duration_sec) AS INT64)) SECOND) as longest_duration,
            MIN(route_trips_per_week.trips_per_week) as trips_per_week,
            MIN(num_weeks_route_active) as num_weeks_route_active
       FROM `bigquery-public-data.san_francisco.bikeshare_trips` bike_trips,
            `ambient-fuze-257001.bike_trip_data.route_trips_per_week` route_trips_per_week
      WHERE bike_trips.start_station_id = route_trips_per_week.start_station_id AND
            bike_trips.end_station_id = route_trips_per_week.end_station_id
   GROUP BY start_station_name, end_station_name
     HAVING trips_per_week > 40 and num_weeks_route_active <= 16
   ORDER BY average_duration ASC
      LIMIT 5'
```

- Question 6: Calculate the utilization rate for stations in terms of capacity and availability. Which 5 stations are least utilized by time of day (excluding Evenings and Nightime)?
  * Answer:
  
```
+------------+------------------------------------------+-----------------+--------------------+-------------------+-----------------------+---------------------+
| station_id |               station_name               | time_of_day_str |  bikes_available   |  docks_available  | functioning_dockcount |     utilization     |
+------------+------------------------------------------+-----------------+--------------------+-------------------+-----------------------+---------------------+
|         69 | San Francisco Caltrain 2 (330 Townsend)  | Morning         | 14.685867733239865 | 8.251313029270635 |    22.937180762510497 |  0.3597352749975678 |
|         60 | Embarcadero at Sansome                   | Early Afternoon |  9.330660665125256 | 5.609327338627398 |    14.939988003752665 |  0.3754572853216771 |
|         70 | San Francisco Caltrain (Townsend at 4th) | Afternoon       | 11.612202810443478 | 7.266766966542825 |     18.87896977698632 |  0.3849133216687013 |
|         50 | Harry Bridges Plaza (Ferry Building)     | Morning         |  13.72676054886028 | 9.203606148390218 |    22.930366697250555 |  0.4013719566680008 |
|         54 | Embarcadero at Bryant                    | Morning         |  8.955241035579348 | 6.015560492121827 |    14.970801527701179 | 0.40181953391012176 |
+------------+------------------------------------------+-----------------+--------------------+-------------------+-----------------------+---------------------+
```
  * SQL query:
```
   bq query --use_legacy_sql=false ' 
     SELECT  station_id,
             station_name,
             time_of_day_str,
             avg(bikes_available) as bikes_available,
             avg(docks_available) as docks_available,
             avg(functioning_dockcount) as functioning_dockcount,
             (avg(docks_available) / (avg(functioning_dockcount))) as utilization
       FROM `ambient-fuze-257001.bike_trip_data.station_status`
      WHERE time_of_day_str not in ("Nightime", "Evening")
    GROUP BY station_id, station_name, time_of_day_str
    ORDER BY utilization ASC
       LIMIT 5'
```

View for station_status

```sql
    #standardSQL
  SELECT stations.station_id, 
         stations.name as station_name, 
         time,
         EXTRACT(ISOYEAR from time) as year,
         EXTRACT(ISOWEEK from time) as week,
         EXTRACT(DAYOFWEEK FROM time) AS dow_int,
         CASE EXTRACT(DAYOFWEEK FROM time)
             WHEN 1 THEN "Sunday"
             WHEN 2 THEN "Monday"
             WHEN 3 THEN "Tuesday"
             WHEN 4 THEN "Wednesday"
             WHEN 5 THEN "Thursday"
             WHEN 6 THEN "Friday"
             WHEN 7 THEN "Saturday"
             END AS dow_str,
         CASE 
             WHEN EXTRACT(DAYOFWEEK FROM time) IN (1, 7) THEN "Weekend"
             ELSE "Weekday"
             END AS dow_weekday,
         EXTRACT(HOUR FROM time) AS time_of_day_hour,
         CASE 
             WHEN EXTRACT(HOUR FROM time) <= 5  OR EXTRACT(HOUR FROM time) >= 23 THEN "Nightime"
             WHEN EXTRACT(HOUR FROM time) >= 6 and EXTRACT(HOUR FROM time) <= 8 THEN "Morning"
             WHEN EXTRACT(HOUR FROM time) >= 9 and EXTRACT(HOUR FROM time) <= 10 THEN "Mid Morning"
             WHEN EXTRACT(HOUR FROM time) >= 11 and EXTRACT(HOUR FROM time) <= 12 THEN "Mid Day"
             WHEN EXTRACT(HOUR FROM time) >= 13 and EXTRACT(HOUR FROM time) <= 15 THEN "Early Afternoon"
             WHEN EXTRACT(HOUR FROM time) >= 16 and EXTRACT(HOUR FROM time) <= 18 THEN "Afternoon"
             WHEN EXTRACT(HOUR FROM time) >= 19 and EXTRACT(HOUR FROM time) <= 22 THEN "Evening"
             END AS time_of_day_str,
         bikes_available,
         docks_available,
         bikes_available + docks_available as functioning_dockcount,
         stations.dockcount as station_dockcount
   FROM `bigquery-public-data.san_francisco.bikeshare_status` status,
        `bigquery-public-data.san_francisco.bikeshare_stations` stations
   WHERE status.station_id = stations.station_id
```


---

## Part 3 - Employ notebooks to synthesize query project results

### Get Going

Create a Jupyter Notebook against a Python 3 kernel named Project_1.ipynb in the assignment branch of your repo.

#### Run queries in the notebook 

At the end of this document is an example Jupyter Notebook you can take a look at and run.  

You can run queries using the "bang" command to shell out, such as this:

```
! bq query --use_legacy_sql=FALSE '<your-query-here>'
```

- NOTE: 
- Queries that return over 16K rows will not run this way, 
- Run groupbys etc in the bq web interface and save that as a table in BQ. 
- Max rows is defaulted to 100, use the command line parameter `--max_rows=1000000` to make it larger
- Query those tables the same way as in `example.ipynb`

Or you can use the magic commands, such as this:

```sql
%%bigquery my_panda_data_frame

select start_station_name, end_station_name
from `bigquery-public-data.san_francisco.bikeshare_trips`
where start_station_name <> end_station_name
limit 10
```

```python
my_panda_data_frame
```

#### Report in the form of the Jupter Notebook named Project_1.ipynb

- Using markdown cells, MUST definitively state and answer the two project questions:

  * What are the 5 most popular trips that you would call "commuter trips"? 
  
  * What are your recommendations for offers (justify based on your findings)?

- For any temporary tables (or views) that you created, include the SQL in markdown cells

- Use code cells for SQL you ran to load into Pandas, either using the !bq or the magic commands

- Use code cells to create Pandas formatted output tables (at least 3) to present or support your findings

- Use code cells to create simple data visualizations using Seaborn / Matplotlib (at least 2) to present or support your findings

### Resource: see example .ipynb file 

[Example Notebook](example.ipynb)