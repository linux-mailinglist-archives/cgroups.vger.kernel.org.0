Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A887A6F6EAC
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 17:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjEDPJX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjEDPJF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 11:09:05 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED61B40C5
        for <cgroups@vger.kernel.org>; Thu,  4 May 2023 08:08:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b35789313so460059b3a.3
        for <cgroups@vger.kernel.org>; Thu, 04 May 2023 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683212939; x=1685804939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFa1D5Tpf/QrQJM5h3CrUwGz4UKarPH+tDSx3KZiqW0=;
        b=DNqvvH4fVrTxxmy3uWocPqMrVQzGrvn1bKV/DBRhuLaJP6xVuRfHqmbHfrevd1owR/
         jiCrzjiOJ6WKw3SidjtKGTAo3Kw6pc6zVNOe6oEJ3Q7NwivVlUyL5fyWvqWOdTYm67kg
         bB8EjQA5ooh95ZqFlEOhksFT0f1AAMr4Zq0N5VHLOQUfiSYQ2Jc4c9mMxf5zpl9GlztJ
         79At54zrwpPkmPzu2hgVlWkTkzYQtfrDyMp6XW8rtYcSI5MAQsYKVXYMVqd667juw5MI
         6RoawcuDBmVVXahW627FRVPS71JWh8CGrpk9MFh7Dh0Tq7PtZCP2VYWXY72KPg5byozj
         1LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212939; x=1685804939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OFa1D5Tpf/QrQJM5h3CrUwGz4UKarPH+tDSx3KZiqW0=;
        b=C9nCJmjX5k36Nzqt6ba95qc5e0Lh+Qs5l8gbs+V1o0rx202nzR8qLY3N2rxBMVhbWu
         9ne8hHQPee7grO6KdgaZ17jxJSWVbEESDIaI4fOYnTxrc1/cnjtoSlKzKU4YeLv/bKGL
         RVuKqPBrAZXJQuseZ1sAgyrHMb3JkfHNN53t9J8cfUBfXocMrTuu8apIR0Pn9QTS7fy/
         /G9c/YoxsQh2HveqfvctUJNicIvfos/m0xs08NdXaLqsJ85RxLImrk7g8W6RUIXCDH0n
         JlM4YnUSfxtS0DlgmkLJIvBgbpV2AzyiDsL/NQTqYzLJiWkCwlqqdgec3n91O8wSY6e/
         68gQ==
X-Gm-Message-State: AC+VfDwXGZxnAvrSkWt1gHrBBpOKVtKAaoGnVPX023XUW3bo523n/3zi
        voyNMUogjuXNnNrcbLqpEnYsVg==
X-Google-Smtp-Source: ACHHUZ7b8yMStegf41qN6JKvTRQVyQ3nCGCRxb9QEu/dI4w/6IChTI343PJi8jI6S37UwLLoQfMuuQ==
X-Received: by 2002:a05:6a00:23d1:b0:63d:311a:a16b with SMTP id g17-20020a056a0023d100b0063d311aa16bmr2998351pfc.23.1683212939365;
        Thu, 04 May 2023 08:08:59 -0700 (PDT)
Received: from [10.255.14.217] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id u21-20020aa78495000000b0063d24fcc2besm1753144pfn.125.2023.05.04.08.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:08:58 -0700 (PDT)
Message-ID: <eb2eeb6b-07da-4e98-142c-da1e7ea35c2b@bytedance.com>
Date:   Thu, 4 May 2023 23:08:53 +0800
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
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <ZEwY5Oo+5inO9UFf@righiandr-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi

Sorry for delay（Chinese Labor Day holiday).

在 2023/4/29 上午3:05, Andrea Righi 写道:
> On Sat, Apr 01, 2023 at 05:47:08PM +0800, Jinke Han wrote:
>> From: Jinke Han <hanjinke.666@bytedance.com>
>>
>> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
>> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
>> the only stable io stats interface of cgroup v1, and these statistics
>> are done in the blk-throttle code. But the current code only counts the
>> bios that are actually throttled. When the user does not add the throttle
>> limit, the io stats for cgroup v1 has nothing. I fix it according to the
>> statistical method of v2, and made it count all ios accurately.
>>
>> Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
>> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
> 
> Thanks for fixing this!
> 
> The code looks correct to me, but this seems to report io statistics
> only if at least one throttling limit is defined. IIRC with cgroup v1 it
> was possible to see the io statistics inside a cgroup also with no
> throttling limits configured.
> 
> Basically to restore the old behavior we would need to drop the
> cgroup_subsys_on_dfl() check, something like the following (on top of
> your patch).
> 
> But I'm not sure if we're breaking other behaviors in this way...
> opinions?
> 
>   block/blk-cgroup.c   |  3 ---
>   block/blk-throttle.h | 12 +++++-------
>   2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 79138bfc6001..43af86db7cf3 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -2045,9 +2045,6 @@ void blk_cgroup_bio_start(struct bio *bio)
>   	struct blkg_iostat_set *bis;
>   	unsigned long flags;
>   
> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
> -		return;
> -
>   	/* Root-level stats are sourced from system-wide IO stats */
>   	if (!cgroup_parent(blkcg->css.cgroup))
>   		return;
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index d1ccbfe9f797..bcb40ee2eeba 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -185,14 +185,12 @@ static inline bool blk_should_throtl(struct bio *bio)
>   	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
>   	int rw = bio_data_dir(bio);
>   
> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> -		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
> -			bio_set_flag(bio, BIO_CGROUP_ACCT);
> -			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> -					bio->bi_iter.bi_size);
> -		}
> -		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
> +	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
> +		bio_set_flag(bio, BIO_CGROUP_ACCT);
> +		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> +				bio->bi_iter.bi_size);
>   	}
> +	blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);

It seems that statistics have been carried out in both v1 and v2，we can 
get the statistics of v2 from io.stat, is it necessary to count v2 here?


