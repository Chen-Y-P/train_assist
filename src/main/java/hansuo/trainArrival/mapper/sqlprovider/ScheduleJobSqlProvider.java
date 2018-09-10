package hansuo.trainArrival.mapper.sqlprovider;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.ibatis.annotations.Param;

import hansuo.trainArrival.entity.ScheduleJob;

public class ScheduleJobSqlProvider extends BaseSqlProvider {

	/**
	 * 条件查询语句 作业日期，进出站（进站/出站/全部），是否完成（未完成/已完成/全部）
	 * 
	 * @param webUser
	 * @return
	 */
	public String searchByConditions(final ScheduleJob job) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT A.*,B.TRAINNUMBER, C.TRACKNAME ");
		sql.append(" FROM SCHEDULE_JOB A ");
		sql.append(" LEFT JOIN B_TRAIN B ");
		sql.append(" ON A.TRAINID = B.ID ");
		sql.append(" LEFT JOIN B_TRACK C ");
		sql.append(" ON A.TRACKID = C.ID ");
		sql.append(" WHERE 1=1 ");
		if (job.getArriveTime() != null) {
			sql.append(" and date_format(A.arriveTime, '%y-%m-%d') = date_format('");
			sql.append(DateFormatUtils.format(job.getArriveTime(), "yyyy-MM-dd HH:mm:ss"));
			sql.append("', '%y-%m-%d')");
		}
		if (job.getIsArrive() != null) {
			sql.append(" and A.isArrive = ");
			sql.append(job.getIsArrive());
		}
		if (job.getJobStatus() != null) {
			sql.append(" and A.jobStatus = ");
			sql.append(job.getJobStatus());
		}
		// 添加排序
		sql.append(" order by A.arriveTime desc");
		return sql.toString();
	}

	/*
	 * SELECT * FROM schedule_job a inner join b_track b on a.trackId= b.id inner
	 * join web_user c on b.deptId = c.deptId inner join b_train d on a.trainId =
	 * d.id where c.postId = ?;
	 */

	public String searchByPost(@Param("postId") int postId, @Param("userName") String userName) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM SCHEDULE_JOB A INNER JOIN B_TRACK B ");
		sql.append(" ON A.TRACKID= B.ID ");
		sql.append(" INNER JOIN WEB_USER C ");
		sql.append(" ON	B.DEPTID = C.DEPTID ");
		sql.append(" INNER JOIN B_TRAIN D ");
		sql.append(" ON  A.TRAINID = D.ID ");
		sql.append(" WHERE 1=1 ");
		sql.append(" AND A.JOBSTATUS != 1");
		sql.append(" AND C.POSTID = #{postId}");
		sql.append(" AND C.USERNAME = #{userName}");
		// 添加排序
		sql.append(" order by A.arriveTime desc");
		return sql.toString();
	}

	public String getById(@Param("id") int id) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT A.*,B.TRAINNUMBER, C.TRACKNAME ");
		sql.append(" FROM SCHEDULE_JOB A ");
		sql.append(" LEFT JOIN B_TRAIN B ");
		sql.append(" ON A.TRAINID = B.ID ");
		sql.append(" LEFT JOIN B_TRACK C ");
		sql.append(" ON A.TRACKID = C.ID ");
		sql.append(" WHERE 1=1 ");
		sql.append(" AND A.ID = #{id}");
		return sql.toString();
	}

}
