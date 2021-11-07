CREATE PROCEDURE `rate_suppliers` ()
BEGIN
		select S.SUPP_ID,S.SUPP_NAME,R.RAT_RATSTARS,
        CASE
			when R.RAT_RATSTARS > 4 then 'Genuine Suppliers'
            when R.RAT_RATSTARS > 2 then 'Average Suppliers'
            else
				'Average Suppliers'
			END AS verdict 
            from e_com.Rating r 
            inner join e_com.Supplier s on s.SUPP_ID=r.SUPP_ID;

END
