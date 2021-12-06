TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER `delete_id_dp` AFTER DELETE ON `users` FOR EACH ROW delete from personal_data where id=old.personal_data_id' 'CREATE DEFINER=`root`@`localhost` TRIGGER `delete_id_il` AFTER DELETE ON `users` FOR EACH ROW delete from working_information where id=old.working_information_id'
sql_modes=1436549152 1436549152
definers='root@localhost' 'root@localhost'
client_cs_names='utf8mb4' 'utf8mb4'
connection_cl_names='utf8mb4_unicode_ci' 'utf8mb4_unicode_ci'
db_cl_names='latin1_swedish_ci' 'latin1_swedish_ci'
created=162846865831 162846868869
