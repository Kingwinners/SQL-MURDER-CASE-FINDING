/* you vaguely remember that the crime was a murder that occuered sometime in Jan.15 2018
and that it took place i  sql city; Start by retriving thr correspondent crime scene report.*/

SELECT * FROM crime_scene_report
WHERE date = '20180115' AND crime_type = 'murder' AND city = 'SQL City'

/*Security footage shows that there were 2 witnesses. 
The first witness lives at the last house on "Northwestern Dr".
The second witness, named Annabel, lives somewhere on "Franklin Ave"*/

SELECT * FROM person

--FIND FIRST WITNESSAND WHAT HE OR SHE SAID. The first witness lives 0n 'northwestern Dr'

SELECT * FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_Number DESC

--Our firdt witness is MORTY SCHAPIRO

--FIND WITNESS TWO
--THE SECOND WITNESS NAMED ANNABEL LIVES SOMEWHEREON FRANKLIN AVE

SELECT * FROM person
WHERE name LIKE 'Annabel%' AND address_street_name = 'Franklin Ave'

/*OUR FIRST WITNESS IS MORTY SCHAPIRO with  ID-14887; LINCENSE ID-118009; Address number-4919; 
Northwestern Dr; SSN- 111156494*/
/*OUR SECOND WITNESS IS ANNABEL MILLER with ID-16371; LINCENSE ID - 490173;
Adddress number-103; Franklin Ave; SSN- 318771143*/

SELECT * FROM interview
WHERE person_id IN (14887,16371)

/*FIRST WITNESS (Mr Morty ID- 14887 said)--I heard a gunshot and then saw a man run out. 
He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z".
Only gold members have those bags.
The man got into a car with a plate that included "H42W"*/

/*SECOND WITNESS (Mrs Annabel ID- 16371 said)--I saw the murder happen, and
I recognized the killer from my gym when I was working out last week on January the 9th*/

SELECT * FROM get_fit_now_member
WHERE id LIKE '48Z%'
AND membership_status = 'gold'

/*Based on the report on the firsy witness, Our suspects are 
JOEGERMUSKA WITH ID-48A7A;PERSON ID-28819;MEMBERSHIP START DATE-20160305 WITH MEMBERSHIP AS GOLD*/

/*THE SECOND SUSPECT IS JEREMY BOWERS 
WITH ID-48Z55;PERSON ID-67318; MEM S.D-20160101 WITH MEM STAT AS GOLD*/

SELECT * FROM get_fit_now_check_in
WHERE check_in_date = 20180109 AND membership_id IN ('48Z55','48Z7A')

--BOTH SUSPECTS CAME TO GYM THAT DAY

SELECT dl.age, dl.height, dl.eye_color, dl.hair_color, dl.gender, dl.plate_number, dl.car_make, 
    dl.car_model, p.name, p.ssn, p.address_street_name, p.id
FROM drivers_license AS dl
LEFT JOIN person AS p
ON dl.id = p.license_id
WHERE plate_number LIKE '%H42W%' or plate_number LIKE 'H42W%'or plate_number LIKE '%H42W'

--OUR CULPRIT IS JEREMY BOWERS with id- 67318  BUT lets see what he said in his interview

SELECT * FROM interview
WHERE person_id = '67318'

/*JEREMY SAID IN HIS INTERVIEW THAT - I was hired by a woman with a lot of money.
I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
She has red hair and she drives a Tesla Model S. 
I know that she attended the SQL Symphony Concert 3 times in December 2017.*/

--NOW LET US LOOK FOR WHO HIRED JEREMY

CREATE TABLE suspect AS (SELECT * FROM drivers_license
WHERE height BETWEEN 65 AND 67
AND hair_color = 'red'
AND gender = 'female'
AND car_make = 'Tesla'
AND car_model = 'Model S')
--SHE ATTENDED AN SQL EVENT 3 TIMES IN DECEMBER SO LETS CHECK TO KNOW MORE ABOUT WHO THE SENDER IS

SELECT * FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert'
AND DATE BETWEEN 20171201 AND 20171231

/*THE HIRER IS SAID TO HAD ATTENED 3 TIMES IN DECEMBER SO WE HAVE 2 SUSPECT NOW
WITH PWERSON ID - 99716 AND 24556*/

SELECT * FROM person

SELECT s.id, s.age, s.height, p.id AS person_id, p.name, p.address_street_name, p.ssn
FROM suspect AS s
RIGHT JOIN person AS p
ON s.id = p.license_id
WHERE height BETWEEN 65 AND 67

--NOW OUR SUSPECTS BOILS DOWN TO - 99716;90700;78881

SELECT * FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert'
AND date BETWEEN 20171201 AND 20171231
AND person_id IN (99716,90700,78881)
 
 --JEREMY'S HIRER IS WITH ID-99716 BUT LETS KNOW THE NAME
 
SELECT * FROM person
WHERE id = 99716

--FINALLY JEREMYS HIRER IS Miranda Priestly.