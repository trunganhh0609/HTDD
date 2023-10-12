package com.project.qlrl.services;

import com.project.qlrl.common.CommonConst;
import com.project.qlrl.repository.AttendanceRepository;
import com.project.qlrl.repository.ClassRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ClassService {

    @Autowired CommonService commonService;

    @Autowired
    ClassRepository classRepository;

    @Autowired
    AttendanceRepository attendanceRepository;

    public List<Map<Object,Object>> getClassByTeacher() throws Exception {
        String userUid = commonService.getUserUid();
        Map<Object,Object> param = new HashMap<>();
        param.put("uid", userUid);
        param.put("teacherRole", CommonConst.USER_ROLE_TEACHER);
        return classRepository.getClassByTeacher(param);
    }

    public List<Map<Object,Object>> getCheckInData(String classId, String lesson) throws Exception {
        Map<Object,Object> param = new HashMap<>();
        param.put("classId", classId);
        param.put("studentRole", CommonConst.USER_ROLE_STUDENT);
        param.put("lesson", lesson);
        List<Map<Object,Object>> lstStudent = classRepository.getStudentInClass(param);
        List<Map<Object,Object>> lstAttendanceInLesson = attendanceRepository.getListAttendanceInLesson(param);

        for (int i = 0; i < lstStudent.size(); i++) {
            for (int j = 0; j < lstAttendanceInLesson.size(); j++) {
                if(lstStudent.get(i).get("userId").equals(lstAttendanceInLesson.get(j).get("userId"))){
                    lstStudent.get(i).put("status", lstAttendanceInLesson.get(j).get("status"));
                    lstStudent.get(i).put("statusName", lstAttendanceInLesson.get(j).get("commName"));
                }
            }
        }
        return lstStudent;
    }
}
