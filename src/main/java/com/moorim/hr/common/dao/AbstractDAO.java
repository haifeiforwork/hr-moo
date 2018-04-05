package com.moorim.hr.common.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class AbstractDAO {
	protected Log log = LogFactory.getLog(AbstractDAO.class);
    
    @Autowired
    @Resource(name="sqlSessionTemplate_hr")
    private SqlSessionTemplate sqlSession_hr;
    
    @Resource(name="sqlSessionTemplate_sms")
    private SqlSessionTemplate sqlSession_sms;
    
    @Resource(name="sqlSessionTemplate_ep")
    private SqlSessionTemplate sqlSession_ep;
     

     
    protected void printQueryId(String queryId) {
        if(log.isDebugEnabled()){
            log.debug("\t QueryId  \t:  " + queryId);
        }
    }
    
    
    public Object insert(String queryId, Object params){
        printQueryId(queryId);
        return sqlSession_hr.insert(queryId, params);
    }
    
    public Object insert(String queryId){
        printQueryId(queryId);
        return sqlSession_hr.insert(queryId);
    }
    
     
    public Object update(String queryId, Object params){
        printQueryId(queryId);
        return sqlSession_hr.update(queryId, params);
    }
     
    public Object delete(String queryId, Object params){
        printQueryId(queryId);
        return sqlSession_hr.delete(queryId, params);
    }
     
    public Object selectOne(String queryId){
        printQueryId(queryId);
        return sqlSession_hr.selectOne(queryId);
    }
     
    public Object selectOne(String queryId, Object params){
        printQueryId(queryId);
        return sqlSession_hr.selectOne(queryId, params);
    }
     
    @SuppressWarnings("rawtypes")
    public List selectList(String queryId){
        printQueryId(queryId);
        return sqlSession_hr.selectList(queryId);
    }
    
    @SuppressWarnings("rawtypes")
    public List selectList(String queryId, Object params){
        printQueryId(queryId);
        return sqlSession_hr.selectList(queryId,params);
    }
     
    public  Object insertSms(String queryId, Object params) {
        printQueryId(queryId);
        return sqlSession_sms.insert(queryId, params);
    	
    }
    
    @SuppressWarnings("rawtypes") 
    public Object selectOneEp(String queryId, Object params){
        printQueryId(queryId);
        return sqlSession_ep.selectOne(queryId, params);
    }
    
    @SuppressWarnings("rawtypes")
    public List selectListEp(String queryId, Object params){
        printQueryId(queryId);
        return sqlSession_ep.selectList(queryId,params);
    }


}
