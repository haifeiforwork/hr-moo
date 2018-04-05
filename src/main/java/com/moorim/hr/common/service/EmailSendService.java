package com.moorim.hr.common.service;

import com.moorim.hr.common.vo.EmailVO;

public interface EmailSendService {
	public int sendEmail( EmailVO vo );
}
