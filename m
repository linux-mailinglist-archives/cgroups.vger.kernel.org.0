Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B3A3DB107
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 04:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbhG3CJr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 22:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhG3CJq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 22:09:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8779C061765;
        Thu, 29 Jul 2021 19:09:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q2so9194955plr.11;
        Thu, 29 Jul 2021 19:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mQTBEXw5fXJfZ/TwuYgDsyZEqK+e8q8zwd2JV8rkUI4=;
        b=OfGWAGjzAWRnxyGCUY9JGgohLkj7/XotbZNbRMRePBmKhyRjovGp4Mil5rMe9Bfe8w
         28R6ip0kNr8cokWRSu+7t/PM0bcWy+SVysaVQg3HVxKhC064UJfUNHT+7HiPOY8OLYaV
         VQC9I7qXtGfo7eJoro5z1WriftwnGTe0NWAgEp5PTDldjw+L2KmlJYT5NBUP6EpGQ5Te
         26vFNtMlVFW7hQO/E65B5quQa9NuFlPS2YLbSjPWpuZ+ssAfOcDfRATVFkoV7H2/CelC
         vHj4AYfKOmdQWJcskAr8/ted2PMQXBvqb27RSFk06zZ2Me8zb44z55P0wTzyD8eSlwZ4
         61dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mQTBEXw5fXJfZ/TwuYgDsyZEqK+e8q8zwd2JV8rkUI4=;
        b=mXGHZyC9ICHwWnjsdBnRi+Vns/qhltHiS7wZTR9zoOXm1XWuyjbcZl7s/bqbN+eTcc
         inYSauRE8wnEDVodFUwoShdLqbbcsOk+Gtk2S86bTxNi4gXMlXA56MB2DGh6ICEoUB9T
         zLUZrNtwDmFH+5VMEy1QaB5F4su9J9tcXL4MNij/Jn2OD2q47M0SQdpQzGr9C+XFYMhS
         XGc/jYAhX6Ndc7R0BH8Y6+L5fmuhxxS6hWi9p6MQ3ou1wp2fBTMgAdTIqpsBbPzjQDBC
         qxGALyv7I+3AlKF2EXxnThV1mZA80bhIFUAuBTuzwcJq+p67ncPJbFASYFUtN0ee+0fP
         lCdw==
X-Gm-Message-State: AOAM531LXxhe1AB8mfCwxLJcb09T2HkVRCg31bh34MNm7EXN+tiXSYS0
        hbRMobVG3VTyqasRA53ZPqYCWkO+ZmbSyQ==
X-Google-Smtp-Source: ABdhPJxzYy0eDc122NozJm3aBmbqmBJ5fVRTEXvGjyk5uvhCfuUmHEXE6dQCDztcS/LXKKxZNjPh0g==
X-Received: by 2002:a17:903:300d:b029:12c:916f:fedd with SMTP id o13-20020a170903300db029012c916ffeddmr255937pla.19.1627610982286;
        Thu, 29 Jul 2021 19:09:42 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.114])
        by smtp.gmail.com with ESMTPSA id x19sm145629pfa.104.2021.07.29.19.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 19:09:41 -0700 (PDT)
Subject: Re: [PATCH v2] blk-throtl: optimize IOPS throttle for large IO
 scenarios
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <40915233274d31bb0659ff9f3be8900a5a0e81ba.1627462548.git.brookxu@tencent.com>
 <YQLhRrkZrmKTzfbP@mtj.duckdns.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <1ce9bcbb-8eea-f51f-f80a-22caf5f2e0d8@gmail.com>
Date:   Fri, 30 Jul 2021 10:09:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQLhRrkZrmKTzfbP@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks for you time.

Tejun Heo wrote on 2021/7/30 1:11 上午:
> Hello,
> 
> On Wed, Jul 28, 2021 at 05:01:41PM +0800, brookxu wrote:
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index a11b3b5..86ff943 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -348,6 +348,8 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
>>  		trace_block_split(split, (*bio)->bi_iter.bi_sector);
>>  		submit_bio_noacct(*bio);
>>  		*bio = split;
>> +
>> +		blk_throtl_recharge_bio(*bio);
> 
> Can you rename this blk_throtl_charge_bio_split()?

Ok, i will do it in next version.

>> @@ -524,6 +537,11 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp,
>>  	tg->idletime_threshold = DFL_IDLE_THRESHOLD;
>>  	tg->idletime_threshold_conf = DFL_IDLE_THRESHOLD;
>>  
>> +	atomic_set(&tg->io_split_cnt[0], 0);
>> +	atomic_set(&tg->io_split_cnt[1], 0);
>> +	atomic_set(&tg->last_io_split_cnt[0], 0);
>> +	atomic_set(&tg->last_io_split_cnt[1], 0);
> 
> We likely don't need these. pd's zeroed on allocation.

Right, i will remove these init code.

>> @@ -877,10 +900,19 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>>  	else
>>  		tg->bytes_disp[rw] = 0;
>>  
>> -	if (tg->io_disp[rw] >= io_trim)
>> +	if (tg_io_disp(tg, rw) >= io_trim) {
> 
> Instead of checking this in multiple places, would it be simpler to transfer
> the atomic counters to the existing counters whenever we enter blk-throtl
> and leave the rest of the code as-is?

If we do this, we need to do similar processing on the bio submission path and the bio
resubmission path in pending_timer. It seems that the code is more complicated?

> Thanks.
> 
