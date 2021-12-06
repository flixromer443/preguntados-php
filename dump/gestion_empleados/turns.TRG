TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`%` TRIGGER `create_schedules` AFTER INSERT ON `turns` FOR EACH ROW INSERT INTO schedules(turn_id) VALUES(NEW.id)' 'CREATE DEFINER=`root`@`%` TRIGGER `delete_schedules` AFTER DELETE ON `turns` FOR EACH ROW DELETE FROM schedules WHERE turn_id=OLD.id' 'CREATE DEFINER=`root`@`%` TRIGGER `delete_turn_id` AFTER DELETE ON `turns` FOR EACH ROW UPDATE working_information SET id_turno=0 WHERE id_turno=OLD.id'
sql_modes=1436549152 1436549152 1436549152
definers='root@%' 'root@%' 'root@%'
client_cs_names='utf8mb4' 'utf8mb4' 'utf8mb4'
connection_cl_names='utf8mb4_unicode_ci' 'utf8mb4_unicode_ci' 'utf8mb4_unicode_ci'
db_cl_names='latin1_swedish_ci' 'latin1_swedish_ci' 'latin1_swedish_ci'
created=163088612635 163052495992 163053727975
