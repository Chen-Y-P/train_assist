package hansuo.trainArrival.service.impl;

import java.lang.reflect.Field;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import hansuo.trainArrival.entity.JobFeedback;
import hansuo.trainArrival.entity.ScheduleJob;
import hansuo.trainArrival.entity.ScheduleJobEx;
import hansuo.trainArrival.entity.Track;
import hansuo.trainArrival.entity.Train;
import hansuo.trainArrival.mapper.JobFeedbackMapper;
import hansuo.trainArrival.mapper.ScheduleJobMapper;
import hansuo.trainArrival.mapper.TrackMapper;
import hansuo.trainArrival.mapper.TrainMapper;
import hansuo.trainArrival.service.ScheduleJobService;

@Service
public class ScheduleJobServiceImpl implements ScheduleJobService {

	@Autowired
	private ScheduleJobMapper scheduleJobDao;

	@Autowired
	private JobFeedbackMapper jobFeedbackDao;

	@Autowired
	private TrackMapper trackDao;

	@Autowired
	private TrainMapper trainDao;

	@Override
	public List<ScheduleJobEx> searchByConditions(ScheduleJob job) {
		return scheduleJobDao.searchByConditions(job);
	}

	@Override
	public Map<Integer, String> getTracks(int status) {
		Map<Integer, String> result = new HashMap<Integer, String>();
		List<Track> tracks = trackDao.getTracks(status);
		tracks.stream().forEach(track -> {
			result.put(track.getId(), track.getTrackName());
		});
		return result;
	}

	@Override
	public Map<Integer, String> getTrains(int status) {
		Map<Integer, String> result = new HashMap<Integer, String>();
		List<Train> trains = trainDao.getTrains(status);
		trains.stream().forEach(train -> {
			result.put(train.getId(), train.getTrainNumber());
		});
		return result;
	}

	@Override
	public int add(ScheduleJob job) {
		return scheduleJobDao.insert(job);
	}

	@Override
	public List<ScheduleJobEx> searchByPost(int postId, String userName) {
		return scheduleJobDao.searchByPost(postId, userName);
	}

	@Override
	public int update(ScheduleJob job) {
		// return scheduleJobDao.update(job);
		return 0;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateStatus(ScheduleJob job, JobFeedback jobFeedback) {
		int key = jobFeedback.getPostId();
		// 设置反馈类型
		if (job.getJobStatus() == 0) {
			// 接收作业
			switch (key) {
			// 车号 接收时分
			case 2:
				jobFeedback.setJobType(3);
				break;
			// 货检 接收时分
			case 3:
				jobFeedback.setJobType(2);
				break;
			// 列检 接收时分
			case 4:
				jobFeedback.setJobType(1);
				break;
			// 防溜 接收时分
			case 5:
				jobFeedback.setJobType(5);
				break;
			// 列尾 接收时分
			case 6:
				jobFeedback.setJobType(4);
				break;
			default:
				break;
			}
		} else if (job.getJobStatus() == 1) {
			// 完成作业
			switch (key) {
			// 车号 反馈时分
			case 2:
				jobFeedback.setJobType(8);
				break;
			// 货检 反馈时分
			case 3:
				jobFeedback.setJobType(7);
				break;
			// 列检 反馈时分
			case 4:
				jobFeedback.setJobType(6);
				break;
			// 防溜 反馈时分
			case 5:
				jobFeedback.setJobType(1);
				break;
			// 列尾 反馈时分
			case 6:
				jobFeedback.setJobType(10);
				break;
			default:
				break;
			}
		}

		jobFeedback.setJobId(job.getId());
		jobFeedback.setFeedbackTime(new Date());
		jobFeedback.setTrackId(job.getTrackId());
		jobFeedback.setTrainId(job.getTrainId());
		job.setAntiRunningCount(jobFeedback.getAntiRunningCount());
		job.setAntiRunningMan(jobFeedback.getAntiRunningMan());
		job.setAntiRunningMethod(jobFeedback.getAntiRunningMethod());

		// scheduleJobDao.updateStatus(job.getId(), job.getJobStatus());
		scheduleJobDao.update(job);
		jobFeedbackDao.insert(jobFeedback);
		return 0;
	}

	@Override
	public ScheduleJobEx getById(int id) {
		return scheduleJobDao.getById(id);
	}

	public static void main(String[] args) {
		ScheduleJob job = new ScheduleJob();
		job.setId(5);
		Class clazz = job.getClass();
		Field[] fields = clazz.getDeclaredFields();
		for (int i = 0; i < fields.length; i++) {
			Field field = fields[i];
			field.setAccessible(true);
			try {
				Object o = field.get(job);
				String name = field.getName();
				System.out.println(name);
				System.out.println(o);
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
