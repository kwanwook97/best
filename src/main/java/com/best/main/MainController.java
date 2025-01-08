package com.best.main;

import java.util.HashMap; 
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.best.calendar.CalendarService;
import com.best.calendar.HolidayDTO;
import com.best.emp.EmployeeService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MainController {
	@Autowired EmployeeService empService;
	@Autowired CalendarService calendarService;
	
	@GetMapping(value="/main.go")
	public String main(HttpSession session,Model model) {
		
        List<HolidayDTO> holidays = calendarService.getAllHolidays(); 
        Map<String, Object> specialDays = new HashMap<>();
        for (HolidayDTO holiday : holidays) {
            specialDays.put(holiday.getHoliday_date().toString(), holiday.getHoliday_name());
        }
        ObjectMapper objectMapper = new ObjectMapper();
        try {
			String specialDaysJson = objectMapper.writeValueAsString(specialDays);
	        model.addAttribute("specialDaysJson", specialDaysJson);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
	    model.addAttribute("specialDays", specialDays);
		
		return "main/main";
	}
	
	@GetMapping(value = "/empDetail.ajax")
	@ResponseBody
	public Map<String, Object> getEmpDetail(@RequestParam("emp_idx") String empIdx) {
	    return empService.empDetail(empIdx);
	}

}
