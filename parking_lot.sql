create database xyz;


--- Tables ---

Create table parking_lot (id numeric PRIMARY KEY, number_of_blocks numeric, address varchar(500), zip varchar(10), operating_company_na varchar(100)); 
 
Create table block_(id numeric PRIMARY KEY , parking_lot_id numeric , block_code varchar(3), number_of_floo numeric, CONSTRAINT fk_block_parking_lot FOREIGN KEY (parking_lot_id) REFERENCES parking_lot(id)); 
desc block_ ;
Create table floor_(id numeric PRIMARY KEY ,block_id numeric,floor_number numeric,number_of_wings numeric , CONSTRAINT fk_floor_block FOREIGN KEY (block_id) REFERENCES block_(id));

Create table parking_slot(id numeric PRIMARY KEY,floor_id numeric ,slot_number numeric,wing_code char(1), CONSTRAINT fk_parking_slot_floor FOREIGN KEY (floor_id) REFERENCES floor_(id)); 
 
Create table customer(id numeric PRIMARY KEY,name varchar(10),vehical_number varchar(20),registration_date date,contact_number numeric,cost numeric(10,2)); 
desc customer;
Create table parking_slot_reservation(id numeric PRIMARY KEY,customer_id,start_timestamp varchar(5),duration_in_minutes numeric,booking_date date,parking_slot_id numeric, CONSTRAINT fk_psr_customer FOREIGN KEY (customer_id) REFERENCES customer(id),CONSTRAINT fk_psr_parking_slot FOREIGN KEY (parking_slot_id) REFERENCES parking_slot(id)); 

Create table parking_slip(id numeric PRIMARY KEY,parking_slot_reservatio numeric,actual_entry_time varchar(5),actual_exit_time varchar(5),basic_cost numeric(10,2),penalty numeric(10,2),total_cost numeric(10,2),CONSTRAINT fk_pslip_psr FOREIGN KEY (parking_slot_reservatio) REFERENCES parking_slot_reservation(id));  


--- Insertion ---

insert into parking_lot values(201,5,'Pratiksha nagar,Sion,Mumbai,Maharashtra','400022','P1 Services');
select * from parking_lot;
 

insert into block_ values(01,201,'A-1',1);
insert into block_ values(03,201,'A-2',1);
insert into block_ values(05,201,'A-3',1);
insert into block_ values(07,201,'B-1',2);
insert into block_ values(09,201,'B-2',2);

select * from block_;
 
insert into floor_ values(101,01,1,3);
insert into floor_ values(102,03,1,3);
insert into floor_ values(103,05,1,3);
insert into floor_ values(201,07,2,2);
insert into floor_ values(202,09,2,2);

select * from floor_;
 
insert into parking_slot values(01,101,01,'A');
insert into parking_slot values(02,101,02,'A');
insert into parking_slot values(03,102,03,'A');
insert into parking_slot values(04,102,04,'A');
insert into parking_slot values(05,103,05,'A');
insert into parking_slot values(06,103,06,'A');
insert into parking_slot values(07,201,07,'B');
insert into parking_slot values(08,201,08,'B');
insert into parking_slot values(09,202,09,'B');
insert into parking_slot values(10,202,10,'B');
insert into parking_slot values(11,202,11,'B');

select * from parking_slot;
 

insert into customer values(01,'bhavya','MH100200','06/10/2022','932745372',100);
insert into customer values(02,'mansi','GJ100200','08/11/2022','9743834845',200);
insert into customer values(03,'ishwari','UP100200','06/09/2022','8948989998',100);
insert into customer values(04,'prachi','DL100200','10/10/2021','9848409858',100);
insert into customer values(05,'saumya','MH100321','03/10/2022','9893898349',200);
insert into customer values(06,'shreya','GJ100675','09/11/2022','9489483943',200);
insert into customer values(07,'muskan','UP100887','09/09/2022','7832883988',300);
insert into customer values(08,'gargi','DL100432','01/05/2022','9876543210',300);
insert into customer values(09,'khushi','DL100274','07/11/2022','8984838848',100);
insert into customer values(10,'niketa','MH100900','05/12/2022','883889849',200);
insert into customer values(11,'bhavya','MH100200','11/10/2022','932745372',200);
select * from customer;
 


insert into parking_slot_reservation values(201,01,'01:00',60,'06/10/2022',01);
insert into parking_slot_reservation values(202,02,'02:30',120,'08/11/2022',02);
insert into parking_slot_reservation values(203,03,'03:30',60,'06/09/2022',03);
insert into parking_slot_reservation values(204,04,'04:00',60,'10/10/2021',04);
insert into parking_slot_reservation values(205,05,'05:00',120,'03/10/2022',05);
insert into parking_slot_reservation values(206,06,'06:00',120,'09/11/2022',06);
insert into parking_slot_reservation values(207,07,'07:00',180,'09/09/2022',07);
insert into parking_slot_reservation values(208,08,'08:00',180,'01/05/2022',08);
insert into parking_slot_reservation values(209,09,'09:30',60,'07/11/2022',09);
insert into parking_slot_reservation values(210,10,'10:00',120,'05/12/2022',10);
insert into parking_slot_reservation values(211,11,'11:00',120,'11/10/2022',11);
 select * from parking_slot_reservation;
 
insert into parking_slip values(01,201,'01:00','02:00',100,NULL,100);
insert into parking_slip values(02,202,'02:30','4:30',200,NULL,200);
insert into parking_slip values(03,203,'3:30','4:30',100,NULL,100);
insert into parking_slip values(04,204,'4:00','5:00',100,NULL,100);
insert into parking_slip values(05,205,'5:00','7:00',200,NULL,200);
insert into parking_slip values(06,206,'6:00','8:00',200,NULL,200);
insert into parking_slip values(07,207,'7:00','10:00',300,NULL,300);
insert into parking_slip values(08,208,'8:00','11:00',300,NULL,300);
insert into parking_slip values(09,209,'9:00','10:30',100,NULL,100);
insert into parking_slip values(10,210,'10:00','12:00',200,NULL,200);
insert into parking_slip values(11,211,'11:00','12:00',200,NULL,200);
select * from parking_slip;
 
 
 --- SQL Queries ---
 
-- Q1.Display block and customer information with customer id '04'. 
 Select Distinct * from customer FULL join block on block.id = customer.id where customer.id = 01;

--Q2.List of customers who parked on '07/10/2022'.
 Select name from customer where registration_date = '07/10/2022';

--Q3.Set constraint on cost attribute that cost>400
 Alter table customer ADD CONSTRAINT cost_check CHECK(cost>400);

--Q4.Find the name of customer with maximum duration.
 Select Distinct customer.id,customer.name,parking_slot_reservation.id,parking_slot_reservation.start_timestamp,parking_slot_reservation.duration_in_minutes
from customer INNER join parking_slot_reservation on customer.id = parking_slot_reservation.id WHERE parking_slot_reservation.duration_in_minutes =
(SELECT max(duration_in_minutes) FROM parking_slot_reservation);

--Q5.Display customer information who's vehical number plate strating with 'MH------'.
 Select * from customer where vehical_numb er like 'MH%';

--Q6.Set constraint on cost for fair of customers cannot be NULL
 ALTER TABLE customer MODIFY cost number NOT NULL;

--Q7.Display parking_slip and customer information of all customer. 
 SELECT * FROM customer NATURAL JOIN parking_slip;

--Q8.Find total amount collected from customers on '07/10/2022'.
 Select sum(cost) from customer where registration_date = '07/10/2022';

--Q9.Add column Avalibility to parking_slot_reservation and set ‘Available’ as default value for every entry.
 ALTER TABLE parking_slot_reservation ADD is_avail varchar(10) DEFAULT 'Available';

--Q10.Display only cost of fair and duration for all the customers.
 SELECT cost, duration_in_minutes FROM customer, parking_slot_reservation  WHERE customer.id = parking_slot_reservation.id;

--Q11.List of vehical number plate from customer who parked at Block 'B-2'.
 Select vehical_number from customer where block = 'B-2'

--Q12.Set constraint on contact number to be unique.
 ALTER TABLE customer ADD UNIQUE(contact_number);

--Q13.Add a GST column which is 10% of cost for customer
 Select (cost*0.1) as "GST" from customer

--Q14.Find the id of customer taking minimum cost for fair. 
 Select id from customer where cost = (select MIN(cost) from customer);

Q15.Drop cost constraints from customer
 ALTER TABLE customer DROP constraint cost_check;
 
 
--- PL SQL Blocks  ---

-- trigger calculting the total cost after adding penalty and  placing the value in parking_slip

create or replace trigger after_insert_parking_slip
after insert on parking_slip
for each row
declare
    v_total_cost number(10,2);
begin
    
    v_total_cost := :new.basic_cost + coalesce(:new.penalty, 0);

    
    update parking_slip
    set total_cost = v_total_cost
    where id = :new.id;
    
    commit;
end;
/
DROP TRIGGER after_insert_parking_slip;

-- raise alert for updating the registartion after 1 year

create or replace trigger b_u_registration_date
before update of registration_date on customer
for each row
begin
    if months_between(sysdate, :new.registration_date) > 12 then
        raise_application_error(-20002, 'Cannot update registration date for records older than a year');
    end if;
end;
/


-- trigger on block table after updating the id of parking slot

create or replace trigger A_U_BLOCK
after update of PARKING_LOT_ID on BLOCK_
for each row
declare
    V_OPERATING_COMPANY_NA PARKING_LOT.OPERATING_COMPANY_NA%type;
begin
    select OPERATING_COMPANY_NA into V_OPERATING_COMPANY_NA
    from PARKING_LOT
    where id = :new.PARKING_LOT_ID;

    update PARKING_LOT
    set OPERATING_COMPANY_NA = V_OPERATING_COMPANY_NA
    where id = :new.PARKING_LOT_ID;
end;
/


-- trigger on parking_lot before deleting te parking lot it check if the paraking slot is empty or not 

create or replace trigger before_delete_parking_lot
before delete on parking_lot
for each row
declare
    v_count number;
begin
    select count(*)
    into v_count
    from parking_slot
    where floor_id in (select id from floor_ where block_id in (select id from block_ where parking_lot_id = :old.id));

    if v_count > 0 then
        raise_application_error(-20003, 'Cannot delete parking lot with associated parking slots');
    end if;
end;
/

-- trigger

create or replace trigger AFTER_DELETE_BLOCK
after delete on BLOCK_
for each row
begin
    update PARKING_LOT
    set NUMBER_OF_BLOCKS = NUMBER_OF_BLOCKS - 1
    where id = :old.PARKING_LOT_ID;
end;
/


-- procedure 
-- 

create or replace procedure check_parking_avl(parking_lot_id in number) as
    v_count number;
begin
    select count(*)
    into v_count
    from parking_slot
    where floor_id in (select id from floor_ where block_id in (select id from block_ where parking_lot_id = parking_lot_id));

    if v_count > 0 then
        raise_application_error(-20003, 'Cannot delete parking lot with associated parking slots');
    end if;
end check_parking_avl;
/

set serveroutput on;
declare
    v_parking_lot_id number := 201; 
begin
    check_parking_avl(v_parking_lot_id);
end;
/


-- function 
--
create or replace function get_customer_details(customer_id in number) return varchar2 is
    v_details varchar2(4000);
begin
  
    select 'Customer ID: ' || to_char(id) || chr(10) ||
           'Name: ' || name || chr(10) ||
           'Registration Date: ' || to_char(registration_date, 'DD/MM/YYYY') || chr(10) ||
           'Contact Number: ' || to_char(contact_number) || chr(10) ||
           'Cost: ' || to_char(cost, 'FM999999990.00') into v_details
    from customer
    where id = customer_id;

    return v_details; 
exception
    when no_data_found then
        return 'Customer with ID ' || to_char(customer_id) || ' not found.';
end get_customer_details;
/

set serveroutput on;

declare
    customer_id number := 1; 
    customer_details varchar2(4000);
begin
    
    customer_details := get_customer_details(customer_id);
    
    dbms_output.put_line(customer_details);
end;
/
-- calculate the total amount obtained from each year 
select sum(cost) as total_amount_2022 
from customer
where extract(year from registration_date) = 2022;
 

-- which block has max no of reservations 
select b.block_code, count(psr.id) as reservation_count
from block_ b
join floor_ f on b.id = f.block_id
join parking_slot ps on f.id = ps.floor_id
join parking_slot_reservation psr on ps.id = psr.parking_slot_id
group by b.block_code
order by reservation_count desc;



-- select a customer find the no of reservation
select c.name as customer_name, count(psr.id) as reservation_count
from customer c
left join parking_slot_reservation psr on c.id = psr.customer_id
where c.name = 'bhavya'
group by c.name;


