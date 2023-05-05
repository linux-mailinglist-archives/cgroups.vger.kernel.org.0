Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EDD6F842A
	for <lists+cgroups@lfdr.de>; Fri,  5 May 2023 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjEENfk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 May 2023 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjEENfe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 May 2023 09:35:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA32268C
        for <cgroups@vger.kernel.org>; Fri,  5 May 2023 06:35:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6434e263962so1401650b3a.2
        for <cgroups@vger.kernel.org>; Fri, 05 May 2023 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683293727; x=1685885727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3RvOc3E8ZFO1x/9akr2bpEbHeCFqf25nGHeEQGUAU0=;
        b=C0II2oek0zykI2dzG8RkjOqVTRnziAg3YOlg88doaFXBlEhJiIQLAg034eFtxiz6vS
         g4J8GzDJnyaqmfq8f7Z0i//CSTfgoxZmlub414QeBnfVUF727nol+9PHR2yR/xbSMxlC
         o6lH+wAATQI69r76wyrPRw2nujuAx8X1wObPJk0sgB3Vz/JHn+/j7XfVEKvs6waccDv/
         CdMFmqpzeiZ/fuPIhmQYLumv7uRuc7NYm7B7r0Pqre1WB3dgAeBFdvOU/ayOFBBfZ+tn
         VfmjJuCKHmz5I3ZOVgB6eu0R670bvCMWjW2HF8jSwPMJdkvUVsLONN0m2u73Yc+tOvpQ
         7C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683293727; x=1685885727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3RvOc3E8ZFO1x/9akr2bpEbHeCFqf25nGHeEQGUAU0=;
        b=TnYW1M3NXR9PRiBbjSw+Fx9aJBNQzAK8CNKgxgoiioADKaAaorqKxrZMAV7l7eEPiX
         m/242tW7qRjD9Mz5xongYgcig3aFp0Bm5cqWyye4JT0F9ooWTX+zCFVb2KFEoVDBHfgo
         CpDqtLzXn71xg8Z/Qla1zO9Tjl9K7swNYyp967IFFybSDH5N6lZOEHaoWUucJsfC19M8
         51gVDVWE1jtTG09OayqYB2b1mWnyMotXL/0d9Pajg9C5Xke4PgYbR/oj8lYnvJqXCa7N
         qI11Qv67d5iY0Rgcdokt87tvOGZ/sHFoL697VsseQ8dZ5bGow0dal++kNCwmWw5cPbJi
         lj9w==
X-Gm-Message-State: AC+VfDxFFcbUR2Siec2VhQfhJBc6xWGsLdF3zpEJFTxtVRqsykV/SRPT
        dw02tMvhvbdeP/S1Ts/9EENc5Q==
X-Google-Smtp-Source: ACHHUZ7gQMBNAALjAbEgOqi206u0+0pNQfoKvfAbpiw5YTqHAEfnb7ItjMX7kIvFewN7aqFaOrs/fQ==
X-Received: by 2002:a05:6a00:1ad0:b0:63b:5f78:d6db with SMTP id f16-20020a056a001ad000b0063b5f78d6dbmr2357743pfv.21.1683293727288;
        Fri, 05 May 2023 06:35:27 -0700 (PDT)
Received: from [10.254.14.195] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b0062d859a33d1sm1650787pfm.84.2023.05.05.06.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 06:35:26 -0700 (PDT)
Message-ID: <6696100e-e838-d96a-2894-bbca9783d2a3@bytedance.com>
Date:   Fri, 5 May 2023 21:35:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [External] Re: [PATCH v2] blk-throttle: Fix io statistics for
 cgroup v1
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230401094708.77631-1-hanjinke.666@bytedance.com>
 <ZEwY5Oo+5inO9UFf@righiandr-XPS-13-7390>
 <eb2eeb6b-07da-4e98-142c-da1e7ea35c2b@bytedance.com>
 <ZFQf3TCs7DqsSR8l@righiandr-XPS-13-7390>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <ZFQf3TCs7DqsSR8l@righiandr-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2023/5/5 上午5:13, Andrea Righi 写道:
> On Thu, May 04, 2023 at 11:08:53PM +0800, hanjinke wrote:
>> Hi
>>
>> Sorry for delay（Chinese Labor Day holiday).
> 
> No problem, it was also Labor Day in Italy. :)
> 
>>
>> 在 2023/4/29 上午3:05, Andrea Righi 写道:
>>> On Sat, Apr 01, 2023 at 05:47:08PM +0800, Jinke Han wrote:
>>>> From: Jinke Han <hanjinke.666@bytedance.com>
>>>>
>>>> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
>>>> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
>>>> the only stable io stats interface of cgroup v1, and these statistics
>>>> are done in the blk-throttle code. But the current code only counts the
>>>> bios that are actually throttled. When the user does not add the throttle
>>>> limit, the io stats for cgroup v1 has nothing. I fix it according to the
>>>> statistical method of v2, and made it count all ios accurately.
>>>>
>>>> Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
>>>> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
>>>
>>> Thanks for fixing this!
>>>
>>> The code looks correct to me, but this seems to report io statistics
>>> only if at least one throttling limit is defined. IIRC with cgroup v1 it
>>> was possible to see the io statistics inside a cgroup also with no
>>> throttling limits configured.
>>>
>>> Basically to restore the old behavior we would need to drop the
>>> cgroup_subsys_on_dfl() check, something like the following (on top of
>>> your patch).
>>>
>>> But I'm not sure if we're breaking other behaviors in this way...
>>> opinions?
>>>
>>>    block/blk-cgroup.c   |  3 ---
>>>    block/blk-throttle.h | 12 +++++-------
>>>    2 files changed, 5 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>> index 79138bfc6001..43af86db7cf3 100644
>>> --- a/block/blk-cgroup.c
>>> +++ b/block/blk-cgroup.c
>>> @@ -2045,9 +2045,6 @@ void blk_cgroup_bio_start(struct bio *bio)
>>>    	struct blkg_iostat_set *bis;
>>>    	unsigned long flags;
>>> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
>>> -		return;
>>> -
>>>    	/* Root-level stats are sourced from system-wide IO stats */
>>>    	if (!cgroup_parent(blkcg->css.cgroup))
>>>    		return;
>>> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
>>> index d1ccbfe9f797..bcb40ee2eeba 100644
>>> --- a/block/blk-throttle.h
>>> +++ b/block/blk-throttle.h
>>> @@ -185,14 +185,12 @@ static inline bool blk_should_throtl(struct bio *bio)
>>>    	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
>>>    	int rw = bio_data_dir(bio);
>>> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
>>> -		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
>>> -			bio_set_flag(bio, BIO_CGROUP_ACCT);
>>> -			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
>>> -					bio->bi_iter.bi_size);
>>> -		}
>>> -		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
>>> +	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
>>> +		bio_set_flag(bio, BIO_CGROUP_ACCT);
>>> +		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
>>> +				bio->bi_iter.bi_size);
>>>    	}
>>> +	blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
>>

I checked the code again. If we remove cgroup_subsys_on_dfl check here, 
io statistics will still be performed in the case of v2, which I think 
is unnecessary, and this information will be counted to 
io_service_bytes/io_serviced, these two files are not visible in v2. Am 
I missing something?

Thanks.
Jinke
