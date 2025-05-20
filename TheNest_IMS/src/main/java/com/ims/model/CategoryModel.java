package com.ims.model;

public class CategoryModel {
    private int id;
    private String name;
    private String icon;
    private String description;
    private int productCount;
    private String lastUpdated;

    public CategoryModel() {
    }

    public CategoryModel(int id, String name, String icon, String description) {
        this.id = id;
        this.name = name;
        this.icon = icon;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getIcon() {
        return icon;
    }

    public String getDescription() {
        return description;
    }

    public int getProductCount() {
        return productCount;
    }

    public String getLastUpdated() {
        return lastUpdated;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }

    public void setLastUpdated(String lastUpdated) {
        this.lastUpdated = lastUpdated;
    }
}