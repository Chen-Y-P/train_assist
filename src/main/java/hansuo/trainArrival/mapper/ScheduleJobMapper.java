package hansuo.trainArrival.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;

import hansuo.trainArrival.entity.ScheduleJob;
import hansuo.trainArrival.entity.ScheduleJobEx;
import hansuo.trainArrival.mapper.sqlprovider.ScheduleJobSqlProvider;

public interface ScheduleJobMapper extends BaseMapper<ScheduleJob> {

	@SelectProvider(type = ScheduleJobSqlProvider.class, method = "searchByConditions")
	List<ScheduleJobEx> searchByConditions(ScheduleJob job);

	@SelectProvider(type = ScheduleJobSqlProvider.class, method = "searchByPost")
	List<ScheduleJobEx> searchByPost(@Param("postId") int postId, @Param("userName") String userName);

	@Update("update SCHEDULE_JOB set jobStatus = #{jobStatus} where id = #{id}")
	int updateStatus(@Param("id") int id, @Param("jobStatus") int jobStatus);

	@SelectProvider(type = ScheduleJobSqlProvider.class, method = "getById")
	ScheduleJobEx getById(@Param("id") int id);

}
