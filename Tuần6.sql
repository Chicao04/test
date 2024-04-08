create view invoice_view as
select invoice_id, invoice_number, invoice_date
from invoices;

select * from invoive_view;

-- Câu 1
create view open_items as
select v.vendor_name, 
i.invoice_number, 
i.invoice_total,
(i.invoice_total - i.payment_total - i.credit_total) as balance_due
from ap.invoice as i
join ap.vendor as v 
on v.vendor_id = i.vendor_id
where i.invoice_total - i.payment_total - i.credit_total >0
order by v.vendor_name;

select *
from open_items;


-- Câu 3
create view open_items_summary as 
select vendor_name, 
count(*) as open_item_count,
sum(invoice_total - payment_total - credit_total) as open_item_total
from vendors as v
join invoices as i
on v.vendor_id = i.vendor_id
where invoice_total - payment_total - credit_total >0
group by v.vendor_name, v.vendor_id
order by open_items_total desc;

select *
from open_items_summary


-- Câu mẫu slide
USE ap;
drop procedure if exists test;
-- Change statement delimiter from semicolon to double front slash alter
DELIMITER //
create procedure test()
begin
	declare sum_blance_due_var decimal(9, 2);
    
	select sum(invoice_total - payment_total - credit_total)
	into sum_blance_due_var
	from invoices
	where vendor_id = 95;

	if sum_blance_due_var >0 then
		select concat('Blance due: $', sum_blance_due_var) as message;
	else
		select 'Blance paid in full' as message;
	end if;
end//
delimiter ;
call test()