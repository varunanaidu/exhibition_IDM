<?php if ( !defined('BASEPATH' ) )exit('No direct script access allowed');?>
<div id="content" style="padding:20px;background:#FCFCFC;">
	<center>  	
		<h2 style="font-family: sans-serif;">Selamat anda telah sukses terdaftar dalam acara Pameran City of ALL by ACCOR</h2>

		<div class="cardWrap">
			<?php 
			if ( isset($email['content']) and $email['content'] != 0 ) {
				foreach ($email['content'] as $row) {
					?>
					<div class="card cardLeft">
						<br/><h1>City of ALL</h1>
						<table>
							<tr>
								<td><h2><br/>Tanggal</h2></td>
								<td><h2><br/>:</h2></td>
								<td><h2><br/><?= date('d F Y H:i:s', strtotime($row->addon)) ?></h2></td>
							</tr>
							<tr>
								<td><h2>Name</h2></td>
								<td><h2>:</h2></td>
								<td><h2><?= $row->participant_name ?></h2></td>
							</tr>
							<tr>
								<td><h2>Email</h2></td>
								<td><h2>:</h2></td>
								<td><h2><?= $row->participant_email ?></h2></td>
							</tr>
							<tr>
								<td><h2>WhatsApp</h2></td>
								<td><h2>:</h2></td>
								<td><h2><?= $row->participant_wa ?></h2></td>
							</tr>
						</table>

					</div>
					<div class="card cardRight">
						<div class="logo"><img src="<?= base_url(); ?>assets/images/logoaccordputih.png"></div>
						<div class="qrcode">
							<img src="<?= base_url(); ?>assets/public/registran/<?= $row->participant_id ?>/<?= $row->participant_qr ?>">
							<h2><?= $row->participant_id ?></h2>
						</div>
					</div>

					<?php 
				}
			}
			?>
		</div>
		<div class="info">
			<h2><b>Harap tunjukan QR Code anda kepada petugas yang ada di gate dan di booth pameran</b></h2>
		</div>
		
	</center>
</div>