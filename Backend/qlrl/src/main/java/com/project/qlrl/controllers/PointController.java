package com.project.qlrl.controllers;

import com.project.qlrl.services.PointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class PointController {
    @Autowired
    PointService pointService;

    @PostMapping("/addPoint")
    public Map<Object, Object> addPoint(@RequestBody Map<Object,Object> param){
        return pointService.addPoint(param);
    }

    @GetMapping("/getPoint")
    public Map<Object, Object> getPoint(@RequestParam Map<Object, Object> param){
        return pointService.getPoint(param);
    }
}
