<?php defined('BASEPATH') OR exit('No direct script access allowed');?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="x-ua-compatible" content="ie=edge">

	<title>GRANDPRIZE HUT METRO 21</title>

	<!-- Font Awesome Icons -->
	<link rel="stylesheet" href="<?= base_url(); ?>assets/adminlte3/plugins/fontawesome-free/css/all.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="<?= base_url(); ?>assets/adminlte3/dist/css/AdminLTE.min.css">
	<!-- Google Font: Source Sans Pro -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

	<style>
		.content-wrapper{
			background-image: url('<?= base_url(); ?>assets/images/sepedagunung.png');
			background-size: 100% 100%;
			background-repeat: no-repeat;
			width: 720px;
			height: 1080px;
			position: center;
			margin: 0 auto !important;
		}
		.card-footer{
			background-color: #6a4d8f;
			border-radius: 20px;
			margin-top: -50px;
			max-width: 360px;
			margin: 0 auto;
			padding-bottom: 0px;
		}
	</style>

	<link rel="stylesheet" href="<?= base_url(); ?>assets/css/style.css">
</head>
<body class="hold-transition layout-top-nav">
	<div class="wrapper">
		<div class="content-wrapper">
			<div class="content">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<div class="card" id="result-container" style="margin-top: 350px;text-align: center;">
								<!-- <div class="card-body">
									<img id="giftContainer" src="<?= base_url(); ?>assets/images/gift/gift1.png" style="width: 500px;">
								</div> -->
								
								<div class="row">
									<div class="card-footer">
										<h1><span id="name_result4"></span></h1><br>
										<h2><span id="email_result4"></span></h2><br>
									</div>
									<div class="card-footer">
										<h1><span id="name_result5"></span></h1><br>
										<h2><span id="email_result5"></span></h2><br>
									</div>
								</div>
								<div class="row">
									<div class="card-footer">
										<h1><span id="name_result"></span></h1><br>
										<h2><span id="email_result"></span></h2><br>
									</div>
									<div class="card-footer">
										<h1><span id="name_result2"></span></h1><br>
										<h2><span id="email_result2"></span></h2><br>
									</div>
									<div class="card-footer">
										<h1><span id="name_result3"></span></h1><br>
										<h2><span id="email_result3"></span></h2><br>
									</div>
								</div>
								<div class="row">
									<div class="card-footer">
										<h1><span id="name_result6"></span></h1><br>
										<h2><span id="email_result6"></span></h2><br>
									</div>
									<div class="card-footer">
										<h1><span id="name_result7"></span></h1><br>
										<h2><span id="email_result7"></span></h2><br>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row collapse">
					<div class="form-group col-lg-2">
						<select class="form-control" id="gift_id" name="gift_id" >
							<!-- <option value="">-- Pilih Hadiah --</option> -->
							<?php 
							if (isset($gift) and $gift != '0') {
								foreach ($gift as $row) {
									?>
									<option value="<?= $row->gift_id ?>" data-text="<?= $row->gift_name ?>" data-image="<?= $row->gift_file ?>" <?= ( $row->gift_id == 2 ? 'selected' : '' ) ?> ><?= $row->gift_name ?></option>
									<?php 
								}
							}
							?>
						</select>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- REQUIRED SCRIPTS -->
	<script>var base_url = "<?php echo base_url()?>";</script>
	<!-- jQuery -->
	<script src="<?= base_url(); ?>assets/adminlte3/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script src="<?= base_url(); ?>assets/adminlte3/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE App -->
	<script src="<?= base_url(); ?>assets/adminlte3/dist/js/adminlte.min.js"></script>
	<!-- MAIN -->
	<script src="https://js.pusher.com/7.0/pusher.min.js"></script>
	<script src="<?= base_url(); ?>assets/js/pages/grandprize2.js"></script>

</body>
</html>