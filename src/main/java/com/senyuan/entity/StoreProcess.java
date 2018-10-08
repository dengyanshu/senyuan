package com.senyuan.entity;

public class StoreProcess {
    private Integer spId;

    private String spName;

    private String spAuthor;

    private String spDatabase;

    private String spFunction;

    private String spComment;

    public Integer getSpId() {
        return spId;
    }

    public void setSpId(Integer spId) {
        this.spId = spId;
    }

    public String getSpName() {
        return spName;
    }

    public void setSpName(String spName) {
        this.spName = spName == null ? null : spName.trim();
    }

    public String getSpAuthor() {
        return spAuthor;
    }

    public void setSpAuthor(String spAuthor) {
        this.spAuthor = spAuthor == null ? null : spAuthor.trim();
    }

    public String getSpDatabase() {
        return spDatabase;
    }

    public void setSpDatabase(String spDatabase) {
        this.spDatabase = spDatabase == null ? null : spDatabase.trim();
    }

    public String getSpFunction() {
        return spFunction;
    }

    public void setSpFunction(String spFunction) {
        this.spFunction = spFunction == null ? null : spFunction.trim();
    }

    public String getSpComment() {
        return spComment;
    }

    public void setSpComment(String spComment) {
        this.spComment = spComment == null ? null : spComment.trim();
    }
}