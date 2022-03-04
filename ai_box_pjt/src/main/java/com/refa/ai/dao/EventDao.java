package com.refa.ai.dao;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.refa.ai.dto.ActionDto;
import com.refa.ai.dto.ActionLogDto;
import com.refa.ai.dto.BackupLogDto;
import com.refa.ai.dto.CategoryDto;
import com.refa.ai.dto.CountDto;
import com.refa.ai.dto.DBackupDto;
import com.refa.ai.dto.DeviceInfoDto;
import com.refa.ai.dto.ErrorLogDto;
import com.refa.ai.dto.EventDto;
import com.refa.ai.dto.ImageLogDto;
import com.refa.ai.dto.ImageLogJsonDto;
import com.refa.ai.dto.ImageTableDto;
import com.refa.ai.dto.MonitoringDto;
import com.refa.ai.dto.ResponseLogDto;
import com.refa.ai.dto.SettingDto;
import com.refa.ai.dto.VersionDto;
import com.refa.ai.dto.user.UserDto;
import com.refa.ai.entity.User;

@Service
public class EventDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public User login(User user) {
		return sqlSession.selectOne("sql.login", user);
	}

	public Map selectUserChById(Map map) {
		return sqlSession.selectOne("sql.selectUserChById", map);
	}
	
	public void updateLoginDate(User user) {
		sqlSession.insert("sql.updateLoginDate", user);
	}
	
	public List<UserDto> userList() {
		return sqlSession.selectList("sql.userList");
	}
	
	public String selectUser_Tokken(String action_target) {
		return sqlSession.selectOne("sql.selectUser_Tokken", action_target);
	}

	public List<String> categoryList(String class_name) {
		return sqlSession.selectList("sql.categoryList", class_name);
	}

	public List<CategoryDto> selectCategoryAll() {
		return sqlSession.selectList("sql.selectCategoryAll");
	}
	
//	public void insertImage(String imageInfo) {
//		sqlSession.insert("sql.insertImage", imageInfo);
//	}

	public void insertImageEvent(ImageTableDto imageTableDto) {
		sqlSession.insert("sql.insertImageEvent", imageTableDto);
	}
	
	public List<MonitoringDto> monitoringList(String login_id) {
		return sqlSession.selectList("sql.monitoringList", login_id);
	}
	
	public List<String> selectImage(CategoryDto category) {
		return sqlSession.selectList("sql.selectImage", category);
	}
	
	public List<ImageTableDto> searchTag(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.searchTag", imageTableDto);
	}

	public List<ImageTableDto> searchTag2(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.searchTag2", imageTableDto);
	}

	public List<ImageTableDto> searchTag3(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.searchTag3", imageTableDto);
	}
	
	public List<ImageTableDto> searchTag4(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.searchTag4", imageTableDto);
	}
	
	public List<ImageTableDto> searchDate(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.searchDate", imageTableDto);
	}
	
	public List<ImageTableDto> selectAllImage() {
		return sqlSession.selectList("sql.selectAllImage");
	}

	public List<ImageTableDto> selectDownloadImage(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.selectDownloadImage", imageTableDto);
	}

	public void updateImageMonitoring(ImageTableDto imageTableDto) {
		sqlSession.insert("sql.updateImageMonitoring", imageTableDto);
	}
	
	public String selectMonitoringCount(MonitoringDto monitoringDto) {
		return sqlSession.selectOne("sql.selectMonitoringCount", monitoringDto);
	}

	public void insertMonitoring(MonitoringDto monitoringDto) {
		sqlSession.insert("sql.insertMonitoring", monitoringDto);
	}

	public void updateMonitoring(MonitoringDto monitoringDto) {
		sqlSession.insert("sql.updateMonitoring", monitoringDto);
	}

	public void insertGallery(Map map) {
		sqlSession.insert("sql.insertGallery", map);
	}
	
	public List<Map> selectGalleryList(Map map) {
		return sqlSession.selectList("sql.selectGalleryList", map);
	}
	
	public List<EventDto> listJson() {
		return sqlSession.selectList("sql.itemList");
	}

	public List<CountDto> filterCount(String event_name) {
		return sqlSession.selectList("sql.filterCount", event_name);
	}

	public List<CountDto> filterCount2(String event_name) {
		return sqlSession.selectList("sql.filterCount2", event_name);
	}
	
	public EventDto insertJson(EventDto eventDto) {
		return sqlSession.selectOne("sql.insert", eventDto);
	}
	
	public String selectCount(EventDto eventDto) {
		return sqlSession.selectOne("sql.selectCount", eventDto);
	}

	public void insertCount(EventDto eventDto) {
		sqlSession.insert("sql.insertCount", eventDto);
	}
	
	public void updateCount(EventDto eventDto) {
		sqlSession.insert("sql.updateCount", eventDto);
	}
	
	public List<String> eventListDate(Map login) {
		return sqlSession.selectList("sql.itemEventDate", login);
	}

	public List<String> showImage() {
		return sqlSession.selectList("sql.showImage");
	}

	public UserDto userInfo(UserDto userDto) {
		return sqlSession.selectOne("sql.userInfo", userDto);
	}

	public List<Map> itemInfo() {
		return sqlSession.selectList("sql.itemInfo");
	}

	public Map insertActionInfo(Map map) {
		return sqlSession.selectOne("sql.insertActionInfo", map);
	}
	
	public void insertActionLogInfo(ActionLogDto actionDto) {
		sqlSession.insert("sql.insertActionLogInfo", actionDto);
	}
	
	public void updateActionIsuse(Map map) {
		sqlSession.insert("sql.updateActionIsuse", map);
	}

	public void updateActionIsuseAll(Map map) {
		sqlSession.insert("sql.updateActionIsuseAll", map);
	}

	public void updateActionInfo(Map map) {
		sqlSession.insert("sql.updateActionInfo", map);
	}
	
	public void deleteActionInfo(Map map) {
		sqlSession.insert("sql.deleteActionInfo", map);
	}

	public void deleteActionInfoByTitle(Map map) {
		sqlSession.insert("sql.deleteActionInfoByTitle", map);
	}
	
	public void deleteActionTarget(UserDto userDto) {
		sqlSession.insert("sql.deleteActionTarget", userDto);
	}
	
	public UserDto chkUserId(UserDto userDto) {
		return sqlSession.selectOne("sql.chkUserId", userDto);
	}
	
	public void insertUserInfo(UserDto userDto) {
		System.out.println(sqlSession.insert("sql.insertUserInfo", userDto));
	}
	
	public void updateUserInfo(User user) {
		sqlSession.insert("sql.updateUserInfo", user);
	}

	public void updatePwInfo(User user) {
		sqlSession.insert("sql.updatePwInfo", user);
	}

	public void updateDevInfo(Map map) {
		sqlSession.insert("sql.updateDevInfo", map);
	}
	
	public void updateDevCon(Map map) {
		sqlSession.insert("sql.updateDevCon", map);
	}

	public void updateIsUse(UserDto userDto) {
		sqlSession.insert("sql.updateIsUse", userDto);
	}
	
	public List<Map> deviceList(Map map) {
		return sqlSession.selectList("sql.deviceList", map);
	}
	
	public Map deviceInfoOne2(Map map) {
		return sqlSession.selectOne("sql.deviceInfoOne2", map);
	}

	public void deleteDeviceInfo(Map map) {
		sqlSession.insert("sql.deleteDeviceInfo", map);
	}
	
	public List<ImageTableDto> selectImage2() {
		return sqlSession.selectList("sql.selectImage2");
	}

	public List<MonitoringDto> searchDateImage(String monitoring_time) {
		return sqlSession.selectList("sql.searchDateImage", monitoring_time);
	}
	
	public List<ImageTableDto> searchFilterMonitoring(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.searchFilterMonitoring", imageTableDto);
	}

	public List<ImageTableDto> searchFilterMonitoring2(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.searchFilterMonitoring2", imageTableDto);
	}
	
	public List<ImageTableDto> searchFilterImage(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.searchFilterImage", imageTableDto);
	}

	public List<ImageTableDto> searchFilterImage2(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.searchFilterImage2", imageTableDto);
	}

	public List<ImageTableDto> searchUpMonitoring(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.searchUpMonitoring", imageTableDto);
	}

	public List<ImageTableDto> searchUpTag(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.searchUpTag", imageTableDto);
	}

	public Map selectModalImage(Map map) {
		return sqlSession.selectOne("sql.selectModalImage", map);
	}

	public ImageTableDto showRightInfoImage(ImageTableDto imageTableDto) {
		return sqlSession.selectOne("sql.showRightInfoImage", imageTableDto);
	}
	
	public List<ImageTableDto> selectRecentImageList(ImageTableDto imageTableDto) {
		return sqlSession.selectList("sql.selectRecentImageList", imageTableDto);
	}

	public ImageTableDto selectRecentImage(ImageTableDto imageTableDto) {
		return sqlSession.selectOne("sql.selectRecentImage", imageTableDto);
	}

	public int deleteBackupImage(String image_name) {
		return sqlSession.insert("sql.deleteBackupImage", image_name);
	}

	public int deleteBackupMonitoring(String image_name) {
		return sqlSession.insert("sql.deleteBackupMonitoring", image_name);
	}

	public int updateBackupMonitoring(String monitoring_tag) {
		return sqlSession.insert("sql.updateBackupMonitoring", monitoring_tag);
	}

	public void insertBackupLog(BackupLogDto backupLog) {
		sqlSession.insert("sql.insertBackupLog", backupLog);
	}

	public List<ImageTableDto> selectImageAll() {
		return sqlSession.selectList("sql.selectImageAll");
	}

	public void updateImageAll(ImageTableDto imageTableDto) {
		sqlSession.insert("sql.updateImageAll", imageTableDto);
	}

	public List<MonitoringDto> selectMonitoringAll() {
		return sqlSession.selectList("sql.selectMonitoringAll");
	}

	public void updateMonitoringAll(MonitoringDto monitoringDto) {
		sqlSession.insert("sql.updateMonitoringAll", monitoringDto);
	}

	public List<ImageTableDto> selectDeleteC(int dateCount) {
		return sqlSession.selectList("sql.selectDeleteC", dateCount);
	}

	public List<ImageTableDto> selectDeleteD(int dateCount) {
		return sqlSession.selectList("sql.selectDeleteD", dateCount);
	}
	
	public List<ImageTableDto> selectMoveCD(DBackupDto dBackupDto) {
		return sqlSession.selectList("sql.selectMoveCD", dBackupDto);
	}

	public List<ImageTableDto> deleteOverDate(String untilTime) {
		return sqlSession.selectList("sql.deleteOverDate", untilTime);
	}

	public void deleteOverDateMonitoring(String untilTime) {
		sqlSession.insert("sql.deleteOverDateMonitoring", untilTime);
	}

	public void deleteOverDateMonitoring2(ImageTableDto imageTableDto) {
		sqlSession.insert("sql.deleteOverDateMonitoring2", imageTableDto);
	}

	public List<MonitoringDto> selectTestImage(MonitoringDto monitoringDto) {
		return sqlSession.selectList("sql.selectTestImage", monitoringDto);
	}
	
	public void updateTestMonitoring(MonitoringDto monitoringDto) {
		sqlSession.insert("sql.updateTestMonitoring", monitoringDto);
	}

	public void insertErrorLog(ErrorLogDto errorLogDto) {
		sqlSession.insert("sql.insertErrorLog", errorLogDto);
	}

	public List<BackupLogDto> backupLogDate(String searchDate) {
		return sqlSession.selectList("sql.backupLogDate", searchDate);
	}

	public List<BackupLogDto> backupLogDate2() {
		return sqlSession.selectList("sql.backupLogDate2");
	}

	public List<ErrorLogDto> errorLogDate(String searchDate) {
		return sqlSession.selectList("sql.errorLogDate", searchDate);
	}

	public List<ErrorLogDto> errorLogDate2() {
		return sqlSession.selectList("sql.errorLogDate2");
	}

	public SettingDto settingData(String setting_name) {
		return sqlSession.selectOne("sql.settingData", setting_name);
	}
	
	public void insertDevInfo(Map map) {
		sqlSession.insert("sql.insertDevInfo", map);
	}

	public int selectDevCh(Map map) {
		return sqlSession.selectOne("sql.selectDevCh", map);
	}

	public List<Map> deviceListByType(Map map) {
		return sqlSession.selectList("sql.deviceListByType", map);
	}
	
	public void updatePresetByCh(Map map) {
		sqlSession.insert("sql.updatePresetByCh", map);
	}
	
	public void updatePresetByIsuse(Map map) {
		sqlSession.insert("sql.updatePresetByIsuse", map);
	}

	public Map selectDeviceInfoByTitle(Map map) {
		return sqlSession.selectOne("sql.selectDeviceInfoByTitle", map);
	}

	public List<Map> selectPreset250(Map map) {
		return sqlSession.selectList("sql.selectPreset250", map);
	}

	public Map selectActionInfoByKey(Map map) {
		return sqlSession.selectOne("sql.selectActionInfoByKey", map);
	}
	
	public Map selectEventActionByAction(Map map) {
		return sqlSession.selectOne("sql.selectEventActionByAction", map);
	}
	
	public List<Map> selectEventActionListByAction(Map map) {
		return sqlSession.selectList("sql.selectEventActionListByAction", map);
	}

	public Map selectDeviceInfoByIP(Map map) {
		return sqlSession.selectOne("sql.selectDeviceInfoByIP", map);
	}
	
	public List<Map> selectMonitorAll() {
		return sqlSession.selectList("sql.selectMonitorAll");
	}

	public void updateUrlSetup(Map map) {
		sqlSession.insert("sql.updateUrlSetup", map);
	}
	public void updateDeviceUrlSetup(Map map) {
		sqlSession.insert("sql.updateDeviceUrlSetup", map);
	}
	public void updateMonitor(Map map) {
		sqlSession.insert("sql.updateMonitor", map);
	}
	public Map selectmonitorByCh(int dev_ch) {
		return sqlSession.selectOne("sql.selectmonitorByCh", dev_ch);
	}
	public Map selectmonitorByCh2(String tag) {
		return sqlSession.selectOne("sql.selectmonitorByCh2", tag);
	}
	public List<Map> selectActionSetup(Map map) {
		return sqlSession.selectList("sql.selectActionSetup", map);
	}
	public void updateActionInfoTitle(Map map) {
		sqlSession.insert("sql.updateActionInfoTitle", map);
	}
	public void deleteActionSetup(Map map) {
		sqlSession.insert("sql.deleteActionSetup", map);
	}
	public void deleteConfdur(Map map) {
		sqlSession.insert("sql.deleteConfdur", map);
	}
	public void insertActionSetup(Map map) {
		sqlSession.insert("sql.insertActionSetup", map);
	}
	public void updateActionSetup(Map map) {
		sqlSession.insert("sql.updateActionSetup", map);
	}
	public void updateActionSetupBySetup(Map map) {
		sqlSession.insert("sql.updateActionSetupBySetup", map);
	}
	public void updateConfdur(Map map) {
		sqlSession.insert("sql.updateConfdur", map);
	}
	public List<Map> selectDevinfoAsSetting() {
		return sqlSession.selectList("sql.selectDevinfoAsSetting");
	}
	
	public List<Map> selectNetworkSpeaker() {
		return sqlSession.selectList("sql.selectNetworkSpeaker");
	}
	public Map selectNetworkSpeakerByIdx(Map map) {
		return sqlSession.selectOne("sql.selectNetworkSpeakerByIdx", map);
	}
	public void insertNetworkSpeaker(Map map) {
		sqlSession.insert("sql.insertNetworkSpeaker", map);
	}
	public void updateNetworkSpeaker(Map map) {
		sqlSession.insert("sql.updateNetworkSpeaker", map);
	}
	public void deleteNetworkSpeakerByIdx(Map map) {
		sqlSession.insert("sql.deleteNetworkSpeakerByIdx", map);
	}
	
	public Map selectAreaSet(Map map) {
		return sqlSession.selectOne("sql.selectAreaSet", map);
	}
	public void setAreaSet(Map map) {
		sqlSession.insert("sql.setAreaSet", map);
	}
	public void deleteAreaSet(Map map) {
		sqlSession.insert("sql.deleteAreaSet", map);
	}

	public List<Map> selectScheduleAll() {
		return sqlSession.selectList("sql.selectScheduleAll");
	}
	public Optional<Map> selectSchedule(Map map) {
		return Optional.ofNullable(sqlSession.selectOne("sql.selectSchedule", map));
	}
	public void saveSchedule(Map map) {
		sqlSession.insert("sql.saveSchedule", map);
	}
	public void deleteSchedule(Map map) {
		sqlSession.insert("sql.deleteSchedule", map);
	}
	
	public Map selectLogPopup(Map map) {
		return sqlSession.selectOne("sql.selectLogPopup", map);
	}
}
