package kr.co.sist.user.order;

import java.sql.Date;

public class OrderVO {
    private int orderId;     // NUMBER
    private String userId;      // VARCHAR2(300)
    private String orderName;   // VARCHAR2(250)
    private Date orderDate;     // DATE
    private String orderStatus; // VARCHAR2(20)
    private int totalAmount; // NUMBER(10,2)
    private String orderFlag;   // VARCHAR2(300)

    // Getters and Setters


    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getUserId() {
        return userId;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getOrderName() {
        return orderName;
    }

    public void setOrderName(String orderName) {
        this.orderName = orderName;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }



    public String getOrderFlag() {
        return orderFlag;
    }

    public void setOrderFlag(String orderFlag) {
        this.orderFlag = orderFlag;
    }
}