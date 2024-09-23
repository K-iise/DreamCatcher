package entity;

public class priceBean {
	
	private int price_num;
	private int price_funding_num;
	private String price_comp;
	private int price;
	
	public int getPrice_num() {
		return price_num;
	}
	public void setPrice_num(int price_num) {
		this.price_num = price_num;
	}
	public int getPrice_funding_num() {
		return price_funding_num;
	}
	public void setPrice_funding_num(int price_funding_num) {
		this.price_funding_num = price_funding_num;
	}
	public String getPrice_comp() {
		return price_comp;
	}
	public void setPrice_comp(String price_comp) {
		this.price_comp = price_comp;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getPrice_count() {
		return price_count;
	}
	public void setPrice_count(int price_count) {
		this.price_count = price_count;
	}
	private int price_count;

}
