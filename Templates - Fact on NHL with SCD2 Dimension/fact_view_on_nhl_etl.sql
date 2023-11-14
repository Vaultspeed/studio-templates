
	SELECT 
		  `DVO_BASE1`.`DIM_PROVIDERS_HKEY` AS `DIM_PROVIDERS_HKEY`
		, `DVO_BASE2`.`DIM_PATIENT_HKEY` AS `DIM_PATIENT_HKEY`
		, `DVO_BASE3`.`DIM_ENCOUNTER_HKEY` AS `DIM_ENCOUNTER_HKEY`
		, `NHL`.`CODE` AS `CODE`
		, `NHL`.`PAYER` AS `PAYER`
		, `NHL`.`ORGANIZATION` AS `ORGANIZATION`
		, `NHL`.`TOTAL_CLAIM_COST` AS `TOTAL_CLAIM_COST`
		, `NHL`.`STOP` AS `STOP`
		, `NHL`.`BASE_ENCOUNTER_COST` AS `BASE_ENCOUNTER_COST`
		, `NHL`.`REASONCODE` AS `REASONCODE`
		, `NHL`.`PAYER_COVERAGE` AS `PAYER_COVERAGE`
		, `NHL`.`ENCOUNTERCLASS` AS `ENCOUNTERCLASS`
		, `NHL`.`REASONDESCRIPTION` AS `REASONDESCRIPTION`
		, `NHL`.`DESCRIPTION` AS `DESCRIPTION`
	FROM `HEALTHCARE_FL`.`NHL_HLTH_ENCOUNTER_EXECUTION` `NHL`
	INNER JOIN 	( 
		SELECT 
			  `HUB_FK_SRC1`.`PROVIDERS_HKEY` AS `BASE_OBJECT_H_KEY`
			, `SCD2_DIM_HUB_SRC1`.`DIM_PROVIDERS_HKEY` AS `DIM_PROVIDERS_HKEY`
			, `SCD2_DIM_HUB_SRC1`.`SNAPSHOT__TIMESTAMP` AS `FILTER_SNAPSHOT_TIMESTAMP`
			, `SCD2_DIM_HUB_SRC1`.`END_SNAPSHOT__TIMESTAMP` AS `FILTER_END_SNAPSHOT_TIMESTAMP`
		FROM `HEALTHCARE_FL`.`HUB_PROVIDERS` `HUB_FK_SRC1`
		INNER JOIN `INFORMATION_MARTS`.`DIM_PROVIDERS` `SCD2_DIM_HUB_SRC1` ON  `HUB_FK_SRC1`.`PROVIDERS_HKEY` = `SCD2_DIM_HUB_SRC1`.`PROVIDERS_HKEY`
	)  `DVO_BASE1` ON  `DVO_BASE1`.`BASE_OBJECT_H_KEY` = `NHL`.`PROVIDERS_HKEY` AND `NHL`.`START` >= `DVO_BASE1`.`FILTER_SNAPSHOT_TIMESTAMP` AND 
		`NHL`.`START` < `DVO_BASE1`.`FILTER_END_SNAPSHOT_TIMESTAMP`
	INNER JOIN 	( 
		SELECT 
			  `HUB_FK_SRC2`.`PATIENT_HKEY` AS `BASE_OBJECT_H_KEY`
			, `SCD2_DIM_HUB_SRC2`.`DIM_PATIENT_HKEY` AS `DIM_PATIENT_HKEY`
			, `SCD2_DIM_HUB_SRC2`.`SNAPSHOT__TIMESTAMP` AS `FILTER_SNAPSHOT_TIMESTAMP`
			, `SCD2_DIM_HUB_SRC2`.`END_SNAPSHOT__TIMESTAMP` AS `FILTER_END_SNAPSHOT_TIMESTAMP`
		FROM `HEALTHCARE_FL`.`HUB_PATIENT` `HUB_FK_SRC2`
		INNER JOIN `INFORMATION_MARTS`.`DIM_PATIENT` `SCD2_DIM_HUB_SRC2` ON  `HUB_FK_SRC2`.`PATIENT_HKEY` = `SCD2_DIM_HUB_SRC2`.`PATIENT_HKEY`
	)  `DVO_BASE2` ON  `DVO_BASE2`.`BASE_OBJECT_H_KEY` = `NHL`.`PATIENT_HKEY` AND `NHL`.`START` >= `DVO_BASE2`.`FILTER_SNAPSHOT_TIMESTAMP` AND 
		`NHL`.`START` < `DVO_BASE2`.`FILTER_END_SNAPSHOT_TIMESTAMP`
	INNER JOIN 	( 
		SELECT 
			  `HUB_FK_SRC3`.`ENCOUNTER_HKEY` AS `BASE_OBJECT_H_KEY`
			, `SCD2_DIM_HUB_SRC3`.`DIM_ENCOUNTER_HKEY` AS `DIM_ENCOUNTER_HKEY`
			, `SCD2_DIM_HUB_SRC3`.`SNAPSHOT__TIMESTAMP` AS `FILTER_SNAPSHOT_TIMESTAMP`
			, `SCD2_DIM_HUB_SRC3`.`END_SNAPSHOT__TIMESTAMP` AS `FILTER_END_SNAPSHOT_TIMESTAMP`
		FROM `HEALTHCARE_FL`.`HUB_ENCOUNTER` `HUB_FK_SRC3`
		INNER JOIN `INFORMATION_MARTS`.`DIM_ENCOUNTER` `SCD2_DIM_HUB_SRC3` ON  `HUB_FK_SRC3`.`ENCOUNTER_HKEY` = `SCD2_DIM_HUB_SRC3`.`ENCOUNTER_HKEY`
	)  `DVO_BASE3` ON  `DVO_BASE3`.`BASE_OBJECT_H_KEY` = `NHL`.`ENCOUNTER_HKEY` AND `NHL`.`START` >= `DVO_BASE3`.`FILTER_SNAPSHOT_TIMESTAMP` AND 
		`NHL`.`START` < `DVO_BASE3`.`FILTER_END_SNAPSHOT_TIMESTAMP`
	;

 