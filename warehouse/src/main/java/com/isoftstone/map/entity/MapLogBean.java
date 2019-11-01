package com.isoftstone.map.entity;

import com.isoftstone.platform.entity.Columns;

public class MapLogBean {
	 	@Columns("LOCATION_LOG_ID")
	    private Integer locationLogId;
	 	
	 	@Columns("NAME")
	    private String name;
	    
	    @Columns("LON")
	    private String lon;
	    
	    @Columns("LAT")
	    private String lat;
	    
	    @Columns("CITY")
	    private String city;
	    
	    @Columns("LOG_DATETIME")
	    private String logDatetime;

		public Integer getLocationLogId() {
			return locationLogId;
		}

		public void setLocationLogId(Integer locationLogId) {
			this.locationLogId = locationLogId;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getLon() {
			return lon;
		}

		public void setLon(String lon) {
			this.lon = lon;
		}

		public String getLat() {
			return lat;
		}

		public void setLat(String lat) {
			this.lat = lat;
		}

		public String getCity() {
			return city;
		}

		public void setCity(String city) {
			this.city = city;
		}

		public String getLogDatetime() {
			return logDatetime;
		}

		public void setLogDatetime(String logDatetime) {
			this.logDatetime = logDatetime;
		}

}
