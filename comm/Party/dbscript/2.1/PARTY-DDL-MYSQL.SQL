ALTER TABLE PAT_PARTY ADD `KYC_HIGHLEVEL_AUTHORITY` char(1) DEFAULT 'N';


ALTER TABLE PAT_PARTY ADD WITHDRAW_LIMIT_AMOUNT double;
UPDATE PAT_PARTY SET WITHDRAW_LIMIT_AMOUNT = 0; 


ALTER TABLE PAT_PARTY ADD LOGIN_IP varchar(64) DEFAULT NULL;



ALTER TABLE PAT_PARTY ADD WITHDRAW_LIMIT_NOW_AMOUNT double;
UPDATE PAT_PARTY SET WITHDRAW_LIMIT_NOW_AMOUNT = 0; 



