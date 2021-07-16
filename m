Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3613CBF98
	for <lists+cgroups@lfdr.de>; Sat, 17 Jul 2021 01:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbhGPXKY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 19:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbhGPXKX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jul 2021 19:10:23 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F82CC06175F;
        Fri, 16 Jul 2021 16:07:28 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t9so11450890pgn.4;
        Fri, 16 Jul 2021 16:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P6K+M5gqphiIlNgiFVLzyTugz5hPofZVAtQFiBp7d9s=;
        b=ullVU331i6gIy4bDcdWB3Z/mYU0uuO8Zz4+zTPF4DwwlLYBpWuoLo8phBHSXV0zQ7I
         SnHGjhyqsblUks+TDqDyRg4ZJkN2L9qsQLpMeWKT7t2h8zLaPWdo1UYACdUf3Xt6tIwd
         xB4cZZL3MNrmfbw7bGVtnvkjs5Vu7ZmfUO4pZ8XbSiiJeBdR3nAAJ+Su2ue+vfNRElSD
         5PG0YGgodlVwx9uT7QnwAZcpoSzxV7h1nEUvVATn3P0i1EsFusZbwh3n3m8MC2cgND5M
         fw4uP+kNHZBoBmDmHLFdtj6j4Wj3usLgezpO6JfVgH0i+0WPB26yOjAL/vNUUtDFWces
         mi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P6K+M5gqphiIlNgiFVLzyTugz5hPofZVAtQFiBp7d9s=;
        b=DCAmJcFxMsNX9bzvKg58M7Zek3nOEPQgb4VI+Hfv9IuM/7oKAZns1p/3eSRq5iU+E7
         qkvRI8NwZhLcAoWGt8jRPko1nc+QIGaNFq9KHBT5Im5F1YVZVrjd+npsz/Vv/P7HBwrx
         dwMszhxWW6EUWmGj4ESwYdgEqMTvc6hRSbAcuZ+dMWBzuNoNoigBbLcG2qkAGkGp5vJc
         bPmBTIJmEzpAgKEhy0K8E3jCAt2NrPK0R+2q5z+LwgUYohJuoVMbn8wAIqklMeMfRjuW
         7X6U1/TkohH6VgREq+YGpL1RyVx1d35MEdeYRbxaHBaNBuvIBMjsoSNxno1gAM8AdJE1
         s2OA==
X-Gm-Message-State: AOAM530a2QseeSPzAIcrfprp0WGS7S8gUm7KMD0irA/3M5mtUJUxwY7F
        T070NeV5Wbl1oaEkTKji72R8RAUlmiwROeDr
X-Google-Smtp-Source: ABdhPJw9dJ72rSe9XLZ950WY6ydjbUXyufvsG1vehWYDSoNNiFiTRd6IP+Ld9+E2/C3EdBToTL1ZlA==
X-Received: by 2002:a63:d811:: with SMTP id b17mr12203456pgh.286.1626476847524;
        Fri, 16 Jul 2021 16:07:27 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id x9sm11224635pfd.100.2021.07.16.16.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 16:07:27 -0700 (PDT)
Subject: Re: [PATCH] blk-throtl: optimize IOPS throttle for large IO scenarios
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1626416569-30907-1-git-send-email-brookxu.cn@gmail.com>
 <YPGvIzZUI+QxP1js@mtj.duckdns.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <9d8b584a-738b-a0a8-ea8c-e617c2f79408@gmail.com>
Date:   Sat, 17 Jul 2021 07:07:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPGvIzZUI+QxP1js@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Tejun Heo wrote on 2021/7/17 0:09:
> Hello,
> 
> On Fri, Jul 16, 2021 at 02:22:49PM +0800, brookxu wrote:
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
> I don't think we're holding the queue lock here.

sorry, some kind of synchronization mechanism is really needed here. But the use of queue_lock
here may be unsafe, since it is difficult for us to control the lock on the split path.

>>  	}
>>  }
>>  
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index b1b22d8..1967438 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -2176,6 +2176,40 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
>>  }
>>  #endif
>>  
>> +void blk_throtl_recharge_bio(struct bio *bio)
>> +{
>> +	bool rw = bio_data_dir(bio);
>> +	struct blkcg_gq *blkg = bio->bi_blkg;
>> +	struct throtl_grp *tg = blkg_to_tg(blkg);
>> +	u32 iops_limit = tg_iops_limit(tg, rw);
>> +
>> +	if (iops_limit == UINT_MAX)
>> +		return;
>> +
>> +	/*
>> +	 * If previous slice expired, start a new one otherwise renew/extend
>> +	 * existing slice to make sure it is at least throtl_slice interval
>> +	 * long since now. New slice is started only for empty throttle group.
>> +	 * If there is queued bio, that means there should be an active
>> +	 * slice and it should be extended instead.
>> +	 */
>> +	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
>> +		throtl_start_new_slice(tg, rw);
>> +	else {
>> +		if (time_before(tg->slice_end[rw],
>> +		    jiffies + tg->td->throtl_slice))
>> +			throtl_extend_slice(tg, rw,
>> +				jiffies + tg->td->throtl_slice);
>> +	}
>> +
>> +	/* Recharge the bio to the group, as some BIOs will be further split
>> +	 * after passing through the throttle, causing the actual IOPS to
>> +	 * be greater than the expected value.
>> +	 */
>> +	tg->last_io_disp[rw]++;
>> +	tg->io_disp[rw]++;
>> +}
> 
> But blk-throtl expects queue lock to be held.
> 
> How about doing something simpler? Just estimate how many bios a given bio
> is gonna be and charge it outright? The calculation will be duplicated
> between the split path but that seems like the path of least resistance
> here.

I have tried this method, the code redundancy is indeed a bit high, it may not be
very convenient for code maintenance. In addition to this problem, since we add
a large value at a time, the fluctuation of IOPS will be relatively large. Since
blk_throtl_recharge_bio() does not need to participate in the maintenance of the
state machine, we only need to protect some fields of tg, so can we add a new
spin_lock to tg instead of queue_lock to solve the synchronization problem ? Just
a idea, Thanks.

> Thanks.
> 
