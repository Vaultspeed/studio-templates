BEGIN 

BEGIN -- sat_effectivity

	WITH [max_ld] AS 
	( 
		SELECT 
			  [sat_mld_src].[claim_technical_hkey] AS [claim_technical_hkey]
			, MAX([sat_mld_src].[load_date]) AS [max_load_timestamp]
		FROM [mis_decom_fl].[sat_gg_claim_technical] [sat_mld_src]
		GROUP BY  [sat_mld_src].[claim_technical_hkey]
	)
	INSERT INTO [BUSINESS_LOGIC_LAYER].[gg_claim_technical_eff](
		 [claim_technical_hkey]
		,[load_cycle_id]
		,[load_date]
		,[hdr_change_seq]
		,[fafano]
	)
	SELECT 
		  [sat_src].[claim_technical_hkey] AS [claim_technical_hkey]
		, [sat_src].[load_cycle_id] AS [load_cycle_id]
		, [sat_src].[load_date] AS [load_date]
		, [sat_src].[hdr_change_seq] AS [hdr_change_seq]
		, [sat_src].[fafano] AS [fafano]
	FROM [mis_decom_fl].[sat_gg_claim_technical] [sat_src]
	INNER JOIN [max_ld] [max_ld] ON  [sat_src].[claim_technical_hkey] = [max_ld].[claim_technical_hkey] AND [sat_src].[load_date] = [max_ld].[max_load_timestamp]
	WHERE  [sat_src].[delete_flag] = 'N' 
	;
END;



END;