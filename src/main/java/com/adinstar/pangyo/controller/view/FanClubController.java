package com.adinstar.pangyo.controller.view;


import com.adinstar.pangyo.common.annotation.MustLogin;
import com.adinstar.pangyo.constant.ViewModelName;
import com.adinstar.pangyo.model.ViewerInfo;
import com.adinstar.pangyo.service.CampaignCandidateService;
import com.adinstar.pangyo.service.PostService;
import com.adinstar.pangyo.service.StarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Optional;

import static com.adinstar.pangyo.constant.ViewModelName.*;

@Controller
@RequestMapping("/fanClub/{starId}")
public class FanClubController {

    @Autowired
    private StarService starService;

    @Autowired
    private CampaignCandidateService campaignCandidateService;

    @Autowired
    private PostService postService;

    // checked !! :  팬클럽만 해당 내용을 읽을 수 있나요? 혹은 팬클럽만 글쓰고 투표할 수 있나요???
    @RequestMapping(value = {"", "/"}, method = RequestMethod.GET)
    @MustLogin
    public String getTopFeed(@PathVariable("starId") long starId,
                             @ModelAttribute(ViewModelName.VIEWER) ViewerInfo viewerInfo,
                             Model model) {
        model.addAttribute(STAR, starService.getById(starId));
        model.addAttribute(CAMPAIGN_CANDIDATE_LIST, campaignCandidateService.getRunningList(starId, Optional.of(1), Optional.of(2), null).getList());
        model.addAttribute(POST_FEED, postService.getListByStarId(starId, Optional.empty(), viewerInfo == null ? null : viewerInfo.getId()));

        return "fanClub/list";  // 질문 : 로그인 한 유저만 list를 볼 수 있나요? +  팬클럽 회원만 list를 볼 수 있나요? url 따라오면 어디로 보내면 되나요?
    }
}
