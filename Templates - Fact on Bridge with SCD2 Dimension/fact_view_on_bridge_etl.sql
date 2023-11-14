/*
 __     __          _ _                           _      __  ___  __   __   
 \ \   / /_ _ _   _| | |_ ___ ____   ___  ___  __| |     \ \/ _ \/ /  /_/   
  \ \ / / _` | | | | | __/ __|  _ \ / _ \/ _ \/ _` |      \/ / \ \/ /\      
   \ V / (_| | |_| | | |_\__ \ |_) |  __/  __/ (_| |      / / \/\ \/ /      
    \_/ \__,_|\__,_|_|\__|___/ .__/ \___|\___|\__,_|     /_/ \/_/\__/       
                             |_|                                            

Vaultspeed version: 5.5.0.14, generation date: 2023/11/09 12:39:44
DV_NAME: valipac_poc - Release: one time fix(10) - Comment:  - Release date: 2023/11/03 14:37:14, 
BV release: fact(3) - Comment:  - Release date: 2023/11/09 12:29:03, 
SRC_NAME: valipacpoc - Release: valipacpoc(10) - Comment: onetime - Release date: 2023/11/03 14:35:05
 */


CREATE  VIEW "information_marts"."fact_membership_onetime_material"  AS 
	WITH "dvo_base1" AS 
	( 
		SELECT 
			  "dvo_src1"."material_hkey" AS "base_object_h_key"
			, "scd2_dim_hub_src1"."dim_material_hkey" AS "dim_material_hkey"
			, "scd2_dim_hub_src1"."snapshot__timestamp" AS "filter_snapshot_timestamp"
			, "scd2_dim_hub_src1"."end_snapshot__timestamp" AS "filter_end_snapshot_timestamp"
		FROM "valipacpoc_fl"."hub_material" "dvo_src1"
		INNER JOIN "information_marts"."dim_material" "scd2_dim_hub_src1" ON  "dvo_src1"."material_hkey" = "scd2_dim_hub_src1"."material_hkey"
	)
	, "dvo_base3" AS 
	( 
		SELECT 
			  "dvo_src3"."packaging_hkey" AS "base_object_h_key"
			, "scd2_dim_hub_src3"."dim_packaging_hkey" AS "dim_packaging_hkey"
			, "scd2_dim_hub_src3"."snapshot__timestamp" AS "filter_snapshot_timestamp"
			, "scd2_dim_hub_src3"."end_snapshot__timestamp" AS "filter_end_snapshot_timestamp"
		FROM "valipacpoc_fl"."hub_packaging" "dvo_src3"
		INNER JOIN "information_marts"."dim_packaging" "scd2_dim_hub_src3" ON  "dvo_src3"."packaging_hkey" = "scd2_dim_hub_src3"."packaging_hkey"
	)
	, "dvo_base5" AS 
	( 
		SELECT 
			  "dvo_src5"."onetimepackaging_hkey" AS "base_object_h_key"
			, "scd2_dim_hub_src5"."dim_onetimepackaging_hkey" AS "dim_onetimepackaging_hkey"
			, "scd2_dim_hub_src5"."snapshot__timestamp" AS "filter_snapshot_timestamp"
			, "scd2_dim_hub_src5"."end_snapshot__timestamp" AS "filter_end_snapshot_timestamp"
		FROM "valipacpoc_fl"."hub_onetimepackaging" "dvo_src5"
		INNER JOIN "information_marts"."dim_onetimepackaging" "scd2_dim_hub_src5" ON  "dvo_src5"."onetimepackaging_hkey" = "scd2_dim_hub_src5"."onetimepackaging_hkey"
	)
	, "dvo_base7" AS 
	( 
		SELECT 
			  "dvo_src7"."packagings_hkey" AS "base_object_h_key"
			, "scd2_dim_hub_src7"."dim_packagings_hkey" AS "dim_packagings_hkey"
			, "scd2_dim_hub_src7"."snapshot__timestamp" AS "filter_snapshot_timestamp"
			, "scd2_dim_hub_src7"."end_snapshot__timestamp" AS "filter_end_snapshot_timestamp"
		FROM "valipacpoc_fl"."hub_packagings" "dvo_src7"
		INNER JOIN "information_marts"."dim_packagings" "scd2_dim_hub_src7" ON  "dvo_src7"."packagings_hkey" = "scd2_dim_hub_src7"."packagings_hkey"
	)
	, "dvo_base9" AS 
	( 
		SELECT 
			  "dvo_src9"."declaration_hkey" AS "base_object_h_key"
			, "scd2_dim_hub_src9"."dim_declaration_hkey" AS "dim_declaration_hkey"
			, "scd2_dim_hub_src9"."snapshot__timestamp" AS "filter_snapshot_timestamp"
			, "scd2_dim_hub_src9"."end_snapshot__timestamp" AS "filter_end_snapshot_timestamp"
		FROM "valipacpoc_fl"."hub_declaration" "dvo_src9"
		INNER JOIN "information_marts"."dim_declaration" "scd2_dim_hub_src9" ON  "dvo_src9"."declaration_hkey" = "scd2_dim_hub_src9"."declaration_hkey"
	)
	, "dvo_base11" AS 
	( 
		SELECT 
			  "dvo_src11"."membership_hkey" AS "base_object_h_key"
			, "scd2_dim_hub_src11"."dim_membership_hkey" AS "dim_membership_hkey"
			, "scd2_dim_hub_src11"."snapshot__timestamp" AS "filter_snapshot_timestamp"
			, "scd2_dim_hub_src11"."end_snapshot__timestamp" AS "filter_end_snapshot_timestamp"
		FROM "valipacpoc_fl"."hub_membership" "dvo_src11"
		INNER JOIN "information_marts"."dim_membership" "scd2_dim_hub_src11" ON  "dvo_src11"."membership_hkey" = "scd2_dim_hub_src11"."membership_hkey"
	)
	SELECT 
		  "dvo_base1"."dim_material_hkey" AS "dim_material_hkey"
		, "dvo_base3"."dim_packaging_hkey" AS "dim_packaging_hkey"
		, "dvo_base5"."dim_onetimepackaging_hkey" AS "dim_onetimepackaging_hkey"
		, "dvo_base7"."dim_packagings_hkey" AS "dim_packagings_hkey"
		, "dvo_base9"."dim_declaration_hkey" AS "dim_declaration_hkey"
		, "dvo_base11"."dim_membership_hkey" AS "dim_membership_hkey"
		, "fact_on_bridge_scd2_sat_selection"."materiaal_id" AS "materiaal_id"
		, "fact_on_bridge_scd2_sat_selection"."verpakkingsgraad" AS "verpakkingsgraad"
		, "fact_on_bridge_scd2_sat_selection"."gewicht" AS "gewicht"
		, "fact_on_bridge_scd2_sat_selection"."declaratie_id" AS "declaratie_id"
	FROM "valipacpoc_bv"."bridge_membership_onetime_material" "bridge"
	INNER JOIN "valipacpoc_fl"."sat_dec_onetimepackaging" "fact_on_bridge_scd2_sat_selection" ON  "fact_on_bridge_scd2_sat_selection"."onetimepackaging_hkey" = "bridge"."onetimepackaging_hkey"
	INNER JOIN "dvo_base1" "dvo_base1" ON  "dvo_base1"."base_object_h_key" = "bridge"."material_hkey"
	INNER JOIN "dvo_base3" "dvo_base3" ON  "dvo_base3"."base_object_h_key" = "bridge"."packaging_hkey"
	INNER JOIN "dvo_base5" "dvo_base5" ON  "dvo_base5"."base_object_h_key" = "bridge"."onetimepackaging_hkey"
	INNER JOIN "dvo_base7" "dvo_base7" ON  "dvo_base7"."base_object_h_key" = "bridge"."packagings_hkey"
	INNER JOIN "dvo_base9" "dvo_base9" ON  "dvo_base9"."base_object_h_key" = "bridge"."declaration_hkey"
	INNER JOIN "dvo_base11" "dvo_base11" ON  "dvo_base11"."base_object_h_key" = "bridge"."membership_hkey"
	;

 