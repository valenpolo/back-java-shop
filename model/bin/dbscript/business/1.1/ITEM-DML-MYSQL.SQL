
INSERT INTO `SCT_RESOURCE` (`UUID`, `RES_STRING`, `RES_TYPE`)
VALUES 
('URL_ADMIN_ITEM_ADD', '/normal/adminItemAction!add.action*', 'URL');
INSERT INTO `SCT_ROLE_RESOURCE` (`ROLE_UUID`,`RESOURCE_UUID`)
VALUES 
('SECURITY_ROLE_ROOT', 'URL_ADMIN_ITEM_ADD');
INSERT INTO `SCT_ROLE_RESOURCE` (`ROLE_UUID`,`RESOURCE_UUID`)
VALUES 
('SECURITY_ROLE_ADMIN', 'URL_ADMIN_ITEM_ADD');


INSERT INTO `SCT_RESOURCE` (`UUID`, `RES_STRING`, `RES_TYPE`)
VALUES 
('URL_ADMIN_ITEM_UPDATE', '/normal/adminItemAction!update.action*', 'URL');
INSERT INTO `SCT_ROLE_RESOURCE` (`ROLE_UUID`,`RESOURCE_UUID`)
VALUES 
('SECURITY_ROLE_ROOT', 'URL_ADMIN_ITEM_UPDATE');
INSERT INTO `SCT_ROLE_RESOURCE` (`ROLE_UUID`,`RESOURCE_UUID`)
VALUES 
('SECURITY_ROLE_ADMIN', 'URL_ADMIN_ITEM_UPDATE');


INSERT INTO `SCT_RESOURCE` (`UUID`, `RES_STRING`, `RES_TYPE`)
VALUES 
('URL_ADMIN_ITEM_ORDER_OPEN', '/normal/adminItemAction!order_open.action*', 'URL');
INSERT INTO `SCT_ROLE_RESOURCE` (`ROLE_UUID`,`RESOURCE_UUID`)
VALUES 
('SECURITY_ROLE_ROOT', 'URL_ADMIN_ITEM_ORDER_OPEN');
INSERT INTO `SCT_ROLE_RESOURCE` (`ROLE_UUID`,`RESOURCE_UUID`)
VALUES 
('SECURITY_ROLE_ADMIN', 'URL_ADMIN_ITEM_ORDER_OPEN');


INSERT INTO `SCT_RESOURCE` (`UUID`, `RES_STRING`, `RES_TYPE`)
VALUES 
('URL_ADMIN_ITEMLEVERAGE_ADD', '/normal/adminItemLeverageAction!add.action*', 'URL');
INSERT INTO `SCT_ROLE_RESOURCE` (`ROLE_UUID`,`RESOURCE_UUID`)
VALUES 
('SECURITY_ROLE_ROOT', 'URL_ADMIN_ITEMLEVERAGE_ADD');
INSERT INTO `SCT_ROLE_RESOURCE` (`ROLE_UUID`,`RESOURCE_UUID`)
VALUES 
('SECURITY_ROLE_ADMIN', 'URL_ADMIN_ITEMLEVERAGE_ADD');


INSERT INTO `SCT_RESOURCE` (`UUID`, `RES_STRING`, `RES_TYPE`)
VALUES 
('URL_ADMIN_ITEMLEVERAGE_DELETE', '/normal/adminItemLeverageAction!delete.action*', 'URL');
INSERT INTO `SCT_ROLE_RESOURCE` (`ROLE_UUID`,`RESOURCE_UUID`)
VALUES 
('SECURITY_ROLE_ROOT', 'URL_ADMIN_ITEMLEVERAGE_DELETE');
INSERT INTO `SCT_ROLE_RESOURCE` (`ROLE_UUID`,`RESOURCE_UUID`)
VALUES 
('SECURITY_ROLE_ADMIN', 'URL_ADMIN_ITEMLEVERAGE_DELETE');
