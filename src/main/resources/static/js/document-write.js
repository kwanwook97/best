var editor2cfg = {}
	//define toolbarfactory_btnname to create your self button
	editor2cfg.toolbarfactory_mybutton_b = function (cmd, suffix) {
		var btn = document.createElement("button");
		btn.innerHTML = "button_b"
		btn.className = "btn btn-primary";
		btn.style.cssText = "height:32px;margin:2px;padding:0px 5px";
		btn.onclick = function () {
			console.log("my button clicked");
			var p = editor2.insertRootParagraph("p");
			p.innerHTML = "You clicked mybutton_b";
			alert(p.innerHTML);
			return false;
		}
		return btn;
	}
	editor2cfg.toolbar = "mytoolbar";
	editor2cfg.toolbar_mytoolbar = "{bold,italic}|{fontname,fontsize}|{forecolor,backcolor}|removeformat|mybutton_b"
		+ "#{undo,redo,fullscreenenter,fullscreenexit,togglemore}";
	var editor2 = new RichTextEditor("#div_editor2", editor2cfg);
