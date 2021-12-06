
function iniciar(){
    
    $.ajax({
        url:'services/provider.php',
        type:'POST',
        dataType:'JSON',
        data:{
          'email':1
        },
         
          
        
      }).then(function(datos){
          document.getElementById('iniciar').style.display="none"
          document.getElementById('response').innerHTML=datos
      
      })
      document.getElementById('checks').style.display="flex"
      return 0
}
function finalizar(){
    
    location.reload()
}
function activar(id){
   console.log(id)
   let state=document.getElementById(id).value
   console.log(state)
  
   
        if(state==0){
        document.getElementById(id).classList.remove("btn-outline-primary");
        document.getElementById(id).classList.add("btn-danger");
        document.getElementById(id).disabled=true;
        let fail=document.getElementById('error').value
        fail=parseInt(fail)
        let valor=document.getElementById('error').value=fail+1
        document.getElementById('incorrecto').innerHTML=valor
        let btns=document.getElementsByClassName("btn btn-outline-primary");
        for(let i=0; i<btns.length; i++){
            btns[i].disabled=true
        }
        setTimeout(function(){iniciar()},1500)
       }else{
        document.getElementById(id).classList.remove("btn-outline-primary");
        document.getElementById(id).classList.add("btn-success");
        document.getElementById(id).disabled=true
        let acert=document.getElementById('success').value
        acert=parseInt(acert)
        let valor=document.getElementById('success').value=acert+1
        document.getElementById('correcto').innerHTML=valor
        let btns=document.getElementsByClassName("btn btn-outline-primary");
        for(let i=0; i<btns.length; i++){
            btns[i].disabled=true
        }
        setTimeout(function(){iniciar()},1500)
       }
       let fail=document.getElementById('error').value
       fail=parseInt(fail) 
       let acert=document.getElementById('success').value
       acert=parseInt(acert)
       if(fail+acert==10){
        setTimeout(function(){document.getElementById('response').innerHTML='<div class="card-body login-card-body"><h3 class="login-box-msg">Resultados</h3><h4 style="margin: auto; text-align:center">'+acert+'/10</h4></div><br><p class="mb-1"></p></div>'
        document.getElementById('finalizar').style.display="block"
        document.getElementById('finalizar').disabled=false
        document.getElementById('checks').style.display="none"
    },1600)
       }
   
   
    
    
}