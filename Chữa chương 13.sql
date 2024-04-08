-- Chương 13:
-- Câu 1:
use ap;
drop procedure if exists test;
delimiter //
create procedure test()
begin
	declare count_balance_due int;
    select count(*)
    into count_balance_due
    from invoices
    where (invoice_total - payment_total - credit_total) >= 5000;
    if count_balance_due >0 then
		select concat(count_balance_due, " invoices exceed $5,000") as message;
	else
		select ("No invoices exceed $5,000.");
	end if;
end//
delimiter ;
call test()

-- Câu 2:
use ap;
drop procedure if exists test;
delimiter //
create procedure test()
begin
	declare count_balance_due int;
    declare sum_balance_due decimal(9,2);
    select count(*), sum(invoice_total - payment_total - credit_total)
    into count_balance_due, sum_balance_due
    from invoices
    where (invoice_total - payment_total - credit_total) > 0;
    if sum_balance_due >30000 then
		select count_balance_due, sum_balance_due ;
	else
		select ("Total balance due is leathan $30,000.") as message;
	end if;
end//
delimiter ;
call test()

-- Câu 3:
use ap;
drop procedure if exists test;
delimiter //
create procedure test()
begin
	declare i int default 10;
    declare gt int default 1;
    while i > 0 do
		set gt = gt*i;
        set i = i - 1;
	end while;
    select concat("The factorial of 10 is: ", format(gt,0)) as message;
end//
delimiter ;
call test()