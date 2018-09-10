package hansuo.trainArrival.entity;

/**
 * 调度作业表实体类
 * 
 * @author seed
 *
 */
public class ScheduleJobEx extends ScheduleJob {

	private static final long serialVersionUID = -6640387359712628612L;

	/* 股道名称 */
	private String trackName;

	/* 车次名称 */
	private String trainNumber;

	public String getTrackName() {
		return trackName;
	}

	public void setTrackName(String trackName) {
		this.trackName = trackName;
	}

	public String getTrainNumber() {
		return trainNumber;
	}

	public void setTrainNumber(String trainNumber) {
		this.trainNumber = trainNumber;
	}

}
