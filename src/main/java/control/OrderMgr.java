package control;

public class OrderMgr {
	private static int orderCounter = 0; // 초기 주문 번호 설정

    // 주문 번호 생성 메소드
    public synchronized String generateOrderId() {
        orderCounter++;
        return String.valueOf(orderCounter);
    }
}