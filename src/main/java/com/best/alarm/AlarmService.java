package com.best.alarm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AlarmService {
	
	@Autowired AlarmDAO alarmDAO;

	public List<AlarmDTO> alarmList(int emp_idx, String type, Integer flag) {
	    return alarmDAO.alarmList(emp_idx, type, flag);
	}

}
