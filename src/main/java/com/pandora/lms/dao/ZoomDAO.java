package com.pandora.lms.dao;

import com.pandora.lms.dto.ZoomDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class ZoomDAO {

    @Autowired
    private SqlSession sqlSession;


    public ZoomDTO authority(ZoomDTO zoomDTO) {


        return sqlSession.selectOne("zoom.authority", zoomDTO);
    }
}
