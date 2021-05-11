![Header](https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/233c357c89bfc80ac0615eaa81404ec0ed8fd701/img/food-dishes-header.jpeg "Header")

## Campus Eats Database Enhancement Project
### DSBA 6160 - Team 3 - Spring 2020
#### Our Team: Bhomik Rudani, Dustin Ballentine, Mike Teague, Naomi Thammadi

---

### Project Overview

Our team was tasked with studying and making enhancements to an existing database for an online meal delivery application for a college campus, *Campus Eats*. Unlike other online meal delivery services, this application is managed by the institution and exclusively employs members within the campus community to operate its services. This enhances the institution’s security by helping to limit the amount of non-students coming on campus for delivery and other related services.

We closely studied the original database to understand the various relationships, cardinalities, etc. between its various entities. We then enhanced the database with a rating system to allow for the tracking of ratings for both drivers and restaurants. Finally, we then provided further enhancements by providing a number of views, stored procedures, functions, triggers and user additions so as to improve efficiencies and security of the database as well as further enhance its overall operations and capabilities. 


### Database Details and Enhancements

Below we provide an overview of the campuseats database and detail the enhancements made to it by our team.

#### Overview and Structure

The EERD below details the Campus Eats database with the rating system enhancement added.

<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ffb45b53deab8fd29c30191726c7e9ea4dbadffc/Database/EERD-Final.png" width="425px">

#### Tables and Relationships

Our Database Structure has 14 tables out of which Person, Order and Rating are some of the important tables:

1. Person - This is one of the important entities on which other entities like Faculty, Staff and Student are based out of. The Person table has all the basic attributes like name, email, phone number
2. Faculty - This table holds details about the faculty member like their title and the degrees they hold
3. Staff - This table holds details about all other staff members and their positions. It also specifies if they are administrative staff or not.
4. Student - This table holds details about student details like their major, graduation year and type(Graduate/Undergraduate)
5. Driver - This table holds additional information of students who deliver the orders like their hiring date, license and rating
6. Order - This is another important entity of our model. An Order is picked up for a restaurant by the driver and dropped off at the customer location. Cost of the order and delivery charges are mentioned on the order. The Order table thus holds all information about the order like order id, person id, delivery id, location id, driver id, restaurant id, total price of order and delivery charges. 
7. Restaurant - This table holds details about the Restaurant like name, location, schedule for when the restaurant is open and when it closes and website details
8. Delivery - A delivery can be made for multiple orders. Each order is associated with only one delivery id. A vehicle and driver are associated with a delivery. The Delivery table has attributes like driver id, vehicle id and delivery time.
9. Vehicle - This table holds details about the vehicle used for making the delivery like Vehicle license plate, model, make. Each vehicle can be used for different deliveries at different delivery times.
10. Location - This table holds information about addresses. Details like location name, address, latitude and longitude, and dropoff point are mentioned here.
11. Rating - This is the entity that we added to the existing Campus Eats Database. The Rating table is a super type and has two subtypes - Restaurant rating and Driver rating. Each order can be rated based on the overall order, the restaurant and the driver. The overall experience rating is captured on the Rating table. The attributes of this table are rating id, order id and overall experience.
12. Restaurant Rating - A subtype to Rating, it is identified using the rating id of the rating table and additionally the restaurant id. A few more details are captured on this table like rating for food quality, rating for food temperature, if the customer received the order correctly or not, and any comments for the restaurant.
13. Driver Rating - A subtype to Rating, it is identified using the rating id of the rating table and additionally the driver id. A few more details are captured on this table like how satisfied the customer was with the speed of delivery and courtesy of the driver. Additionally any comments to the driver can also be provided here.
14. Audit Log - This table is used for auditing purposes. Whenever a restaurant or driver entry is inserted, updated or deleted, a record is created with the appropriate details in the audit log table.


#### Views

There are five views available in our database schema:

1. Restaurant Rating View - Shows the average rating for all orders made at each restaurant

<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/view1.png" width="425px">

2. Driver Rating View - Shows the average rating for all orders delivered by each driver
<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/view2.png" width="425px">

3. Restaurant and Driver Statistics View - Shows the total count of orders for each restaurant, the average rating and average driver rating received for their orders. This view will help get a birds eye view of all restaurant and driver ratings for that restaurant to see if driver rating has an impact on their overall rating

<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/view3.png" width="425px">

4. Person Student View - Displays details of all students graduating in 2019. This view can be altered by graduation year

<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/view3.png" width="425px">

5. Person Join View - Displays details of students in the “Computer Science” major. This view also can be altered as required. Both Person Join and Person Student were part of the original data model of Campus Eats that was provided to us

<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/view3.png" width="425px">

#### Stored Procedures and Functions</h4>

##### Stored Procedures

-  insert_restaurant - used to insert a restaurant into the Restaurant table. It also validates the inputs and displays an error if the restaurant name, location are too long or if the schedule is not entered in the right format
<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/sp1a.png" width="425px">
<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/sp1b.png" width="425px">


<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/sp4.png" width="425px">

<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/sp5a.png" width="425px">
<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/sp5b.png" width="425px">
<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/sp5c.png" width="425px">
<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/sp5d.png" width="425px">

##### Functions

- get_driver_id and get_restaurant_id - used to fetch the driver id and restaurant id respectively if the driver name and restaurant name are provided as inputs

<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/func2.png" width="425px">

- get_average_restaurant_rating - used to fetch the average restaurant rating when the restaurant name is given as an input to the function

<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ad094f793529650d176e3f2d24db7366bd0fd3c5/img/func3.png" width="425px">


#### Triggers

There are seven triggers in our database, six of which are for audit purposes which create a record in the Audit Log table for every insert, update, delete of a restaurant or a driver.
The seventh, *update_driver_rating_on_driver*, updates the rating field on the driver record with the overall average driver rating for every order he/she delivers and receives a rating for it.


#### Users and Permissions

A user and admin role were added to the database to enable better security when applications and other users connect. The *ce_user* role has only select privileges to the database tables while the *ce_admin role* has been granted full privileges to ALL tables. Additionally two user accounts, haps_user and jay_admin were created and assigned to the approriate roles respectively. We finished by creating a view for the restaurant table with update privileges for *haps_user*. As shown below, this user is able to update the view

<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/1a6d2484c24fecc4f87e539cbe1f72798f09728a/img/UsersView.png" width="425px">

### About Our Repository

Our repository consists of several SQL scripts allowing the re-creation of our database and its test data. Additionally, the repository also contains supplementary assets for the creation of this readme page. The folders in the repository are:

- */Database* - stores master SQL script for creating the campuseats database and included data along with the EERD diagrams for the initial and finished databases.
- */Queries_Scripts* - stores master SQL scripts for creating and testing our added triggers, functions, stored procedures, etc. Some of these are already included in the master SQL script, however it is no problem to run these scripts again.



