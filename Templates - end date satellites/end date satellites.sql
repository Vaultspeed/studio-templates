CREATE  VIEW `HEALTHCARE_BV`.`SAT_HLTH_PATIENT_PATIENT_GDPR_EFF`  AS 
	SELECT 
		  `SAT_SRC`.`PATIENT_HKEY` AS `PATIENT_HKEY`
		, `SAT_SRC`.`LOAD_CYCLE_ID` AS `LOAD_CYCLE_ID`
		, `SAT_SRC`.`ID` AS `ID`
		, `SAT_SRC`.`LOAD_DATE` AS `LOAD_DATE`
		, COALESCE(lead(`SAT_SRC`.`LOAD_DATE`)over(partition by `SAT_SRC`.`PATIENT_HKEY` order by `SAT_SRC`.`LOAD_DATE`)
			,TO_TIMESTAMP('31/12/2999 23:59:59','dd/MM/yyyy HH:mm:ss')) AS `END_DATE`
		, `SAT_SRC`.`RACE` AS `RACE`
		, `SAT_SRC`.`MARITAL` AS `MARITAL`
		, `SAT_SRC`.`SSN` AS `SSN`
		, `SAT_SRC`.`BIRTHDATE` AS `BIRTHDATE`
	FROM `HEALTHCARE_FL`.`SAT_HLTH_PATIENT_PATIENT_GDPR` `SAT_SRC`
	WHERE  `SAT_SRC`.`DELETE_FLAG` = CAST('N'  AS STRING)
	;