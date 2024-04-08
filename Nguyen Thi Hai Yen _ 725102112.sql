-- Nguyen Thi Hai Yen - 725102112 - Phong 608 - May 29 - De 01

-- Cau 1:
use ap;
delimiter //
select t.terms_id, t.terms_description, 
(select t.terms_id, t.terms_description, count(i.vendor_id) as so_vendor)
from terms as t
join vendors as v on v.vendor_id = t.default_terms_id
select t.terms_id, t.terms_description, so_vendor
            

-- Cau 2:
create View_Account_725102112
select account_number, account_description, line_item_description, sum(i.invoice_total - i.payment_total - i.credit_total) as line_item_amount
from ap.terms as t
join ap.invoices as i
on i.invoice_id = t.term_id
where i.invoice_total - i.payment_total - i.credit_total >1000
group by v.vendor_name, v.vendor_id
order by i.invoice_name;

-- Cau 3:
use ap;
drop procedure if exists test;
DELIMITER //
create procedure pro_725102112()
(
	declare Update_term_pa1		varchar(50)
    declare Update_term_pa2		varchar(50)
)
begin
	if 
end//
delimiter ;
call test()