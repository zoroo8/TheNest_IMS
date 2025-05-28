package com.ims.model;

public class RequestProductUserModel {
    private int productId;
    private int quantity;
    private int userId;

    public RequestProductUserModel() {}

    public RequestProductUserModel(int productId, int quantity) {
        this.productId = productId;
        this.quantity = quantity;
    }
    
	public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

    
}
