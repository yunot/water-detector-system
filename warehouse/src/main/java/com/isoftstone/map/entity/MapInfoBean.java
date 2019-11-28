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

	@Columns("ADDRESS")
	private String address;

    @Columns("SOAK")
    private String soak;

    @Columns("LEVEL")
	private String level;

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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getSoak() {
		return soak;
	}

	public void setSoak(String soak) {
		this.soak = soak;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}
}
