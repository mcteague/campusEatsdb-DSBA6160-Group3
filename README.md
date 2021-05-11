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

<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/ffb45b53deab8fd29c30191726c7e9ea4dbadffc/Database/EERD-Final.png" width="425px">



#### Views

#### Stored Procedures and Functions</h4>

#### Triggers

#### Users and Permissions

A user and admin role were added to the database to enable better security when applications and other users connect. The *ce_user* role has only select privileges to the database tables while the *ce_admin role* has been granted full privileges to ALL tables. Additionally two user accounts, haps_user and jay_admin were created and assigned to the approriate roles respectively. We finished by creating a view for the restaurant table with update privileges for *haps_user*. As shown below, this user is able to update the view

<img src="https://github.com/mcteague/campusEatsdb-DSBA6160-Group3/blob/1a6d2484c24fecc4f87e539cbe1f72798f09728a/img/UsersView.png" width="425px">

### About Our Repository

Our repository consists of several SQL scripts allowing the re-creation of our database and its test data. Additionally, the repository also contains supplementary assets for the creation of this readme page. The folders in the repository are:

- */Database* - stores master SQL script for creating the campuseats database and included data along with the EERD diagrams for the initial and finished databases.
- */Queries_Scripts* - stores master SQL scripts for creating and testing our added triggers, functions, stored procedures, etc. Some of these are already included in the master SQL script, however it is no problem to run these scripts again.



