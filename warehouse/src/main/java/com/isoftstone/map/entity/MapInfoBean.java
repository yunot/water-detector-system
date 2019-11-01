package com.isoftstone.map.entity;

import com.isoftstone.platform.entity.Columns;

public class MapInfoBean {
	@Columns("LOCATION_ID")
    private int locationId;
	
	@Columns("NAME")
    private String name;
    
    @Columns("LON")
    private String lon;
    
    @Columns("LAT")
    private String lat;
    
    @Columns("CITY")
    private String city;
    
    @Columns("SOAK")
    private String soak;

	public int getLocationId() {
		return locationId;
	}

	public void setLocationId(int locationId) {
		this.locationId = locationId;
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

	public String getSoak() {
		return soak;
	}

	public void setSoak(String soak) {
		this.soak = soak;
	}
}