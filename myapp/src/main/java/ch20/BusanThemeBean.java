package ch20;

public class BusanThemeBean {

	private int ucSeq;
	private String mainTitle;
	private String gugunNm;
	private String cate2Nm;
	private String place;
	private String mainImgThumb;
	private String subtitle;
	private String addr1;
	private String homepageUrl;
	private String trfcInfo;
	private String mainImgNormal;
	private String itemcntnts;
	
	public BusanThemeBean() {}
	
	public BusanThemeBean(int ucSeq, String mainTitle, String gugunNm, String cate2Nm, String place,
			String mainImgThumb, String subtitle, String addr1, String homepageUrl, String trfcInfo,
			String mainImgNormal, String itemcntnts) {
		super();
		this.ucSeq = ucSeq;
		this.mainTitle = mainTitle;
		this.gugunNm = gugunNm;
		this.cate2Nm = cate2Nm;
		this.place = place;
		this.mainImgThumb = mainImgThumb;
		this.subtitle = subtitle;
		this.addr1 = addr1;
		this.homepageUrl = homepageUrl;
		this.trfcInfo = trfcInfo;
		this.mainImgNormal = mainImgNormal;
		this.itemcntnts = itemcntnts;
	}

	public int getUcSeq() {
		return ucSeq;
	}
	public void setUcSeq(int ucSeq) {
		this.ucSeq = ucSeq;
	}
	public String getMainTitle() {
		return mainTitle;
	}
	public void setMainTitle(String mainTitle) {
		this.mainTitle = mainTitle;
	}
	public String getGugunNm() {
		return gugunNm;
	}
	public void setGugunNm(String gugunNm) {
		this.gugunNm = gugunNm;
	}
	public String getCate2Nm() {
		return cate2Nm;
	}
	public void setCate2Nm(String cate2Nm) {
		this.cate2Nm = cate2Nm;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getMainImgThumb() {
		return mainImgThumb;
	}
	public void setMainImgThumb(String mainImgThumb) {
		this.mainImgThumb = mainImgThumb;
	}
	public String getSubtitle() {
		return subtitle;
	}
	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getHomepageUrl() {
		return homepageUrl;
	}
	public void setHomepageUrl(String homepageUrl) {
		this.homepageUrl = homepageUrl;
	}
	public String getTrfcInfo() {
		return trfcInfo;
	}
	public void setTrfcInfo(String trfcInfo) {
		this.trfcInfo = trfcInfo;
	}
	public String getMainImgNormal() {
		return mainImgNormal;
	}
	public void setMainImgNormal(String mainImgNormal) {
		this.mainImgNormal = mainImgNormal;
	}
	public String getItemcntnts() {
		return itemcntnts;
	}
	public void setItemcntnts(String itemcntnts) {
		this.itemcntnts = itemcntnts;
	}
	 
}
