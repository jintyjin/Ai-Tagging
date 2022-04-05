package com.refa.ai.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.refa.ai.entity.User;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserRepository {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	public User save(User user) {
		sqlSessionTemplate.insert("user.save", user);
		return user;
	}
	
	public User findById(String userId) {
		return sqlSessionTemplate.selectOne("user.findById", userId);
	}
	
	public List<User> findByIsUse(String isUse) {
		return sqlSessionTemplate.selectList("user.findByIsUse", isUse);
	} 
	
	public void updateLoginDate(String userId) {
		sqlSessionTemplate.update("user.updateLoginDate", userId);
	}
	
	public User findRecentOne() {
		return sqlSessionTemplate.selectOne("user.findRecentOne");
	}
	
	public User checkId(String user_id) {
		return sqlSessionTemplate.selectOne("user.checkId", user_id);
	}
	
	public User checkPw(User user) {
		return sqlSessionTemplate.selectOne("user.checkPw", user);
	}
	
}
