package com.project.qlrl.controllers;

import com.project.qlrl.services.ClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("api/class/")
public class ClassController {

    @Autowired
    ClassService classService;

    @GetMapping("getClassByTeacher")
    public Map<Object,Object> getClassByTeacher(){
        Map<Object,Object> result = new HashMap<>();
        try {
            result.put("data", classService.getClassByTeacher());
            result.put("status", true);
        }catch (Exception e){
            e.printStackTrace();
            result.put("status", false);
        }
        return result;
    }

    @GetMapping("getCheckInData")
    public Map<Object,Object> getCheckInData(@RequestParam String classId, @RequestParam String lesson){
        Map<Object,Object> result = new HashMap<>();
        try {
            result.put("data", classService.getCheckInData(classId, lesson));
            result.put("status", true);
        }catch (Exception e){
            e.printStackTrace();
            result.put("status", false);
        }
        return result;
    }

    @GetMapping("getListClass")
    public Map<Object,Object> getListClass(){
        return classService.getListClass();
    }

    @GetMapping("searchTeacher")
    public Map<Object,Object> searchTeacher(@RequestParam String keySearch){
        return classService.searchTeacher(keySearch);
    }

    @PostMapping("addClass")
    public Map<Object,Object> addClass(@RequestBody Map<Object,Object> param){
        return classService.addClass(param);
    }
}
