package com.pandora.lms.dao;

import com.pandora.lms.dto.ZoomDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Repository
public class ZoomDAO {

    @Autowired
    private SqlSession sqlSession;


    public ZoomDTO authority(ZoomDTO zoomDTO) {

        return sqlSession.selectOne("zoom.authority", zoomDTO);
    }

    public void join_url(ZoomDTO zoomDTO) {
        sqlSession.update("zoom.join_url", zoomDTO);
    }

    public void meeting_msg(ZoomDTO zoomDTO) {
        List<ZoomDTO> student_list = sqlSession.selectList("zoom.student_list", zoomDTO);
        for (ZoomDTO stdt_list : student_list) {
            stdt_list.setLogin_id(zoomDTO.getLogin_id());
            sqlSession.insert("zoom.student_msg", stdt_list);
        }
    }

    public int zoom_exit(ZoomDTO zoomDTO) {

        return sqlSession.update("zoom.zoom_exit",zoomDTO);
    }

    public ZoomDTO zoom_join(ZoomDTO zoomDTO) {


        return sqlSession.selectOne("zoom.zoom_join",zoomDTO);
    }

    public List<Map<String, Object>> student_list(ZoomDTO zoomDTO) {

        return sqlSession.selectList("zoom.student_lists",zoomDTO);
    }


    public void attendance_check(ZoomDTO zoomDTO) {


        String[] attendance = zoomDTO.getAttendance();
        String[] absence = zoomDTO.getAbsence();
        Map<String, Object> attendance_check = new HashMap<>();
        attendance_check.put("sbjct_no", zoomDTO.getSbjct_no());

        int result_cnt = 0;
        int check_size = 0;

        if (attendance != null){
            check_size = check_size + attendance.length;
            for (String value : attendance) {
                attendance_check.put("attendance", value);
                System.err.println("출석 : "+value);
                sqlSession.update("zoom.attendance_check", attendance_check);
                result_cnt = result_cnt+1;
            }
        }
        if (absence != null){
            check_size = check_size + absence.length;
            for (String value : absence) {
                attendance_check.put("absence", value);
                System.err.println("결석 : "+value);
                sqlSession.update("zoom.absence_check", attendance_check);
                result_cnt = result_cnt+1;
            }
        }
        if (check_size == result_cnt){
            List<Map<String, Object>> final_check_list = sqlSession.selectList("zoom.final_check_list", attendance_check);
            for (Map<String, Object> check_data : final_check_list) {
                System.err.println(check_data);
                sqlSession.insert("zoom.final_check", check_data);
            }
            System.err.println("성공적으로 출석체크");
        }



    }
}
