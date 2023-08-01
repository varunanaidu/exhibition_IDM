<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Booth extends MY_Controller {
	
	public function __construct()
	{
		parent::__construct();
		$this->select 		= '*';
		$this->from   		= 'view_booth_attendance';
		$this->order_by   	= ['attendance_date'=>'DESC'];
		$this->order 		= ['','registration_id', 'attendance_date', 'participant_name', 'participant_wa', 'participant_email'];
		$this->search 		= ['','registration_id', 'attendance_date', 'participant_name', 'participant_wa', 'participant_email'];

	}

	public function one(){

		if (!$this->hasLogin()) {
			redirect('admin/site/login');
		}

		$this->fragment['js'] = [ 
			base_url('assets/js/pages/admin/booth/one.js') 
		];

		$booth_number = $this->sitemodel->view('tab_booth', '*', ['booth_id'=>1]);
		$this->fragment['booth_number'] = $booth_number[0]->booth_number;

		$this->fragment['pagename'] = 'admin/pages/booth/one.php';
		$this->load->view('admin/layout/main-site', $this->fragment);
	}

	public function two(){

		if (!$this->hasLogin()) {
			redirect('admin/site/login');
		}

		$this->fragment['js'] = [ 
			base_url('assets/js/pages/admin/booth/two.js') 
		];

		$booth_number = $this->sitemodel->view('tab_booth', '*', ['booth_id'=>2]);
		$this->fragment['booth_number'] = $booth_number[0]->booth_number;

		$this->fragment['pagename'] = 'admin/pages/booth/two.php';
		$this->load->view('admin/layout/main-site', $this->fragment);
	}

	public function three(){

		if (!$this->hasLogin()) {
			redirect('admin/site/login');
		}

		$this->fragment['js'] = [ 
			base_url('assets/js/pages/admin/booth/three.js') 
		];

		$booth_number = $this->sitemodel->view('tab_booth', '*', ['booth_id'=>3]);
		$this->fragment['booth_number'] = $booth_number[0]->booth_number;

		$this->fragment['pagename'] = 'admin/pages/booth/three.php';
		$this->load->view('admin/layout/main-site', $this->fragment);
	}

	public function four(){

		if (!$this->hasLogin()) {
			redirect('admin/site/login');
		}

		$this->fragment['js'] = [ 
			base_url('assets/js/pages/admin/booth/four.js') 
		];

		$booth_number = $this->sitemodel->view('tab_booth', '*', ['booth_id'=>4]);
		$this->fragment['booth_number'] = $booth_number[0]->booth_number;

		$this->fragment['pagename'] = 'admin/pages/booth/four.php';
		$this->load->view('admin/layout/main-site', $this->fragment);
	}

	public function five(){

		if (!$this->hasLogin()) {
			redirect('admin/site/login');
		}

		$this->fragment['js'] = [ 
			base_url('assets/js/pages/admin/booth/five.js') 
		];

		$booth_number = $this->sitemodel->view('tab_booth', '*', ['booth_id'=>5]);
		$this->fragment['booth_number'] = $booth_number[0]->booth_number;

		$this->fragment['pagename'] = 'admin/pages/booth/five.php';
		$this->load->view('admin/layout/main-site', $this->fragment);
	}

	public function six(){

		if (!$this->hasLogin()) {
			redirect('admin/site/login');
		}

		$this->fragment['js'] = [ 
			base_url('assets/js/pages/admin/booth/six.js') 
		];

		$booth_number = $this->sitemodel->view('tab_booth', '*', ['booth_id'=>6]);
		$this->fragment['booth_number'] = $booth_number[0]->booth_number;

		$this->fragment['pagename'] = 'admin/pages/booth/six.php';
		$this->load->view('admin/layout/main-site', $this->fragment);
	}

	public function seven(){

		if (!$this->hasLogin()) {
			redirect('admin/site/login');
		}

		$this->fragment['js'] = [ 
			base_url('assets/js/pages/admin/booth/seven.js') 
		];

		$booth_number = $this->sitemodel->view('tab_booth', '*', ['booth_id'=>7]);
		$this->fragment['booth_number'] = $booth_number[0]->booth_number;

		$this->fragment['pagename'] = 'admin/pages/booth/seven.php';
		$this->load->view('admin/layout/main-site', $this->fragment);
	}

	public function eight(){

		if (!$this->hasLogin()) {
			redirect('admin/site/login');
		}

		$this->fragment['js'] = [ 
			base_url('assets/js/pages/admin/booth/eight.js') 
		];

		$booth_number = $this->sitemodel->view('tab_booth', '*', ['booth_id'=>8]);
		$this->fragment['booth_number'] = $booth_number[0]->booth_number;

		$this->fragment['pagename'] = 'admin/pages/booth/eight.php';
		$this->load->view('admin/layout/main-site', $this->fragment);
	}

	public function nine(){

		if (!$this->hasLogin()) {
			redirect('admin/site/login');
		}

		$this->fragment['js'] = [ 
			base_url('assets/js/pages/admin/booth/nine.js') 
		];

		$booth_number = $this->sitemodel->view('tab_booth', '*', ['booth_id'=>9]);
		$this->fragment['booth_number'] = $booth_number[0]->booth_number;

		$this->fragment['pagename'] = 'admin/pages/booth/nine.php';
		$this->load->view('admin/layout/main-site', $this->fragment);
	}

	public function view()
	{
		// echo json_encode($this->input->post());die;
		$flag = $this->input->post('flag');
		$start_date = $this->input->post('start_date');
		$end_date = $this->input->post('end_date');

		$filter = [
			'flag' => $flag
		];

		if ($start_date != '' && $end_date != '') {
			$filter['start_date_attendance'] = $start_date;
			$filter['end_date_attendance']   = $end_date;
		}

		$data = array();
		$res = $this->sitemodel->get_datatable($this->select, $this->from, $this->order_by, $this->search, $this->order, $filter);
		$q = $this->db->last_query();
		$a = 1;

		foreach ($res as $row) {
			$col = array();
			// $col[] = '<button class="btn btn-danger btn-delete" data-id="'.$row->registration_id.'"><i class="fas fa-minus-circle"></i></button>';

			$col[] = '';
			$col[] = '<span>'.$row->registration_id.'</br><img src="'.base_url().'assets/public/registran/'.$row->participant_id.'/'.$row->participant_qr.'"></span>'.'';
			$col[] = $row->participant_name;
			$col[] = $row->participant_wa;
			$col[] = $row->participant_email;
			$col[] = date('d F Y H:i:s', strtotime($row->attendance_date));
			$data[] = $col;
			$a++;
		}
		$output = array(
			"draw" 				=> $_POST['draw'],
			"recordsTotal" 		=> $this->sitemodel->get_datatable_count_all($this->from),
			"recordsFiltered" 	=> $this->sitemodel->get_datatable_count_filtered($this->select, $this->from, $this->order_by, $this->search, $this->order, $filter),
			"data" 				=> $data,
			"q"					=> $q

		);
		echo json_encode($output);
		exit;
	}
}
