<?php defined('BASEPATH') OR exit('No direct script access allowed');?>
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
	</div>

	<!-- Content Row -->
	<div class="row">

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-primary shadow h-100 py-2"><a class="collapse-item" href="<?= base_url('admin/registration') ?>">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total Pendaftar</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800"><?= $registration ?></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
						</div>
					</div>
				</div></a>
			</div>
		</div>

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-success shadow h-100 py-2"><a class="collapse-item" href="<?= base_url('admin/registration') ?>">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-success text-uppercase mb-1">Pendaftar Hari 1</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800"><?= $attendance_one ?></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
						</div>
					</div>
				</div></a>
			</div>
		</div>

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-info shadow h-100 py-2"><a class="collapse-item" href="<?= base_url('admin/registration') ?>">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-info text-uppercase mb-1">Pendaftar Hari 2</div>
							<div class="row no-gutters align-items-center">
								<div class="col-auto">
									<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"><?= $attendance_two ?></div>
								</div>
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
						</div>
					</div>
				</div></a>
			</div>
		</div>

		<!-- Pending Requests Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-warning shadow h-100 py-2"><a class="collapse-item" href="<?= base_url('admin/registration') ?>">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Pendaftar Hari 3</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800"><?= $attendance_three ?></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
						</div>
					</div>
				</div></a>
			</div>
		</div>
	</div>

	<div class="row">

		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-primary shadow h-100 py-2"><a class="collapse-item" href="<?= base_url('admin/registration') ?>">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Pendaftar Hari 4</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800"><?= $attendance_four ?></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
						</div>
					</div>
				</div></a>
			</div>
		</div>

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-success shadow h-100 py-2"><a class="collapse-item" href="<?= base_url('admin/registration') ?>">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-success text-uppercase mb-1">Pendaftar Hari 5</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800"><?= $attendance_five ?></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
						</div>
					</div>
				</div></a>
			</div>
		</div>

	</div>


	<div class="row">
		
		<div class="col-xl-12 mb-4">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Pengunjung Booth</div>
							<table class="table">
							 
							<?php 
							if ( isset($pengunjung) and $pengunjung != 0 ) {
								for ($i=0; $i < sizeof($pengunjung); $i++) { 
									?>
									<tr>
										<th><?= $pengunjung[$i]['booth_number'] ?></th>
										<td><?= $pengunjung[$i]['total'] ?></td>
									</tr>
									<?php
								}
							}
							?>							
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /.container-fluid -->