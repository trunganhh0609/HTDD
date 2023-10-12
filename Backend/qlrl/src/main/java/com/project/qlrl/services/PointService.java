package com.project.qlrl.services;

import com.project.qlrl.repository.PointRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PointService {

    @Autowired
    PointRepository pointRepository;

    @Transactional
    public Map<Object,Object> addPoint(Map<Object,Object> param){
        Map<Object, Object> result = new HashMap<>();
        List<Map<Object,Object>> lstPoint = (List<Map<Object,Object>>) param.get("lstPoint");
        try {
            for (int i = 0; i < lstPoint.size(); i++) {
                lstPoint.get(i).put("idClass", param.get("idClass"));
                lstPoint.get(i).put("idSubject", param.get("idSubject"));
                pointRepository.addPoint(lstPoint.get(i));
            }
            result.put("success", "success");
        }catch (Exception e){
            result.put("error", "error");
        }
        return result;
    }

    public Map<Object,Object> getPoint(Map<Object,Object> param){
        Map<Object, Object> result = new HashMap<>();
        try {
            result.put("data", pointRepository.getPoint(param));
        }catch (Exception e){
            e.printStackTrace();
            result.put("error", "error");
        }
        return result;
    }
}
