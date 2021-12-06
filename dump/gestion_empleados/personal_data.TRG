TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`%` TRIGGER `create_data_of_user` AFTER INSERT ON `personal_data` FOR EACH ROW insert into users(id,personal_data_id,working_information_id) values(NEW.id,NEW.id,NEW.id)' 'CREATE DEFINER=`root`@`%` TRIGGER `create_working_information` AFTER INSERT ON `personal_data` FOR EACH ROW insert into working_information(id,fecha_de_contratacion) values(NEW.id,NOW())'
sql_modes=1436549152 1436549152
definers='root@%' 'root@%'
client_cs_names='utf8mb4' 'utf8mb4'
connection_cl_names='utf8mb4_unicode_ci' 'utf8mb4_unicode_ci'
db_cl_names='latin1_swedish_ci' 'latin1_swedish_ci'
created=163027169823 163027174365
