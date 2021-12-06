TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`%` TRIGGER `checkin` AFTER INSERT ON `presentismo` FOR EACH ROW INSERT INTO temp(id_presentismo,id_usuario) VALUES(NEW.id,NEW.id_usuario)' 'CREATE DEFINER=`root`@`%` TRIGGER `checkout` AFTER UPDATE ON `presentismo` FOR EACH ROW delete from temp WHERE id_presentismo=OLD.id'
sql_modes=1436549152 1436549152
definers='root@%' 'root@%'
client_cs_names='utf8mb4' 'utf8mb4'
connection_cl_names='utf8mb4_unicode_ci' 'utf8mb4_unicode_ci'
db_cl_names='latin1_swedish_ci' 'latin1_swedish_ci'
created=163028736234 163028862151
