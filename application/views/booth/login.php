<?php defined('BASEPATH') OR exit('No direct script access allowed');?>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>LOGIN - BOOTH</title>

  <!-- Custom fonts for this template-->
  <link href="<?= base_url(); ?>assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="<?= base_url(); ?>assets/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

  <div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-6 col-md-9">

        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-12">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Login</h1>
                  </div>
                  <form class="user" id="loginForm" method="POST">
                    <div class="form-group">
                      <select class="form-control form-control-user" id="booth_id" name="booth_id">
                        <option value=""> Pilih Booth </option>
                        <?php 
                        if ( isset($booth) AND $booth != 0 ) {
                          foreach ($booth as $row) {
                        ?>
                        <option value="<?= $row->booth_id ?>"><?= $row->booth_number ?></option>
                        <?php 
                          }
                        }
                         ?>
                      </select>
                    </div>
                    <!-- <div class="form-group">
                      <input type="text" name="user_name" class="form-control form-control-user" id="exampleInputEmail" aria-describedby="emailHelp" placeholder="Enter Username">
                    </div>
                    <div class="form-group">
                      <input type="password"  name="user_pass"class="form-control form-control-user" id="exampleInputPassword" placeholder="Password">
                    </div> -->
                    <button type="submit" class="btn btn-primary btn-user btn-block" id="btnLogin">Login</button>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>

  <script type="text/javascript">var base_url = '<?= base_url(); ?>booth/'</script>
  <!-- Bootstrap core JavaScript-->
  <script src="<?= base_url(); ?>assets/vendor/jquery/jquery.min.js"></script>
  <script src="<?= base_url(); ?>assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="<?= base_url(); ?>assets/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="<?= base_url(); ?>assets/js/sb-admin-2.min.js"></script>

  <script type="text/javascript">
    $( function () {

      $('#loginForm').on('submit', function(event) {
        event.preventDefault();
        
        $.ajax({
          url : base_url + 'site/signin',
          type : 'POST',
          dataType: 'JSON',
          data : $(this).serialize(),
          success : function (data) {
            if ( data.type == 'done' ) {
              window.location.href = base_url;
            }else{
              alert(data.msg);
            }
          }
        });
      });
      
    });
  </script>

</body>

</html>
