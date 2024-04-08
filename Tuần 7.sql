use ap;
drop procedure if exists test;
delimiter //
 create procedure test()
 begin
	declare sql_error tinyint default false;
    declare continue handler for sqlexception
		set sql_error = TRUE;
	start transaction;
    insert into invoices
    values (115, 34, 'ZXA-080', '2018-01-18',
			14092.59, 0, 0, 3, '2018-04-18', NULL);
	insert into invoice_line_items
    values (115, 1,160, 4447.23, 'HW upgrade');
    
    insert into invoice_line_items
    values (115, 2, 167, 9645.36, 'OS upgrade');
		if sql_error = FALSE then
			commit;
            select 'The transaction was committed.';
		else
			rollback;
            select 'The transaction was rolled back.';
		end if;
	end//
    delimiter ;
    call test()
    
    -- Check data
    select *
    from invoices where invoice_id = 115;