Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6273C44C542
	for <lists+cgroups@lfdr.de>; Wed, 10 Nov 2021 17:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhKJQrS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Nov 2021 11:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhKJQrR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Nov 2021 11:47:17 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3AFC061767
        for <cgroups@vger.kernel.org>; Wed, 10 Nov 2021 08:44:29 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id n15so2744778qta.0
        for <cgroups@vger.kernel.org>; Wed, 10 Nov 2021 08:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZCxppkGRFPsisss/DePYM7NyPAJRZFk6RHTjGPknvLs=;
        b=28ajj1Fad3jjq+pJTimln90y/+YAp3rK8HrgZJ21bws99je/aLNwJ1RbEpp+VOFLI5
         wziDVyxazBE/4vX294wuICHRhpFBHB277qKLsw4E7XbZCqlr79wMi6mexuoOlNCT2KUg
         +NThEa6rl1rpAb+x7b8Rg4YUzUR8AM6Ceh3SYN01pPaJ/6Lyf5BF97stdDC1tk/xfD4L
         MatKRp0x77doAxnpSTgyQIAE+RbjFZK+sFICvR5ftw0sObz/cQGUCjcW4BHDuCaT/UW7
         ZtSdZBb+RcfyxV4BMmMhvyBiL+x9D+twDGmCbtBBWkQJXPNaKFaLz1F5nl/w/CkVPb7q
         dY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZCxppkGRFPsisss/DePYM7NyPAJRZFk6RHTjGPknvLs=;
        b=uKNQnSadmdXDWqsAKQ3VopWtnW/DipMbMo5vuEHnl2QJ3oV/bpQzuEDWJxF6gQ2azT
         quWFHdwlG2KV5eGj/4U4ckW9NgidO/BWc+oaOJOqzAEACDgqvs42+LyBe6hscTt18AgL
         T1Pwp7jnU5nLsPqqb4L0oX3T+e1sKXCJ+G8YhS4jTV/bZASbgtngMByjkQLOHIqTENpm
         DYqxdMX/rjVC9gMOrZlsk1OZBv1NVvChORDJrVlaf5rFo5U42y4tQXnBVPUqsipvRflK
         +WoO4WJaM7AmKmS07c1u47LM0fTU6JCpH4ymrOK5sAuXP8Qml1fpiGO6eeBbB3f37U31
         AR5Q==
X-Gm-Message-State: AOAM530Lk2H300SzdYsXiTE9vve9iIUdLiD3m8w0O3JV0aQNK6ysQEVA
        02v1KZd9acdLIbeVvYOTSZ+Kuw==
X-Google-Smtp-Source: ABdhPJyXJCZeuCpxmXpqp5FKxeBTTeomL3BRKFix1AtSjZfJpqxWml8B3kiSR8y7SGuQQAjMSe1H+A==
X-Received: by 2002:a05:622a:13c9:: with SMTP id p9mr375242qtk.47.1636562668626;
        Wed, 10 Nov 2021 08:44:28 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id y14sm205869qta.86.2021.11.10.08.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 08:44:28 -0800 (PST)
Date:   Wed, 10 Nov 2021 11:44:26 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     vincent.guittot@linaro.org, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        mhocko@kernel.org, vdavydov.dev@gmail.com, tj@kernel.org,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [RFC] psi: Add additional PSI counters for each type of memory
 pressure
Message-ID: <YYv26rKib03JnYZN@cmpxchg.org>
References: <1636558597-248294-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636558597-248294-1-git-send-email-quic_c_gdjako@quicinc.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 10, 2021 at 07:36:37AM -0800, Georgi Djakov wrote:
> From: Carlos Ramirez <carlrami@codeaurora.org>
> 
> Calculates psi totals for memory pressure subevents:
> compaction, thrashing, direct compaction, direct reclaim, and kswapd0.
> Uses upper 16 bits of psi_flags to track memory subevents.

Oof, that's quite heavy both in terms of branches, but also in terms
of cache - which, depending on wakeup pattern and cpu topology can
really hurt those paths.

What's the usecase? Do you have automation that needs to act on one
type of stall but not the others, for example?

I find that looking at vmstat events on hosts with elevated pressure
tends to give a pretty good idea of the source. It should also be
possible to whip up a short bpftrace script to track down culprit
callstacks of psi_memstall_*.

> @@ -1053,19 +1128,56 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
> +		seq_printf(m, "%s avg10=%lu.%02lu avg60=%lu.%02lu avg300=%lu.%02lu total=%llu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu\n",
>  			   full ? "full" : "some",
>  			   LOAD_INT(avg[0]), LOAD_FRAC(avg[0]),
>  			   LOAD_INT(avg[1]), LOAD_FRAC(avg[1]),
>  			   LOAD_INT(avg[2]), LOAD_FRAC(avg[2]),
> -			   total);
> +			   total, total_blk_cgroup_throttle, total_bio, total_compaction,
> +			   total_thrashing, total_cgroup_reclaim_high,
> +			   total_cgroup_reclaim_high_sleep, total_cgroup_try_charge,
> +			   total_direct_compaction, total_direct_reclaim, total_read_swappage,
> +			   total_kswapd);

The file format is a can of worms. I doubt we can change this at this
point without breaking parsers, so those numbers would have to live
somewhere else. But let's figure out the above questions before
worrying about this.
