package ai_box_pjt.device;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.refa.ai.repository.DeviceRepository;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class DeviceServiceTest {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	DeviceRepository deviceRepository = new DeviceRepository(sqlSessionTemplate);
	
	@Test
	@DisplayName("AESÅ×½ºÆ®")
	public void updatePwdTest() {
		System.out.println(deviceRepository);
		System.out.println(sqlSessionTemplate.selectList("device.findAll"));
	}
}
