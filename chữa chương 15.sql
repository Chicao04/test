-- Chương 15
-- Câu 1:
use ap;
drop procedure if exists insert_glaccount;
delimiter //
create procedure insert_glaccount
(
	account_number_param		int,
    account_description_param	varchar(50)
)
begin
	insert into general_ledger_accounts(account_number, account_description)
	value(account_number_param, account_description_param);
    end//
delimiter ;

call insert_glaccount(900, 'Insert services');

-- Câu 2:
use ap;
drop function if exists test_glaccount_description;
delimiter //
create function test_glaccount_description
	(
    account_description_param	varchar(50)
    )
returns int
deterministic reads sql data
begin
	declare account_description_var		varchar(50);
	declare check_var int;
	select account_description
    into account_description_var
	from general_ledger_accounts
	where  acccount_description = account_description_param;
    if account_description_var is not null then
		set  check_var = 1;
	else
		set check_var = 0;
	end if;
    return check_var;
end //
delimiter ;

-- Câu 3:
drop procedure if exists test_glaccount_description;
delimiter //
create procedure test_glaccount_description
(
	account_number_paragram int,
	account_description_paragram	varchar(50)
)
begin
	declare x int;
	set x = test_glaccount_description(account_description_paragram);
	if x = 1 then
		signal sqlstate '23000'
		set message_text = 'Duplicate account description';
	else
		insert into general_ledge_accounts(account_number, accunt_description) 
        values (account_number_paragram, account_description_paragram);
	end if;
end //

-- Câu 4:
use ap;
drop procedure if exists insert_terms;
delimiter //
create procedure insert_terms
(
	term_id_param			int,
	terms_due_days_param	int,
    terms_description_param	varchar(50)
)
begin
	declare default_description	varchar(50)
    if terms_description_param is null then
		set default_description = concat('net due', terms_due_days_param, 'days');
	else
		set default_description = terms_description_param;
	end if;
		insert into terms
        values (term_id_param, terms_due_days_param, default_description);
        end //
        delimiter ; 
	
