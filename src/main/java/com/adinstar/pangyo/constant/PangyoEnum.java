package com.adinstar.pangyo.constant;

public class PangyoEnum {
    public enum UserStatus { MEMBER, DELETED }
    public enum PostStatus { SERVICE, DELETED }
    public enum CampaignStatus { SERVICE, DELETED }
    public enum CampaignCandidateStatus { SERVICE, DELETED, SELECTED }
    public enum ContentType { POST, CANDIDATE, CAMPAIGN }
    public enum CommentStatus { SERVICE, DELETED }
    public enum ExecutionRuleType { CAMPAIGN, CANDIDATE, AD }
    public enum ExecutionRuleStatus { READY, RUNNING, DONE, END }
    public enum LovKey { COMMENT, POST, LIKE, SUPPORT }
    public enum PolicyKey { COMMENT, POST, LIKE,
                            CANDIDATE_RANGE, CANDIDATE_DONE_DATE, CAMPAIGN_RANGE, CAMPAIGN_DONE_DATE }
}