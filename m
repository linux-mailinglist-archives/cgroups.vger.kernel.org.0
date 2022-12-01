Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CED363E7CF
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 03:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLAC2b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 21:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLAC2b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 21:28:31 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBCA83269
        for <cgroups@vger.kernel.org>; Wed, 30 Nov 2022 18:28:30 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f9so432809pgf.7
        for <cgroups@vger.kernel.org>; Wed, 30 Nov 2022 18:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQxLjfQwIIvkV52Cq7O9nwAx6kWt8ENkkmDOLlFKoJE=;
        b=Yr+GJT7Asyn8ksHLJb8PHRHQ0PgiYUJS0szobNfBh9q8vCtukZC/KybtLZINJ0r5DD
         D6RqNJK+FJwfuiYlzyckD7Bpawc36ptDJvHEI6BGMdgqQ67CsqJURcaBhkl3ug6zUSYI
         nMOQ2jjDH4voFqRyNAz+EWPJj2fqyptaAec+7QwPx7lLitNthkDdOFhLlr/O4hjkkWg3
         uR4e35sqVKLwqImAZEEZMyo4l6u4iCKZjzrdAJZLJmjLYz2La3KljmRH2U6q248Z0RGW
         QAhEc92zJQ6f3NDlrUzb2LDCq0kEbaWuAj+lMu2aLCtEzaJjpWO2rs6qLWxu6t3WxZ+Y
         +HPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQxLjfQwIIvkV52Cq7O9nwAx6kWt8ENkkmDOLlFKoJE=;
        b=2Xdqgxms/WI5hRveU25kZFcLp1lOTr7t2sXptqSGfcwuhQQFlSbLKlRuTlj+9wilyf
         Jbu1ebibhsQSoC1HDWjFvPc/VMgTZJoWw8Ka9AhrMSvyVZR66dRMyFe3ryK4fkbkPzfj
         FexjspcwIUxPJ1tfuDlYw2b2PgPD6Q1lkCWzLLGZJX37mp5kjtvHHUV+rja17EydesYt
         Lov46Bf66NKr0EfiEYjd+NYqcdW2cvhcAupRtc5DlcoJjzh7IO3UjctMm9yCHNzitunA
         SXGfzpI/DlF5p7aqkDAe3thqO4pW1hdg0a0848aQl6/Ubs6XP3NsYbzd6ERho27tsM8x
         3Bjw==
X-Gm-Message-State: ANoB5pnzdBnkPnsfN+xL6uVxc3APGfMcGbr8ksRDZknRKmTUUVVu0Aqe
        0D6RAW9P8Ep61E/qVlZ528g64A==
X-Google-Smtp-Source: AA0mqf7l9SM37E/C6rBrg4ybq8+g/2jcr9pkHJQFrguoAFYl+YoWHz1wTjg1TPfMtmJXyEpYa9GjHQ==
X-Received: by 2002:aa7:8d5a:0:b0:560:eec2:d0ab with SMTP id s26-20020aa78d5a000000b00560eec2d0abmr66005155pfe.43.1669861709389;
        Wed, 30 Nov 2022 18:28:29 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902c64100b00189240585a7sm2144426pls.173.2022.11.30.18.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 18:28:28 -0800 (PST)
Message-ID: <f4924808-7f53-1ad0-a550-45386fc157ec@kernel.dk>
Date:   Wed, 30 Nov 2022 19:28:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/5] A few cleanup and bugfix patches for blk-iocost
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221018121932.10792-1-shikemeng@huawei.com>
 <93f9093b-abec-db7e-a945-263cd9355c08@huaweicloud.com>
 <bd008582-1509-69f3-1812-2b9caa390c05@kernel.dk>
 <8d9c98e5-0433-e025-ccec-4144102e91c5@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8d9c98e5-0433-e025-ccec-4144102e91c5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/30/22 7:20 PM, Kemeng Shi wrote:
> 
> 
> on 12/1/2022 9:46 AM, Jens Axboe wrote:
>> On 11/30/22 6:45?PM, Kemeng Shi wrote:
>>>
>>> Hi jens,
>>> on 10/18/2022 8:19 PM, Kemeng Shi wrote:
>>>> This series contain a few patch to correct comment, correct trace of
>>>> vtime_rate and so on. More detail can be found in the respective
>>>> changelogs.
>>>>
>>>> ---
>>>> v2:
>>>>  Thanks Tejun for review and comment!
>>>>  Add Acked-by tag from Tejun.
>>>>  Correct description in patch 3/5 and 4/5.
>>>>  Drop "blk-iocost: Avoid to call current_hweight_max if iocg->inuse
>>>> == iocg->active"
>>>>  Drop "blk-iocost: Remove redundant initialization of struct ioc_gq"
>>>>  Drop "blk-iocost: Get ioc_now inside weight_updated"
>>>> ---
>>>>
>>>> Kemeng Shi (5):
>>>>   blk-iocost: Fix typo in comment
>>>>   blk-iocost: Reset vtime_base_rate in ioc_refresh_params
>>>>   blk-iocost: Trace vtime_base_rate instead of vtime_rate
>>>>   blk-iocost: Remove vrate member in struct ioc_now
>>>>   blk-iocost: Correct comment in blk_iocost_init
>>>>
>>>>  block/blk-iocost.c            | 16 +++++++++-------
>>>>  include/trace/events/iocost.h |  4 ++--
>>>>  2 files changed, 11 insertions(+), 9 deletions(-)
>>> Could you apply this patchset?
>>> By the way, my apply for an cloud variant of email was just passed
>>> a few days ago. Is this mail still in spam?
>>
>> This one wasn't, but I've seen the huaweicloud.com emails fail
>> the same origination checks in the past.
> I'm not sure if was there any fix to huaweicloud.com email. I will
> use this huaweicloud emails to minimize the trouble before any
> better solution is found. Sorry for the inconvenience.

Thanks, I'll let you know if I run into issues with the cloud
email.

-- 
Jens Axboe


