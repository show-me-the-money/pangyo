package com.adinstar.pangyo.service;

import com.adinstar.pangyo.constant.PangyoEnum;
import com.adinstar.pangyo.controller.exception.InvalidConditionException;
import com.adinstar.pangyo.mapper.ExecutionRuleMapper;
import com.adinstar.pangyo.model.ExecutionRule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ExecutionRuleService {
    @Autowired
    private ExecutionRuleMapper executionRuleMapper;

    public ExecutionRule getRunningExecuteRule(PangyoEnum.ExecutionRuleType executionRuleType) {
        return executionRuleMapper.selectByTypeAndStatus(executionRuleType, PangyoEnum.ExecutionRuleStatus.RUNNING);
    }

    public long getRunningExecuteRuleId(PangyoEnum.ExecutionRuleType executionRuleType) {
        ExecutionRule executionRule = getRunningExecuteRule(executionRuleType);
        if (executionRule == null) {
            throw InvalidConditionException.EXECUTION_RULE;
        }
        return executionRule.getId();
    }
}