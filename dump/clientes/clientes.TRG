TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` trigger alta_clientes after insert on clientes for each row insert into altas(id,fecha_de_alta) values(NEW.id_cliente,now())'
sql_modes=0
definers='root@localhost'
client_cs_names='latin1'
connection_cl_names='latin1_swedish_ci'
db_cl_names='latin1_swedish_ci'
