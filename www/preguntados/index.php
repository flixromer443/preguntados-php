<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv='cache-control' content='no-cache'>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>PREGUNTADØS</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
</head>
<body class="hold-transition login-page">
<div class="login-box" id="response">
  <div class="login-logo">
     

      
    <a><b>PREGUNTADØS</b></a>
  </div>

  <!-- /.login-logo -->
</div>
<div class="card" id="response">

</div>

<button type="button" id="iniciar"  onclick="iniciar()" class="btn btn-outline-primary">Iniciar</button>
<button type="button" id="finalizar" style="display: none;" onclick="finalizar()" class="btn btn-outline-primary">Finalizar</button>
<script src="js/script.js"></script>
<footer>
<div class="row" id="checks" style="display: none;">
  <div class="col-sm-6">
    <input type="hidden" id="success" value="0">
    <button class="btn btn-success" style="border-radius: 40%; height:60px;"><i class="far fa-check-circle" style="font-size: 40px;"></i></button>
    <br>
    <h3 style="margin: auto; text-align:center;" id="correcto">0</h3>
  </div>
  <div class="col-sm-6">
  <input type="hidden" id="error" value="0">
    <button class="btn btn-danger" style="border-radius: 40%; height:60px;"><i class="far fa-times-circle" style="font-size: 40px;"></i></button>
    <h3 style="margin: auto; text-align:center;" id="incorrecto">0</h3>
  </div>
</div>

</footer>

<!-- /.login-box -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>
<!-- jquery-validation -->
<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="plugins/jquery-validation/additional-methods.min.js"></script>
     

<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="plugins/jquery-validation/additional-methods.min.js"></script>
</body>
</html>
