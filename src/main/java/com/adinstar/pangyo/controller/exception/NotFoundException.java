package com.adinstar.pangyo.controller.exception;

import com.adinstar.pangyo.constant.PangyoErrorMessage;

public class NotFoundException extends RuntimeException {
    public static final NotFoundException CAMPAIGN_CANDIDATE = new NotFoundException(PangyoErrorMessage.NOT_FOUND_CAMPAIGN_CANDIDATE);

    public NotFoundException(String msg) {
        super(msg);
    }
}