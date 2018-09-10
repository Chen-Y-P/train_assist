package hansuo.trainArrival.service;

import java.util.List;
import java.util.Map;

import hansuo.trainArrival.entity.JobFeedback;
import hansuo.trainArrival.entity.ScheduleJob;
import hansuo.trainArrival.entity.ScheduleJobEx;

public interface ScheduleJobService {

	List<ScheduleJobEx> searchByConditions(ScheduleJob job);

	List<ScheduleJobEx> searchByPost(int postId, String userName);

	int add(ScheduleJob job);

	int update(ScheduleJob job);

	int updateStatus(ScheduleJob job, JobFeedback jobFeedback);

	ScheduleJobEx getById(int id);

	Map<Integer, String> getTracks(int status);

	Map<Integer, String> getTrains(int status);

}
