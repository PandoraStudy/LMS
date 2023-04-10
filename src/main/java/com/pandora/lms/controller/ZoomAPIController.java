package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ZoomAPIController {

    @GetMapping("/zoom")
    public String index() {
        return "zoom";
    }

}
