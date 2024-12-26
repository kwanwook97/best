package com.best.attachment;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AttachmentController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AttachmentService attachmentService;
	
}
