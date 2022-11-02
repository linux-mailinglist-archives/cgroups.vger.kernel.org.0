Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E908C615756
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 03:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiKBCJy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 22:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKBCJy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 22:09:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B9B1D0F3
        for <cgroups@vger.kernel.org>; Tue,  1 Nov 2022 19:09:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z26so1999488pff.1
        for <cgroups@vger.kernel.org>; Tue, 01 Nov 2022 19:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/9nbqKAy6prDAS3oMmtklZfg/ZbEspQaEJ48FmeAmc=;
        b=TrwwCrLqC7JAM1Uu/+yafOAtWgX5dY7pPM2NvZ69AMrgl3UEFM/DscGiTUUHN3pc+L
         uS7v2QJimbqhm1WnG9dnmFDRtAK7Yte8g4pmcY2GKK2Ytn0tZg9J9Dfz0LlYaXEDDxsx
         iiTD4UyqQ9/VzWkjBXBux22f7w4atH83ns9iux6Su51579Sjj45hARf3lqY0yH2OoybV
         v0M5WTlBw12gNGR7yEzNR+v5pJXL2RhLDZb6KkB4LTw9dVwWz1JNVzxYWwMm3Og/CFZy
         yEUtvs6A3IVvM93m1EbIcurAyJwCjGIC2c1FgMU708u88XVXA0b3UxJKLzPm463agT6c
         ZJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/9nbqKAy6prDAS3oMmtklZfg/ZbEspQaEJ48FmeAmc=;
        b=sZGh3kQzcvKG0t8fsJbPeHwb24aa/PJ0/k2mbyGYAbrK+u5v6oyMIgDpILEtSiBuLX
         sj7WgN0dqy/s+SPoTjHDLqzW8znYjvyRuM4Z8/6VglnrN1vkHBwULKyu1brpEBw8DRpA
         VqXF/fJgPjEXSQUqjKDEUQOKcxxbI3IQOcwlhSfUzlUNdv/FyKwcHkF04akBMeUBOzce
         3qPHqtUE8+cBAChYiIC3/hQOwCSmnffCtMr9vfZQXMQQ636T7QUJ3BS2NchSPwxh6NC0
         zsHltDV3SJZWj5SU57cI/b1uXIcIsJ4mNn2vFVA0VigGOrTTbtPwZSUC+P2QovdiABII
         +jxw==
X-Gm-Message-State: ACrzQf1NCgQC7mfyhTysh/VAvb6+r0O4rqRy8FocWJ0rfgyQOzFV/QGJ
        qjDhf32o2JehhmUxMhbrqMU7TA==
X-Google-Smtp-Source: AMsMyM6nfZ1Xf117LD/8Qlkj1bOJKmYdrnP9WwitZHJYBeZMfYqBJCmperWW+vBpF2o56y/62TQwcQ==
X-Received: by 2002:a63:35c6:0:b0:470:d38:7c63 with SMTP id c189-20020a6335c6000000b004700d387c63mr17783pga.249.1667354992155;
        Tue, 01 Nov 2022 19:09:52 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b0016c9e5f291bsm7018876plk.111.2022.11.01.19.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 19:09:51 -0700 (PDT)
Message-ID: <7f7e59cb-e0b8-0db5-7c46-11aea963bcfa@kernel.dk>
Date:   Tue, 1 Nov 2022 20:09:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH -next v4 1/5] block, bfq: remove set but not used variable
 in __bfq_entity_update_weight_prio
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz,
        paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
References: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
 <20221102022542.3621219-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221102022542.3621219-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/1/22 8:25 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> After the patch "block, bfq: cleanup bfq_weights_tree add/remove apis"),
> the local variable 'bfqd' is not used anymore, thus remove it.

Please add a Fixes tag.

-- 
Jens Axboe


