package shop;

import java.util.Hashtable;

// 장바구니 기능을 session 관리. DB x
// session은 서버에 클라이언트 정보를 저장하는 바구니
public class CartMgr {
	
	private Hashtable<Integer, OrderBean> hCart = 
			new Hashtable<Integer, OrderBean>();
	
	// Cart Add : 기존에 장바구니에 동일한 상품이 있는 경우를 고려
	public void addCart(OrderBean order) {
		int productNo = order.getProductNo(); // 상품 번호
		int quantity = order.getQuantity(); // 주문수량
		if(quantity > 0) {
			if(hCart.containsKey(productNo)) { // 동일한 상품번호로 장바구니에 있는가?
				// 기본에 주문객체를 장바구니에서 리턴
				OrderBean temp = hCart.get(productNo);
				quantity += temp.getQuantity(); // 수량을 덧셈
				order.setQuantity(quantity);
				hCart.put(productNo, order);
			} 
			hCart.put(productNo, order);
		}
	}
	
	// Cart Delete
	public void deleteCart(OrderBean order) {
		hCart.remove(order.getProductNo()); // 상품 번호 -> key값
	}
	
	// Cart Update : Hashtable 동일한 key값 put되면 덮어쓰기
	public void updateCart(OrderBean order) {
		hCart.put(order.getProductNo(), order); // 상품 번호 -> key값
	}
	
	// Car hCat
	public Hashtable<Integer, OrderBean> getCartList(){
		return hCart;
	}
	
}
