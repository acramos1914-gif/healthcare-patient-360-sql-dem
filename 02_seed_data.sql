INSERT INTO patients VALUES
(1001,'MRN-0001','James','Carter','1985-04-12','Male','Atlanta','GA'),
(1002,'MRN-0002','Maria','Lopez','1992-08-23','Female','Decatur','GA'),
(1003,'MRN-0003','David','Brown','1978-11-05','Male','Marietta','GA'),
(1004,'MRN-0004','Angela','Wilson','1988-02-17','Female','Atlanta','GA'),
(1005,'MRN-0005','Robert','Davis','1995-06-30','Male','Smyrna','GA'),
(1006,'MRN-0006','Susan','Taylor','1970-03-18','Female','Duluth','GA'),
(1007,'MRN-0007','Michael','Green','1982-09-02','Male','Roswell','GA'),
(1008,'MRN-0008','Denise','Hall','1990-12-14','Female','Atlanta','GA');

INSERT INTO encounters VALUES
(5001,1001,'2026-07-10','2026-07-15','Metro General','Emergency','Home'),
(5002,1001,'2026-07-15','2026-07-15','Metro General','Follow-up','Home'),
(5003,1001,'2026-08-01','2026-08-01','Regional Medical','Specialist','Home'),
(5004,1002,'2026-07-11','2026-07-12','Northside Medical','Emergency','Home'),
(5005,1003,'2026-07-12','2026-07-20','Metro General','Emergency','Rehab'),
(5006,1003,'2026-07-20','2026-07-20','Metro General','Follow-up','Home'),
(5007,1004,'2026-07-18','2026-07-18','Northside Medical','Outpatient','Home'),
(5008,1005,'2026-07-22','2026-07-29','Regional Medical','Emergency','Rehab'),
(5009,1006,'2026-07-25','2026-07-26','Metro General','Emergency','Home');

INSERT INTO trauma_registry VALUES
(7001,1001,5001,'2026-07-10','Motor Vehicle Accident',18,'Level II'),
(7002,1001,5002,'2026-07-15','Motor Vehicle Accident',18,'Level II'),
(7003,1003,5005,'2026-07-12','Fall',22,'Level I'),
(7004,1005,5008,'2026-07-22','Industrial Accident',25,'Level I'),
(7005,1005,5008,'2026-07-23','Industrial Accident',25,'Level I');

INSERT INTO burn_registry VALUES
(8001,1001,5001,'2026-07-10','Thermal',15.00,'Moderate'),
(8002,1001,5002,'2026-07-15','Thermal',15.00,'Moderate'),
(8003,1005,5008,'2026-07-22','Chemical',35.00,'Severe'),
(8004,1005,5008,'2026-07-24','Chemical',35.00,'Severe'),
(8005,1006,5009,'2026-07-25','Electrical',8.00,'Minor');

INSERT INTO claims VALUES
(9001,1001,5001,'Paid',42000,38000),
(9002,1001,5002,'Paid',4500,4200),
(9003,1001,5003,'Pending',8200,0),
(9004,1002,5004,'Paid',8500,7900),
(9005,1003,5005,'Pending',67500,0),
(9006,1003,5006,'Paid',6200,5800),
(9007,1004,5007,'Paid',3200,2900),
(9008,1005,5008,'Denied',91000,0);

INSERT INTO allergies VALUES
(10001,1001,'Penicillin','Rash'),
(10002,1001,'Peanuts','Anaphylaxis'),
(10003,1003,'Latex','Skin irritation'),
(10004,1005,'Shellfish','Swelling'),
(10005,1005,'Aspirin','Hives'),
(10006,1008,'Sulfa','Rash');
