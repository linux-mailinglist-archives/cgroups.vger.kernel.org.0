Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68396C6C73
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 16:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCWPnJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 11:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCWPnI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 11:43:08 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD461E1EC
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 08:43:06 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s12so26990288qtq.11
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1679586185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KS4mI5dSZp2boSr3gZdSRyxPkDeWYs2g1qOZH+GPmsA=;
        b=bp0VhDf9ovL1bSdfzbiIO0gMq8zKiy5UCvl56pjEv3yZC2e6XJiTzXreyCquV4fR7j
         CHbolL2DDZVqDX1QGbzh4DqoneGgloHixlkykX+mwgOhTScpZ0RN3cjWIl8ZnIRo4osu
         3vpBiSm7GHsppP3u3BSs0VM9W+ODBBpYeV1d15NTXPA2/ZeKakTDoSKAHSbIWSlDbKrz
         oxXVdmDMn15JnWqyPCzF7NvgKA4T9gLpEJ+o6JIdPbX+6YAuye9EmaLBGM7Mve+ZMF8s
         rtDdUu6CG1rlItGycvCEP+Rz+ZDaXImPAx1sAoc8NrTSJasuUcHon2E4DhyrGrKKmGse
         +0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS4mI5dSZp2boSr3gZdSRyxPkDeWYs2g1qOZH+GPmsA=;
        b=I5VmhB9QYqDwIPSunftfrvPeGPKD8EE1+Zaa4dwedUEYUtXO9yhgLkVR7CgFudomq3
         /4fEuc8ynuC/kTHVQDh55rYwGBejwpL8uKHhUUFnvkW8kjbfkY2DeW4oJw57xV436PxA
         5vunYVWsRNv8Qb4qq20j+coRXU88CN0f1a/1I5KlyGdVelytjoNMfAzp9fXrrZyBx2XB
         akQJ/0QACvIAPGBCLtpEsN89nwm8/wxKiD0/FMRL3KQC8CsHA8wcpqyBvKVJnWGUtWCQ
         WJWN13p/PfLf+2hYSXTnSB8eeLdraaaiTPQX1JdfOW3Wk+PKH4KOsgm/3gL7vX7WDHHs
         IB6w==
X-Gm-Message-State: AO0yUKUH/NP9ISTRVUFhA/ltlWBPJgTN7+ishecp4JDiiQ8HDcS8J0r7
        mP+VDd+IPeeSg7r3sFTh6xDOTJZUkdsZS/Kbb4I=
X-Google-Smtp-Source: AK7set9m68HsM4zsbLTLo8lzq2cUjnnMSSCWIrS35xYc1xlQGS6uWQoye655J6lJtXD51iJlGF9bUA==
X-Received: by 2002:a05:622a:38b:b0:3e3:8a0b:8c80 with SMTP id j11-20020a05622a038b00b003e38a0b8c80mr9206917qtx.41.1679586185631;
        Thu, 23 Mar 2023 08:43:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id 6-20020ac85646000000b003e3897d8505sm3329544qtt.54.2023.03.23.08.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 08:43:05 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:43:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] cgroup: rstat: remove
 cgroup_rstat_flush_irqsafe()
Message-ID: <20230323154304.GA739026@cmpxchg.org>
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-4-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323040037.2389095-4-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 23, 2023 at 04:00:33AM +0000, Yosry Ahmed wrote:
> The naming of cgroup_rstat_flush_irqsafe() can be confusing.
> It can read like "irqsave", which means that it disables
> interrupts throughout, but it actually doesn't. It is just "safe" to
> call from contexts with interrupts disabled.
> 
> Furthermore, this is only used today by mem_cgroup_flush_stats(), which
> will be changed by a later patch to optionally allow sleeping. Simplify
> the code and make it easier to reason about by instead passing in an
> explicit @may_sleep argument to cgroup_rstat_flush(), which gets passed
> directly to cgroup_rstat_flush_locked().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  block/blk-cgroup.c     |  2 +-
>  include/linux/cgroup.h |  3 +--
>  kernel/cgroup/cgroup.c |  4 ++--
>  kernel/cgroup/rstat.c  | 24 +++++-------------------
>  mm/memcontrol.c        |  6 +++---
>  5 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index bd50b55bdb61..3fe313ce5e6b 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1043,7 +1043,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
>  	if (!seq_css(sf)->parent)
>  		blkcg_fill_root_iostats();
>  	else
> -		cgroup_rstat_flush(blkcg->css.cgroup);
> +		cgroup_rstat_flush(blkcg->css.cgroup, true);
>  
>  	rcu_read_lock();
>  	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 3410aecffdb4..743c345b6a3f 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -691,8 +691,7 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
>   * cgroup scalable recursive statistics.
>   */
>  void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
> -void cgroup_rstat_flush(struct cgroup *cgrp);
> -void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp);
> +void cgroup_rstat_flush(struct cgroup *cgrp, bool may_sleep);
>  void cgroup_rstat_flush_hold(struct cgroup *cgrp);
>  void cgroup_rstat_flush_release(void);
>  
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 935e8121b21e..58df0fc379f6 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5393,7 +5393,7 @@ static void css_release_work_fn(struct work_struct *work)
>  	if (ss) {
>  		/* css release path */
>  		if (!list_empty(&css->rstat_css_node)) {
> -			cgroup_rstat_flush(cgrp);
> +			cgroup_rstat_flush(cgrp, true);
>  			list_del_rcu(&css->rstat_css_node);
>  		}
>  
> @@ -5406,7 +5406,7 @@ static void css_release_work_fn(struct work_struct *work)
>  		/* cgroup release path */
>  		TRACE_CGROUP_PATH(release, cgrp);
>  
> -		cgroup_rstat_flush(cgrp);
> +		cgroup_rstat_flush(cgrp, true);

This is an anti-pattern, please don't do this. Naked bool arguments
are a pain to comprehend at the callsite and an easy vector for bugs.

cgroup_rstat_flush_atomic() would be a better name for, well, atomic
callsites.

> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index af11e28bd055..fe8690bb1e1c 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -243,30 +243,16 @@ static bool should_skip_flush(void)
>   * This function is safe to call from contexts that disable interrupts, but
>   * @may_sleep must be set to false, otherwise the function may block.
>   */
> -__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
> +__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp, bool may_sleep)
>  {
>  	if (should_skip_flush())
>  		return;
>  
> -	might_sleep();
> -	spin_lock(&cgroup_rstat_lock);
> -	cgroup_rstat_flush_locked(cgrp, true);
> -	spin_unlock(&cgroup_rstat_lock);
> -}
> -
> -/**
> - * cgroup_rstat_flush_irqsafe - irqsafe version of cgroup_rstat_flush()
> - * @cgrp: target cgroup
> - *
> - * This function can be called from any context.
> - */
> -void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp)
> -{
> -	if (should_skip_flush())
> -		return;
> +	if (may_sleep)
> +		might_sleep();

might_sleep_if()
