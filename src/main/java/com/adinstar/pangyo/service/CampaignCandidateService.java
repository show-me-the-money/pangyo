package com.adinstar.pangyo.service;

import com.adinstar.pangyo.common.annotation.CheckAuthority;
import com.adinstar.pangyo.common.annotation.HintKey;
import com.adinstar.pangyo.constant.PangyoEnum.CampaignCandidateStatus;
import com.adinstar.pangyo.constant.PangyoEnum.CheckingType;
import com.adinstar.pangyo.constant.PangyoEnum.ExecutionRuleType;
import com.adinstar.pangyo.controller.exception.UnauthorizedException;
import com.adinstar.pangyo.mapper.CampaignCandidateMapper;
import com.adinstar.pangyo.model.CampaignCandidate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

import static com.adinstar.pangyo.common.annotation.HintKey.*;

@Service
public class CampaignCandidateService {
    private static final int DEFAULT_PAGE = 1;
    private static final int LIST_SIZE = 20;

    @Autowired
    private CampaignCandidateMapper campaignCandidateMapper;

    @Autowired
    private ExecutionRuleService executionRuleService;

    public long getRunningExecuteRuleId() {
        return executionRuleService.getRunningExecuteRuleId(ExecutionRuleType.CANDIDATE);
    }

    public List<CampaignCandidate> getRunningList(long starId, Optional<Integer> opPage, Optional<Integer> opSize) {
        int size = opSize.orElse(LIST_SIZE);
        int offset = (opPage.orElse(DEFAULT_PAGE) - DEFAULT_PAGE) * size;
        return campaignCandidateMapper.selectListByStarIdAndExecuteRuleId(starId, getRunningExecuteRuleId(), offset, size);
    }

    public CampaignCandidate getByStarIdAndId(long starId, long id) {
        return campaignCandidateMapper.selectByStarIdAndId(starId, id);
    }

    @CheckAuthority(type = CampaignCandidate.class, checkType = CheckingType.OBJECT, isCheckOwner = false)
    public void add(@HintKey(STAR_ID) long starId, @HintKey(CAMPAIGN_CANDIDATE) CampaignCandidate campaignCandidate) {
        try {
            campaignCandidate.setExecuteRuleId(getRunningExecuteRuleId());
            campaignCandidateMapper.insert(campaignCandidate);
        } catch (DuplicateKeyException ex) {
            // FIXME: 해당 exception이 발생하더라도 campaignCandidate ID가 소진됨
            throw UnauthorizedException.DUPLICATE_CANDIDATE_REGISTER;
        }
    }

    @CheckAuthority(type = CampaignCandidate.class, checkType = CheckingType.OBJECT)
    public void modify(@HintKey(STAR_ID) long starId, @HintKey(CAMPAIGN_CANDIDATE) CampaignCandidate campaignCandidate) {
        campaignCandidateMapper.update(campaignCandidate);
    }

    @CheckAuthority(type = CampaignCandidate.class, checkType = CheckingType.ID)
    public void remove(@HintKey(STAR_ID) long starId, @HintKey(CAMPAIGN_CANDIDATE_ID) long id) {
        campaignCandidateMapper.updateStatus(starId, id, CampaignCandidateStatus.DELETED);
    }

    public void updatePollCount(long id, int delta) {
        campaignCandidateMapper.updatePollCount(id, delta);
    }

    public CampaignCandidate getRunningCandidateByStarIdAndUserId(long starId, long userId) {
        return campaignCandidateMapper.selectByStarIdAndUserIdAndExecuteRuleId(starId, userId, getRunningExecuteRuleId());
    }
}
