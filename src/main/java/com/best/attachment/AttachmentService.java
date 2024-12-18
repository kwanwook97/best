package com.best.attachment;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


@Service
public class AttachmentService {
	@Autowired AttachmentDAO attachmentDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	@Value("${upload.path}") private String bpath;

}
