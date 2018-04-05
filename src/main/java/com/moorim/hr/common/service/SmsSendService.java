package com.moorim.hr.common.service;

import com.moorim.hr.common.vo.SmsVO;

public interface SmsSendService {
	public int sendSms( SmsVO vo );
}
