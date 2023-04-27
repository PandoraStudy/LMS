package com.pandora.lms.dao;

import com.pandora.lms.dto.ZoomDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;


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
        System.err.println("로그인한 ID : "+zoomDTO.getLogin_id());
        System.err.println("dao : "+zoomDTO.getSbjct_no());
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
}
