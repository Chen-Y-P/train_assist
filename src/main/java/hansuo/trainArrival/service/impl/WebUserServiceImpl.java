package hansuo.trainArrival.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hansuo.trainArrival.entity.UserRole;
import hansuo.trainArrival.entity.WebUser;
import hansuo.trainArrival.mapper.WebUserMapper;
import hansuo.trainArrival.service.WebUserService;

@Service
public class WebUserServiceImpl implements WebUserService {

	@Autowired
	private WebUserMapper webUserDao;

	@Override
	public WebUser getUser(String userName, String password) {
		return webUserDao.search(userName, password);
	}

	@Override
	public List<WebUser> searchByConditions(WebUser webUser) {
		// TODO Auto-generated method stub
		return webUserDao.searchByConditions(webUser);
	}

	@Override
	public int add(WebUser webUser) {
		// 默认生效
		webUser.setStatus(1);
		return webUserDao.insert(webUser);
	}

	@Override
	public WebUser getById(int id) {
		WebUser bean = new WebUser();
		bean.setId(id);
		return webUserDao.getById(bean);
	}

	@Override
	public int delete(WebUser webUser) {
		return webUserDao.delete(webUser);
	}

	@Override
	public int update(WebUser webUser) {
		return webUserDao.update(webUser);
	}

	@Override
	public List<UserRole> getUserRoleById(int id) {
		return webUserDao.getUserRoleById(id);
	}
}
