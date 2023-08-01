<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Registration extends MY_Controller {
	
	public function __construct()
	{
		parent::__construct();
		$this->select 		= '*';
		$this->from   		= 'view_registration';
		$this->order_by   	= ['addon'=>'DESC'];
		$this->order 		= ['registration_id', 'addon', 'participant_name', 'participant_wa', 'participant_email'];
		$this->search 		= ['registration_id', 'addon', 'participant_name', 'participant_wa', 'participant_email'];

	}

	public function index(){

		if (!$this->hasLogin()) {
			redirect('admin/site/login');
		}

		$this->fragment['js'] = [ 
			base_url('assets/js/pages/admin/registration.js') 
		];

		$this->fragment['pagename'] = 'admin/pages/registration.php';
		$this->load->view('admin/layout/main-site', $this->fragment);
	}

	public function view()
	{
		$filter = false;
		$start_date = $this->input->post('start_date');
		$end_date = $this->input->post('end_date');

		if ($start_date != '' && $end_date != '') {
			$filter = [
				'start_date' => $start_date,
				'end_date'   => $end_date,
			];
		}

		$data = array();
		$res = $this->sitemodel->get_datatable($this->select, $this->from, $this->order_by, $this->search, $this->order, $filter);
		$q = $this->db->last_query();
		$a = 1;

		foreach ($res as $row) {
			$col = array();
			// $col[] = '<button class="btn btn-danger btn-delete" data-id="'.$row->registration_id.'"><i class="fas fa-minus-circle"></i></button>';
			$col[] = ($row->is_choosen == 1 ? '<button class="btn btn-danger btn-unchoose" data-id="'.$row->registration_id.'"><i class="fas fa-check"></i></button>' : '<button class="btn btn-success btn-choose" data-id="'.$row->registration_id.'"><i class="fas fa-check"></i></button>');
			$col[] = '<span>'.$row->registration_id.'</br><img src="'.base_url().'assets/public/registran/'.$row->participant_id.'/'.$row->participant_qr.'"></span>'.'';
			$col[] = date('d F Y H:i:s', strtotime($row->addon));
			$col[] = $row->participant_name;
			$col[] = $row->participant_wa;
			$col[] = $row->participant_email;
			$col[] = $row->is_choosen;
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

	public function choose(){
		// echo json_encode($this->input->post());die;
		/*** Check Session ***/
		if ( !$this->hasLogin() ){$this->response['msg'] = "Session expired, Please refresh your browser.";echo json_encode($this->response);exit;}

		if ( $this->log_role != 'developer' ){$this->response['msg'] = "Maaf anda belum beruntung.";echo json_encode($this->response);exit;}
		/*** Check POST or GET ***/
		if ( !$_POST ){$this->response['msg'] = "Invalid parameters.";echo json_encode($this->response);exit;}
		/*** Params ***/
		/*** Required Area ***/
		$key = $this->input->post("key");
		/*** Optional Area ***/
		/*** Validate Area ***/
		if ( empty($key) ){$this->response['msg'] = "Invalid parameter.";echo json_encode($this->response);exit;}
		/*** Accessing DB Area ***/
		$check = $this->sitemodel->view($this->from, $this->select, ['registration_id'=>$key]);
		if (!$check) {$this->response['msg'] = "No data found.";echo json_encode($this->response);exit;}
		// Jadiin peserta terpilih
		$this->sitemodel->update('tr_registration', ['is_choosen'=>1], ['registration_id'=>$key]);
		/*** Result Area ***/
		$this->response['type'] = 'done';
		$this->response['msg'] = "Berhasil menjadikan peserta terpilih.";
		echo json_encode($this->response);
		exit;
	}

	public function unchoose(){
		// echo json_encode($this->input->post());die;
		/*** Check Session ***/
		if ( !$this->hasLogin() ){$this->response['msg'] = "Session expired, Please refresh your browser.";echo json_encode($this->response);exit;}

		if ( $this->log_role != 'developer' ){$this->response['msg'] = "Maaf anda belum beruntung.";echo json_encode($this->response);exit;}
		/*** Check POST or GET ***/
		if ( !$_POST ){$this->response['msg'] = "Invalid parameters.";echo json_encode($this->response);exit;}
		/*** Params ***/
		/*** Required Area ***/
		$key = $this->input->post("key");
		/*** Optional Area ***/
		/*** Validate Area ***/
		if ( empty($key) ){$this->response['msg'] = "Invalid parameter.";echo json_encode($this->response);exit;}
		/*** Accessing DB Area ***/
		$check = $this->sitemodel->view($this->from, $this->select, ['registration_id'=>$key]);
		if (!$check) {$this->response['msg'] = "No data found.";echo json_encode($this->response);exit;}
		// Jadiin peserta terpilih
		$this->sitemodel->update('tr_registration', ['is_choosen'=>0], ['registration_id'=>$key]);
		/*** Result Area ***/
		$this->response['type'] = 'done';
		$this->response['msg'] = "Berhasil menjadikan peserta terpilih.";
		echo json_encode($this->response);
		exit;
	}

	public function delete(){
		// echo json_encode($this->input->post());die;
		/*** Check Session ***/
		if ( !$this->hasLogin() ){$this->response['msg'] = "Session expired, Please refresh your browser.";echo json_encode($this->response);exit;}

		if ( $this->log_role != 'developer' ){$this->response['msg'] = "Maaf anda belum beruntung.";echo json_encode($this->response);exit;}
		/*** Check POST or GET ***/
		if ( !$_POST ){$this->response['msg'] = "Invalid parameters.";echo json_encode($this->response);exit;}
		/*** Params ***/
		/*** Required Area ***/
		$key = $this->input->post("key");
		/*** Optional Area ***/
		/*** Validate Area ***/
		if ( empty($key) ){$this->response['msg'] = "Invalid parameter.";echo json_encode($this->response);exit;}
		/*** Accessing DB Area ***/
		$check = $this->sitemodel->view($this->from, $this->select, ['participant_id'=>$key]);
		if (!$check) {$this->response['msg'] = "No data found.";echo json_encode($this->response);exit;}
		// Delete 
		$this->sitemodel->delete('tab_participants', ['participant_id'=>$key]);
		$this->sitemodel->delete('tr_registration', ['participant_id'=>$key]);
		/*** Result Area ***/
		$this->response['type'] = 'done';
		$this->response['msg'] = "Berhasil menghapus data.";
		unlink('assets/public/registran/'.$check[0]->participant_id.'/'.$check[0]->participant_qr);
		rmdir('assets/public/registran/'.$check[0]->participant_id);
		echo json_encode($this->response);
		exit;
	}
}
