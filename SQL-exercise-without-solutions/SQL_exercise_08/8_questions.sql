-- 8.1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.

SELECT name FROM physician WHERE employeeid IN (SELECT u.physician FROM undergoes u LEFT JOIN trained_in t ON concat(u.physician,procedures)=concat(t.physician,treatment) WHERE treatment is NULL);

-- 8.2 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.

SELECT a.name physician,b.name procedures,dateundergoes,c.name patient FROM physician a INNER JOIN undergoes ON employeeid=physician INNER JOIN procedures b ON code=procedures INNER JOIN patient c ON patient=c.ssn WHERE employeeid IN (SELECT u.physician FROM undergoes u LEFT JOIN trained_in t ON concat(u.physician,procedures)=concat(t.physician,treatment) WHERE treatment is NULL);


-- 8.3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).

SELECT name FROM physician WHERE employeeid IN (SELECT u.physician FROM undergoes u LEFT JOIN trained_in t ON concat(u.physician,procedures)=concat(t.physician,treatment) WHERE certificationexpires is NOT NULL AND certificationexpires<dateundergoes);


-- 8.4 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.

SELECT a.name physician,b.name procedures,dateundergoes,c.name patient,certificationexpires FROM physician a INNER JOIN undergoes u ON employeeid=physician INNER JOIN procedures b ON code=procedures INNER JOIN patient c ON patient=c.ssn LEFT JOIN trained_in t ON concat(u.physician,procedures)=concat(t.physician,treatment) WHERE certificationexpires is NOT NULL AND certificationexpires<dateundergoes;


-- 8.5 Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.
患者姓名、医生姓名、护士姓名(如有)、预约开始和结束时间、检查室和患者的初级护理医师姓名




-- 8.6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force to prevent inconsistencies between these two tables. More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.

SELECT * FROM undergoes WHERE concat(patient,stay) NOT IN (SELECT concat(patient,stayid) FROM stay);

-- 8.7 Obtain the names of all the nurses who have ever been on call for room 123.

SELECT name FROM nurse WHERE employeeid IN (SELECT nurse FROM on_call o INNER JOIN room r ON concat(o.blockfloor,o.blockcode)=concat(r.blockfloor,r.blockcode) WHERE roomnumber=123);


-- 8.8 The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.

SELECT examinationroom,count(appointmentid) FROM appointment GROUP BY examinationroom ORDER BY examinationroom;


-- 8.9 Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
    -- The patient has been prescribed some medication by his/her primary care physician.
    -- The patient has undergone a procedure with a cost larger that $5,000
    -- The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
    -- The patient's primary care physician is not the head of any department.





SELECT * FROM physician;
SELECT * FROM appointment;
SELECT * FROM undergoes;
SELECT * FROM patient;
SELECT * FROM room;
SELECT * FROM prescribes;
SELECT * FROM nurse;
SELECT * FROM stay;
SELECT * FROM on_call;
SELECT * FROM block;