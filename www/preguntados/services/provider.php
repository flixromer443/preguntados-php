<?php
        include("../config/config.php");

    $permited_chars='1234';
    $seccion=substr(str_shuffle($permited_chars),0,1);
    //seccion
    //$permited_chars='123456789';
    $permited_chars='1234';
    $pregunta=substr(str_shuffle($permited_chars),0,1);
    $query="select * from secciones as s inner join preguntas as p on s.id=p.id_seccion where s.id='$seccion' and p.id_pregunta='$pregunta'";
    $res=mysqli_query($link,$query);
    $result=mysqli_fetch_array($res);
    $id_seccion=$result[3];
    $id_pregunta=$result[4];
    $query="select * from respuestas where id_seccion='$id_seccion' and id_pregunta='$id_pregunta'";
    $res=mysqli_query($link,$query);
    
    switch($result[0]){
      case $result[0]==1:
        $response.='  
        <h3 class="login-box-msg bg-warning" style="padding:20px;20px;20px;20px;" >
        <i class="fas fa-chess-rook"></i> '.$result[1].'</h3>';
      break;
      case $result[0]==2:
        $response.='  
        <h3 class="login-box-msg bg-primary" style="padding:20px;20px;20px;20px;" >
        <i class="fas fa-calculator"></i> '.$result[1].'</h3>';
      break;
      case $result[0]==3:
        $response.='  
        <h3 class="login-box-msg bg-danger" style="padding:20px;20px;20px;20px;" >
        <i class="fas fa-football-ball"></i> '.$result[1].'</h3>';
      break;
      case $result[0]==4:
        $response.='  
        <h3 class="login-box-msg bg-info" style="padding:20px;20px;20px;20px;" >
        <i class="fas fa-globe-europe"></i> '.$result[1].'</h3>';
      break; 
    }
      $response.='<div class="card-body login-card-body">
      <h4>'.$result[6].'</h4>';
      if($result[5]!=null){
         $response.='<img src="images/'.$result[5].'" style="width:120px; height:120px;" alt="" ><br><br>';
      }
        
          while($row=mysqli_fetch_array($res)){
            
            $response.= '<button type="button" id="'.$row[0].'" value="'.$row[4].'" onclick="activar('.$row[0].')" class="btn btn-outline-primary">'.$row[3].'</button><br><br>';
          }
        
        

      $response.='</div><br>
      <p class="mb-1">
      </p>
    </div>
  ';
  echo json_encode($response);




    
?>