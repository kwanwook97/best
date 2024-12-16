package com.best.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
@Controller
public class MainController {
	@GetMapping(value="/")
	public String main() {
		return "main/main";
	}
	@GetMapping(value="/{page}.go")
	public String pageMove(@PathVariable String page) {
		return page;
	}
	@GetMapping(value="/{root}/{page}.go")
	public String pageMove(@PathVariable String root, @PathVariable String page) {
		return root+"/"+page;
	}
	/*
	 * @GetMapping(value="/{root}/{sub}/{page}.go") public String
	 * pageMove(@PathVariable String root, @PathVariable String sub, @PathVariable
	 * String page) { return root+"/"+sub+"/"+page; }
	 */
}
